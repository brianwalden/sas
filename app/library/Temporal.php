<?php

namespace Brianwalden\SAS\Library;

use Carbon\Carbon;

class Temporal extends Carbon
{
    protected $lookup;

    public function __construct($time = null, $tz = null, Lookup $lookup = null)
    {
        parent::__construct($time, $tz);
        $this->setLookup($lookup);
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
        return $this->lookup->getValue('Day', $this->getWeekDay());
    }

    public function toMonthWeekString()
    {
        return $this->lookup->getValue('Week', $this->getMonthWeek());
    }

    public function toMonthString()
    {
        return $this->lookup->getValue('Month', $this->month);
    }

    public function toHumanDate($includeDayOfWeek = false)
    {
        $includeDayOfWeek = ($includeDayOfWeek) ? 'l, ': '';
        return $this->format($includeDayOfWeek . 'F jS, Y');
    }

    public function toHumanTime($includeAmPm = false)
    {
        $includeAmPm = ($includeAmPm) ? ' a' : '';
        return $this->format("g:i$includeAmPm");
    }

    public function getDateProperties()
    {
        return [
            'date' => $this->toDateString(),
            'dateHuman' => $this->toHumanDate(),
            'dateHumanLong' => $this->toHumanDate(true),
            'year' => $this->year,
            'month' => $this->month,
            'monthJs' => $this->month - 1,
            'monthHuman' => $this->toMonthString(),
            'day' => $this->day,
            'dayHuman' => $this->format('jS'),
            'weekOfMonth' => $this->getMonthWeek(),
            'weekOfMonthHuman' => $this->toMonthWeekString(),
            'dayOfWeek' => $this->getWeekDay(),
            'dayOfWeekHuman' => $this->toWeekDayString(),
            'isToday' => $this->isToday(),
        ];
    }

    public function getTimeProperties()
    {
        $timeArray = [
            'time' => $this->toTimeString(),
            'timeHuman' => $this->toHumanTime(),
            'timeHumanLong' => $this->toHumanTime(true),
            'hour' => $this->hour,
            'hourHuman' => $this->format('g'),
            'minute' => $this->minute,
            'minuteHuman' => $this->format('i'),
            'second' => $this->second,
            'secondHuman' => $this->format('s'),
            'ampm' => $this->format('a'),
        ];

        $timeArray['timeHumanSchedule'] = $timeArray['timeHuman'];
        $timeArray['timeHumanSchedule'] .= ($timeArray['ampm'] == 'am') ?
            '<span class="hidden-sm"> </span>a<span class="hidden-sm">m</span>' :
            '<span class="hidden-sm"> </span>p<span class="hidden-sm">m</span>';

        if ($this->hour == 12 && !$this->minute) {
            $timeArray['timeHuman'] = 'noon';
            $timeArray['timeHumanLong'] = 'noon';
            $timeArray['timeHumanSchedule'] = 'noon';
        } elseif ($this->hour == 24 && !$this->minute) {
            $timeArray['timeHuman'] = 'midnight';
            $timeArray['timeHumanLong'] = 'midnight';
            $timeArray['timeHumanSchedule'] = 'midnight';
        }

        return $timeArray;
    }

    public function getLookup()
    {
        return $this->lookup;
    }

    public function setLookup(Lookup $lookup = null)
    {
        if ($lookup) {
            $this->lookup = $lookup;
        } elseif (empty($this->lookup)) {
            $this->lookup = Lookup::getShared();
        }
    }
}
