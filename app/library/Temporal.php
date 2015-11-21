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
            'isHolyDay' => $this->isHolyDay(),
            'isVigil' => $this->isVigil(),
            'isSeason' => $this->isSeason(),
            'isHoliday' => $this->isHoliday(),
            'isLastWeekOfMonth' => ($this->day > ($this->daysInMonth - 7)),
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
            $timeArray['timeHuman'] = 'Noon';
            $timeArray['timeHumanLong'] = 'Noon';
            $timeArray['timeHumanSchedule'] = 'Noon';
        } elseif ($this->hour == 24 && !$this->minute) {
            $timeArray['timeHuman'] = 'Midnight';
            $timeArray['timeHumanLong'] = 'Midnight';
            $timeArray['timeHumanSchedule'] = 'Midnight';
        }

        return $timeArray;
    }

    public function isHolyDay()
    {
        $holyDay = false;
        $weekDay = $this->getWeekDay();
        $monthWeek = $this->getMonthWeek();
        $isNotMoved = ($weekDay >= 3 && $weekDay <= 6);

        if ($this->month == 1 && $this->day == 1) {
            if ($isNotMoved) {
                $holyDay = 'the Solemnity of the Blessed Virgin Mary, the Mother of God';
            }
        } elseif ($this->month == 8 && $this->day == 15) {
            if ($isNotMoved) {
                $holyDay = 'the Solemnity of the Assumption of the Blessed Virgin Mary';
            }
        } elseif ($this->month == 11 && $this->day == 1) {
            if ($isNotMoved) {
                $holyDay = 'the Solemnity of All Saints';
            }
        } elseif ($this->month == 12) {
            if ($this->day == 8 && $weekDay != 1) {
                $holyDay = 'the Solemnity of the Immaculate Conception of the Blessed Virgin Mary';
            } elseif ($this->day == 25) {
                $holyDay = 'the Solemnity of the Nativity of the Lord (Christmas)';
            }
        } elseif ($this->month >= 2 && $this->month <=6) {
            $dateString = $this->toDateString();
            $easter = $this->getEaster();

            if ($easter) {
                if ($dateString == $easter->toDateString()) {
                    $holyDay = 'the Solemnity of the Resurrection of the Lord (Easter)';
                } elseif ($dateString == $easter->copy()->subDays(46)->toDateString()) {
                    $holyDay = 'Ash Wednesday';
                } elseif ($dateString == $easter->copy()->subDays(6)->toDateString()) {
                    $holyDay = 'Monday of Holy Week';
                } elseif ($dateString == $easter->copy()->subDays(5)->toDateString()) {
                    $holyDay = 'Tuesday of Holy Week';
                } elseif ($dateString == $easter->copy()->subDays(4)->toDateString()) {
                    $holyDay = 'Wednesday of Holy Week';
                } elseif ($dateString == $easter->copy()->subDays(3)->toDateString()) {
                    $holyDay = 'Holy Thursday of the Lord\'s Supper';
                } elseif ($dateString == $easter->copy()->subDays(2)->toDateString()) {
                    $holyDay = 'Holy Friday of the Lord\'s Passion';
                } elseif ($dateString == $easter->copy()->subDays(1)->toDateString()) {
                    $holyDay = 'Holy Saturday';
                } elseif ($dateString == $easter->copy()->addDays(39)->toDateString()) {
                    $holyDay = 'the Solemnity of the Ascension of the Lord';
                }
            }
        }

        return $holyDay;
    }

    public function isVigil()
    {
        $vigil = false;
        $holyDay = $this->copy()->addDay()->isHolyDay();
        $noVigil = [
            'the Solemnity of the Resurrection of the Lord (Easter)' => true,
            'Ash Wednesday' => true,
            'Monday of Holy Week' => true,
            'Tuesday of Holy Week' => true,
            'Wednesday of Holy Week' => true,
            'Holy Thursday of the Lord\'s Supper' => true,
            'Holy Friday of the Lord\'s Passion' => true,
            'Holy Saturday' => true,
        ];

        if ($holyDay && empty($noVigil[$holyDay])) {
            $vigil = "the Vigil of $holyDay";
        }

        return $vigil;
    }

    public function isSeason()
    {
        $season = false;
        $dateString = $this->toDateString();

        if ($this->month == 1 || $this->month == 11 || $this->month == 12) {
            if ($dateString < "{$this->year}-12-25") {
                $christmas = new Temporal("{$this->year}-12-25", null, $this->getLookup());
                $weekDay = 0;

                while ($weekDay != 1) {
                    $christmas->subDay();
                    $weekDay = $christmas->subDay()->getWeekDay();
                }

                if ($dateString >= $christmas->subWeeks(3)->toDateString()) {
                    $season = 'Advent';
                }
            } else {
                $year = ($this->month == 1) ? $this->year  : $this->year + 1;
                $ephiphany = new Temporal("{$year}-01-06", null, $this->getLookup());
                $weekDay = 0;

                while ($weekDay != 1) {
                    $weekDay = $epiphany->addDay()->getWeekDay();
                }

                if ($dateString <= $epiphany->toDateString()) {
                    $season = 'Christmas';
                }
            }
        } elseif ($this->month >= 2 && $this->month <= 6) {
            $easter = $this->getEaster();
            $ashWednesday = $easter->copy()->subDays(46)->toDateString();
            $holyThursday = $easter->copy()->subDays(3)->toDateString();
            $pentecost = $easter->copy()->addDays(49)->toDateString();

            if ($ashWednesday <= $dateString && $dateString <= $pentecost) {
                if ($easter->toDateString() <= $dateString) {
                    $season = 'Easter';
                } else {
                    $season = ($holyThursday <= $dateString) ? 'Triduum' : 'Lent';
                }
            }
        }

        return $season;
    }

    public function isHoliday()
    {
        $holiday = false;
        $weekDay = $this->getWeekDay();
        $monthWeek = $this->getMonthWeek();

        if ($weekDay == 2) {
            if ($this->month == 9 && $monthWeek == 1) {
                $holiday = "Labor Day";
            } elseif ($this->month == 10 && $monthWeek == 2) {
                $holiday = "Columbus Day";
            } elseif ($monthWeek == 3) {
                if ($this->month == 1) {
                    $holiday = "Martin Luther King, Jr. Day";
                } elseif ($this->month == 2) {
                    $holiday = "Presidents Day";
                }
            } elseif ($this->month == 5 && $this->day >= 25) {
                $holiday = "Memorial Day";
            }
        } elseif ($this->month == 7 && $this->day == 4 && $weekDay != 1) {
            $holiday = "Independence Day";
        } elseif ($this->month == 11) {
            if ($this->day == 11 && $weekDay != 1) {
                $holiday = "Veterans Day";
            } elseif ($weekDay == 5 && $monthWeek == 4) {
                $holiday = "Thanksgiving";
            }
        }

        return $holiday;
    }

    public function getEaster()
    {
        $temporal = null;
        $easter = [
            '2000' => '2000-04-23',
            '2001' => '2001-04-15',
            '2002' => '2002-03-31',
            '2003' => '2003-04-20',
            '2004' => '2004-04-11',
            '2005' => '2005-03-27',
            '2006' => '2006-04-16',
            '2007' => '2007-04-08',
            '2008' => '2008-03-23',
            '2009' => '2009-04-12',
            '2010' => '2010-04-04',
            '2011' => '2011-04-24',
            '2012' => '2012-04-08',
            '2013' => '2013-03-31',
            '2014' => '2014-04-20',
            '2015' => '2015-04-05',
            '2016' => '2016-03-27',
            '2017' => '2017-04-16',
            '2018' => '2018-04-01',
            '2019' => '2019-04-21',
            '2020' => '2020-04-12',
            '2021' => '2021-04-04',
            '2022' => '2022-04-17',
            '2023' => '2023-04-09',
            '2024' => '2024-03-31',
            '2025' => '2025-04-20',
            '2026' => '2026-04-05',
            '2027' => '2027-03-28',
            '2028' => '2028-04-16',
            '2029' => '2029-04-01',
            '2030' => '2030-04-21',
            '2031' => '2031-04-13',
            '2032' => '2032-03-28',
            '2033' => '2033-04-17',
            '2034' => '2034-04-09',
            '2035' => '2035-03-25',
        ];

        if (isset($easter[$this->year])) {
            $temporal = new Temporal($easter[$this->year], null, $this->getLookup());
        }

        return $temporal;
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
