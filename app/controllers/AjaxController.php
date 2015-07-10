<?php

namespace Brianwalden\SAS\Controllers;

use Brianwalden\SAS\Library\ChurchEvents;

class AjaxController extends BaseController
{
    public function getChurchesAction()
    {
        return $this->ajaxResponse(new ChurchEvents());
    }
}
