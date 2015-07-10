<?php

namespace Brianwalden\SAS\Controllers;

use Brianwalden\SAS\Library\ChurchEvents;

class IndexController extends BaseController
{
    public function indexAction()
    {
        $googleCharts = "https://www.google.com/jsapi?autoload={'modules':" .
            "[{'name':'visualization','version':'1','packages':['timeline']}]}";
        $this->addAssets(['footerJs' => ['addJs' => [
            $googleCharts => false,
            'js/timeline.js' => true,
        ]]]);
        $this->view->setVars(['onload' => 'sasTimeline.initialize()']);
    }
}
