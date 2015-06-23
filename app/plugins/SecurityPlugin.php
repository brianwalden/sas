<?php

namespace Brianwalden\SAS\Plugins;

use Phalcon\Acl;
use Phalcon\Acl\Role;
use Phalcon\Acl\Resource;
use Phalcon\Events\Event;
use Phalcon\Mvc\User\Plugin;
use Phalcon\Mvc\Dispatcher;
use Phalcon\Acl\Adapter\Memory as AclList;

/**
 * SecurityPlugin
 *
 * This is the security plugin which controls that users only have access to the modules they're assigned to
 */
class SecurityPlugin extends Plugin
{
    /**
     * I don't see this site having an extensive section that requires
     * authorization, so for convenience set the default action to ALLOW
     */
    const DEFAULT_ACTION = "ALLOW";

    /**
     * Roles and their resources
     *
     * IMPORTANT: roles in this array must be in top-down heirarchical order,
     * this first role will have all the permissions of roles underneath it
     *
     * @var array
     */
    protected static $roles = [
        'Users' => [
            // 'controller' => ['action1', 'action2'],
        ],
        'Guests' => [
            // 'controller' => ['action1', 'action2'],
        ],
    ];

    protected $properties = ['acl' => null, 'roles' => null];

    /**
     * Returns an existing or new access control list
     *
     * @return AclList
     */
    public function getAcl()
    {
        if (!isset($this->persistent->acl)) {
            foreach (static::$roles as $role => $resources) {
                $this->registerResources($role, $resources);
            }

            $this->setPersistentAcl();
        }

        return $this->persistent->acl;
    }

    /**
     * This action is executed before execute any action in the application
     *
     * @param Event $event
     * @param Dispatcher $dispatcher
     *
     * @return boolean success
     */
    public function beforeDispatch(Event $event, Dispatcher $dispatcher)
    {
        $success = true;
        $acl = $this->getAcl();
        $allowed = $acl->isAllowed(
            ($this->session->get('auth')) ? 'Users' : 'Guests',
            $dispatcher->getControllerName(),
            $dispatcher->getActionName()
        );
        
        if ($allowed != Acl::ALLOW) {
            $dispatcher->forward([
                'controller' => 'status',
                'action' => 'index',
                'params' => [401],
            ]);
            $this->session->destroy();
        }

        return $success;
    }

    /**
     * Create a new local acl
     *
     * @param boolean $forceNewAcl create new acl even if one exists
     *
     * @return boolean was a new acl created or not
     */
    protected function newAcl($forceNewAcl = false)
    {
        $created = false;

        if ($forceNewAcl || !$this->properties['acl']) {
            $action = (static::DEFAULT_ACTION === 'ALLOW') ? Acl::ALLOW : Acl::DENY;
            $this->properties['acl'] = new AclList();
            $this->properties['acl']->setDefaultAction($action);
            $this->properties['roles'] = [];
            $created = true;
        }

        return $created;
    }

    /**
     * Set the persistent acl to our local acl
     *
     * @return boolean success
     */
    protected function setPersistentAcl()
    {
        $success = (bool) $this->properties['acl'];

        if ($success) {
            $this->persistent->acl = $this->properties['acl'];

            foreach ($this->properties as $key => $value) {
                $this->properties[$key] = null;
            }
        }

        return $success;
    }

    /**
     * Add a role to the local acl
     *
     * @param string $role the role to register with the acl
     *
     * @return boolean is role registered or not
     */
    protected function registerRole($role)
    {
        $this->newAcl();
        $isRegistered = array_key_exists($role, $this->properties['roles']);

        if (array_key_exists($role, static::$roles) && !$isRegistered) {
            $this->properties['acl']->addRole(new Role($role));
            $this->properties['roles'][$role] = true;
            $isRegistered = true;
        }

        return $isRegistered;
    }

    /**
     * Add a resource to the local acl
     *
     * @param  string $role the role the resources belong to
     * @param  array $resources the resources to register
     *
     * @return boolean were the resources registered or not
     */
    protected function registerResources($role, $resources)
    {
        $success = $this->registerRole($role);

        if ($success) {
            foreach ($resources as $controller => $actions) {
                $permission = 'allow';
                $this->properties['acl']->addResource(
                    new Resource($controller),
                    $actions
                );
            
                foreach (array_keys(static::$roles) as $currentRole) {
                    $this->registerRole($currentRole);
                    
                    foreach ($actions as $action) {
                        $this->properties['acl']->$permission(
                            $currentRole,
                            $controller,
                            $action
                        );
                    }

                    if ($role === $currentRole) {
                        $permission = 'deny';
                    }
                }
            }
        }

        return $success;
    }
}
