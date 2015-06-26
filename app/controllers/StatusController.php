<?php

namespace Brianwalden\SAS\Controllers;

class StatusController extends BaseController
{
    public function indexAction()
    {
        $appPath = rtrim(APP_PATH, '/');
        $message = '';
        $exception = isset($this->params[1]) ? $this->params[1] : null;
        
        if ($exception) {
            $message = str_replace(
                "$appPath/public",
                '',
                (string) $exception
            );
            $message = str_replace($appPath, '/..', $message);
        }

        $this->view->setvars([
            'statusCode' => isset($this->params[0]) ? $this->params[0] : 0,
            'errorMessage' => $message,
        ]);
    }
}
