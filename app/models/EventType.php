<?php

namespace Brianwalden\SAS\Models;

class EventType extends BaseModel
{
    const IS_LOOKUP = true;

    public $id;

    public $eventType;
    
    public function initialize()
    {
        $this->relationship('hasMany', 'Event', 'eventTypeId', false);
        $this->relationship('hasMany', 'EventTypeProp', 'eventTypeId', false);
    }

    public static function uniqueKeys()
    {
        return ['eventType'];
    }
}
