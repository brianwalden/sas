<?php

namespace Brianwalden\SAS\Controllers;

use Brianwalden\SAS\Library\Event;

class IndexController extends BaseController
{
    public function indexAction()
    {
        $this->addAssets([
            'addJs' => [
                "https://www.google.com/jsapi?autoload={'modules':[{'name':'visualization',
       'version':'1','packages':['timeline']}]}" => false,
                'js/timeline.js' => true,
            ],
        ]);
        $event = new Event();
        $this->view->setVars(['confession' => $event->getToday('confession')]);
    }
}
