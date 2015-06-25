<?php

namespace Brianwalden\SAS\Models;

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
        $this->belongsTo(
            'eventTypeId',
            static::nsModel('EventType'),
            'id',
            static::foreignKey('eventTypeId')
        );
        $this->belongsTo(
            'eventFilterId',
            static::nsModel('EventFilter'),
            'id',
            static::foreignKey('eventFilterId')
        );
        $this->belongsTo(
            'churchId',
            static::nsModel('Church'),
            'id',
            static::foreignKey('churchId')
        );

        //startMonth, stopMonth, startWeek, stopWeek, startDay, stopDay
        foreach (['Month', 'Week', 'Day'] as $model) {
            foreach (['start', 'stop'] as $prefix) {
                $field = "$prefix$model";
                $options = static::foreignKey($field);
                $options['alias'] = ucfirst($field);
                $this->belongsTo(
                    $field,
                    static::nsModel($model),
                    'id',
                    $options
                );
            }
        }

        $this->hasMany(
            'id',
            static::nsModel('EventProp'),
            'eventId',
            static::foreignKey('eventId')
        );
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
