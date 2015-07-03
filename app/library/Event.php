<?php

namespace Brianwalden\SAS\Library;

class Event
{
    protected $temporal;

    protected $lookup;

    public function __construct(Temporal $temporal = null)
    {
        $this->lookup = Lookup::getshared();
        $this->temporal = ($temporal) ? $temporal : new Temporal(null, null, $this->lookup);
    }

    public function getToday($type = null, $name = null, $onlyNow = false)
    {
        return $this->find($this->today($this->eventTypeAndName($type, $name), $onlyNow));
    }

    public function find(array $options = array())
    {
        $exactOptions = ['event', 'eventTypeId', 'eventFilterId', 'churchId'];
        $rangeOptions = ['date', 'month', 'week', 'day', 'time'];
        $phql = 'SELECT e.churchId, n.value AS nickname, e.startTime, e.stopTime FROM ' .
            Model::nsModel('Event') . ' AS e LEFT JOIN ' . Model::nsModel('Church') .
            ' AS c LEFT JOIN ' . Model::nsModel('ChurchProp') . ' AS n ON ' .
            '(c.id = n.churchId AND n.churchAttrId = :nickname: AND n.multi = 1)';
        $bind = ['nickname' => $this->lookup->getId('ChurchAttr', 'nickname')];
        $separator = ' WHERE ';

        foreach ($exactOptions as $option) {
            if (isset($options[$option])) {
                $phql .= "$separator$option ";
                $separator = ' AND ';

                if (is_array($options[$option])) {
                    $i = 0;
                    $placeholders = [];
                    foreach ($options[$option] as $key => $value) {
                        $i++;
                        $placeholders[] = ":$option$i:";
                        $bind["$option$i"] = $value;
                    }
                    $phql .= 'in (' . implode(', ', $placeholders) . ')';
                } else {
                    $phql .= "= :$option:";
                    $bind[$option] = $options[$option];
                }
            }
        }

        foreach ($rangeOptions as $option) {
            if (isset($options[$option])) {
                $ucfo = ucfirst($option);
                $startStop = [
                    "start$ucfo" => '<=',
                    "stop$ucfo" => '>='
                ];
                foreach ($startStop as $field => $operator) {
                    $phql .= "$separator$field $operator :$field:";
                    $bind[$field] = $options[$option];
                    $separator = ' AND ';
                }
            }
        }

        $phql .= ' ORDER BY e.startTime, e.stopTime';
        return Model::query($phql, $bind);
    }

    protected function today(array $options = array(), $addTime = false)
    {
        $options['date'] = $this->temporal->toDateString();
        $options['month'] = $this->temporal->month;
        $options['week'] = $this->temporal->getMonthWeek();
        $options['day'] = $this->temporal->getWeekDay();
        
        if ($addTime) {
            $options['time'] = $this->temporal->toTimeString();
        }

        return $options;
    }

    protected function eventTypeAndName($type = null, $name = null)
    {
        $typeIds = [];
        $types = (is_array($type)) ? $type : [$type];
        $typeCount = 0;

        foreach ($types as $t) {
            if ($t) {
                $id = $this->lookup->getId('EventType', $t);
                if ($id) {
                    $typeIds[] = $id;
                    $typeCount++;
                }
            }
        }

        if ($typeCount <= 1) {
            $typeIds = ($typeCount) ? $typeIds[0] : null;
        }
        
        return [
            'event' => $name,
            'eventTypeId' => $typeIds,
            'eventFilterId' => [
                $this->lookup->getId('EventFilter', ""),
                $this->lookup->getId('EventFilter', "not holy day or vigil"),
            ],
        ];
    }
}
