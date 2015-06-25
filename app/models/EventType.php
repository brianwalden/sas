<?php

namespace Brianwalden\SAS\Models;

class EventType extends BaseModel
{
    public $id;

    public $eventType;
    
    public function initialize()
    {
        $this->hasMany(
            'id',
            static::nsModel('Event'),
            'eventTypeId',
            static::foreignKey('eventTypeId')
        );
    }

    public static function uniqueKeys()
    {
        return ['eventType'];
    }
}
