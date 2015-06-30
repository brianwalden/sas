<?php

namespace Brianwalden\SAS\Library;

class Event
{
    protected $temporal;

    protected $lookup;

    protected $query;

    public function __construct(array $options = array())
    {
        foreach (['time', 'timezone'] as $option) {
            if (!array_key_exists($option, $options)) {
                $options[$option] = null;
            }
        }

        $this->temporal = new Temporal($options['time'], $options['timezone']);
        $this->lookup = new Lookup();
        $this->query = new Query();
    }

    public function getToday($type = null, $name = null)
    {
        return $this->find($this->today($this->eventTypeAndName($type, $name)));
    }

    public function getNow($type = null, $name = null)
    {
        return $this->find($this->today($this->eventTypeAndName($type, $name), true));
    }

    public function find(array $options = array())
    {
        $exactOptions = ['event', 'eventType', 'eventFilter', 'churchId'];
        $rangeOptions = ['date', 'month', 'week', 'day', 'time'];
        $conditions = '';
        $bind = [];

        foreach ($exactOptions as $option) {
            if (isset($options[$option])) {
                $separator = ($conditions) ? ' and ' : '';
                if (is_array($options[$option])) {
                    $i = 0;
                    $bindIn = [];
                    
                    foreach ($options[$option] as $o) {
                        $i++;
                        $bindIn["$option$i"] = $o;
                        $bind["options$i"] = $o;
                    }

                    $conditions .= "$separator$option in ({Query::in($bindIn)})";
                } else {
                    $conditions .= "$separator$option = :$option:";
                    $bind[$option] = $options[$option];
                }
            }
        }
    }

    protected function today(array $options = array(), $addTime = false)
    {
        $options['date'] = $this->temporal->toDateString();
        $options['month'] = $this->temporal->month;
        $options['week'] = $this->temporal->monthWeek;
        $options['day'] = $this->temporal->weekDay;
        
        if ($addTime) {
            $options['time'] = $this->temporal->toTimeString();
        }

        return $options;
    }

    protected function eventTypeAndName($type = null, $name = null)
    {
        $typeIds = [];
        $types = (is_array($type)) ? $type : [$type];

        foreach ($types as $t) {
            if ($t) {
                $id = $this->lookup->getId($t);
                if ($id) {
                    $typeIds = $id;
                }
            }
        }

        if (count($typeIds) == 1) {
            $typeIds = $typeIds[0];
        }
        
        return ['name' => $name, 'type' => ($typeIds) ? $typeIds : null ];
    }
}
