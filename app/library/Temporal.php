<?php

namespace Brianwalden\SAS\Library;

use Carbon\Carbon;

class Temporal extends Carbon
{
    protected $lookup;

    public function __construct($time = null, $tz = null, Lookup $lookup = null)
    {
        parent::__construct($time, $tz);
        $this->lookup = $lookup;
    }

    public function getNew($time = null, $tz = null)
    {
        return new static($time, $tz, $this->lookup);
    }

    // our days go from 1 (Sunday) to 7 (Saturday)
    public function getWeekDay()
    {
        return $this->dayOfWeek + 1;
    }

    // i.e. if today is a Wednesday, which Wednesday of the month is it? 1 to 5
    public function getMonthWeek()
    {
        return (int) ceil($this->day / 7);
    }

    public function toWeekDayString()
    {
        return $this->lookupValue('Day', $this->getWeekDay());
    }

    public function toMonthWeekString()
    {
        return $this->lookupValue('Week', $this->getMonthWeek());
    }

    public function toMonthString()
    {
        return $this->lookupValue('Month', $this->month);
    }

    public function toHumanDate($includeDayOfWeek = false)
    {
        $includeDayOfWeek = ($includeDayOfWeek) ? 'l, ': '';
        return $this->format($includeDayOfWeek . 'F jS, Y');
    }

    public function toHumanTime()
    {
        return $this->format('gi:a');
    }

    protected function lookupValue($model, $value)
    {
        if (!isset($this->lookup)) {
            $this->lookup = Lookup::getShared();
        }

        return $this->lookup->getValue($model, $value);
    }
}
