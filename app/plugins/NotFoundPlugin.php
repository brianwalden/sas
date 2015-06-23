<?php

namespace Brianwalden\SAS\Plugins;

use Phalcon\Events\Event;
use Phalcon\Mvc\User\Plugin;
use Phalcon\Dispatcher;
use Phalcon\Mvc\Dispatcher\Exception as MvcException;
use Phalcon\Mvc\Dispatcher as MvcDispatcher;

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
     * @param Event $event
     * @param MvcDispatcher $dispatcher
     * @param MvcException $exception
     *
     * @return boolean false
     */
    public function beforeException(Event $event, MvcDispatcher $dispatcher, MvcException $exception)
    {
        $statusCode = 500;

        if ($exception instanceof MvcException) {
            switch ($exception->getCode()) {
                case Dispatcher::EXCEPTION_HANDLER_NOT_FOUND:
                case Dispatcher::EXCEPTION_ACTION_NOT_FOUND:
                    $statusCode = 404;
            }
        }
        
        $dispatcher->forward([
            'controller' => 'status',
            'action' => 'index',
            'params' => [$statusCode, $exception],
        ]);

        return false;
    }
}
