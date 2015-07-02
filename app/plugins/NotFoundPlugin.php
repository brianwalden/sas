<?php

namespace Brianwalden\SAS\Plugins;

use Phalcon\Events\Event;
use Phalcon\Mvc\User\Plugin;
use Phalcon\Dispatcher;
use Phalcon\Exception;

/**
 * NotFoundPlugin
 *
 * Handles not-found controller/actions
 */
class NotFoundPlugin extends Plugin
{
    /**
     * This action is executed before execute any action in the application
     *
     * @param $event
     * @param $dispatcher
     * @param $exception
     *
     * @return boolean false
     */
    public function beforeException($event, $dispatcher, $exception)
    {
        $statusCode = 500;

        if ($exception instanceof Exception) {
            switch ($exception->getCode()) {
                case Dispatcher::EXCEPTION_HANDLER_NOT_FOUND:
                case Dispatcher::EXCEPTION_ACTION_NOT_FOUND:
                    $statusCode = 404;
            }
        }
        
        if ($dispatcher instanceof Dispatcher) {
            $dispatcher->forward([
                'controller' => 'status',
                'action' => 'index',
                'params' => [$statusCode, $exception],
            ]);
        }

        return false;
    }
}
