<?php

namespace Brianwalden\SAS\Models;

use Brianwalden\SAS\Library\Temporal;

class Event extends BaseModel
{
    public $id;

    public $event;

    public $eventTypeId;

    public $eventFilterId;

    public $churchId;

    public $startDate;

    public $stopDate;

    public $startMonth;

    public $stopMonth;
    
    public $startWeek;

    public $stopWeek;
    
    public $startDay;

    public $stopDay;
    
    public $startTime;

    public $stopTime;
    
    public function initialize()
    {
        $this->relationship('belongsTo', 'EventType', 'eventTypeId', false);
        $this->relationship('belongsTo', 'EventFilter', 'eventFilterId', false);
        $this->relationship('belongsTo', 'Church', 'churchId', false);

        //startMonth, stopMonth, startWeek, stopWeek, startDay, stopDay
        foreach (['Month', 'Week', 'Day'] as $model) {
            foreach (['start', 'stop'] as $prefix) {
                $field = "$prefix$model";
                $this->relationship('belongsTo', $model, $field, false, ucfirst($field));
            }
        }

        $this->relationship('hasMany', 'EventProp', 'eventId', false);
    }

    public static function uniqueKeys()
    {
        return [[
            'event',
            'eventTypeId',
            'eventFilterId',
            'churchId',
            'startDate',
            'stopDate',
            'startMonth',
            'stopMonth',
            'startWeek',
            'stopWeek',
            'startDay',
            'stopDay',
            'startTime',
            'stopTime',
        ]];
    }

    public static function defaultFields()
    {
        return [
            'event',
            'eventFilterId',
            'startDate',
            'stopDate',
            'startMonth',
            'stopMonth',
            'startWeek',
            'stopWeek',
            'startDay',
            'stopDay',
            'startTime',
            'stopTime',
        ];
    }
}
