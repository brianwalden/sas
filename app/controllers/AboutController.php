<?php

namespace Brianwalden\SAS\Controllers;

class AboutController extends BaseController
{
    public function indexAction()
    {
         $this->view->setVars(['onload' => 'saintAnthonySearch.fillContact()']);
    }
}
