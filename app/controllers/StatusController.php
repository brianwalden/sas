<?php

namespace Brianwalden\SAS\Controllers;

class StatusController extends BaseController
{
    const DIR_BASE = '/home/brianwalden/sas';

    public function indexAction()
    {
        $message = '';
        $exception = isset($this->params[1]) ? $this->params[1] : null;
        
        if ($exception) {
            $message = str_replace(
                static::DIR_BASE . '/public',
                '',
                (string) $exception
            );
            $message = str_replace(static::DIR_BASE, '/..', $message);
        }

        $this->view->setvars([
            'statusCode' => isset($this->params[0]) ? $this->params[0] : 0,
            'errorMessage' => $message,
        ]);
    }
}
