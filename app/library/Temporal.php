<?php

namespace Brianwalden\SAS\Library;

use Carbon\Carbon;

class Temporal extends Carbon
{
    // our days go from 1 (Sunday) to 7 (Saturday)
    public $weekDay;

    // i.e. if today is a Wednesday, which Wednesday of the month is it? 1 to 5
    public $monthWeek;

    protected $lookup;
    
    public function __construct($time = null, $tz = null)
    {
        parent::__construct($time, $tz);
        $this->weekDay = $this->dayOfWeek + 1;
        $this->monthWeek = (int) ceil($this->day / 7);
        $this->lookup = new Lookup();
    }

    public function toWeekDayString()
    {
        return $this->lookup->getValue('day', $this->weekDay);
    }

    public function toMonthWeekString()
    {
        return $this->lookup->getValue('week', $this->monthWeek);
    }

    public function toMonthString()
    {
        return $this->lookup->getValue('month', $this->month);
    }
}
