<?php

namespace Brianwalden\SAS\Models;

class EventFilter extends BaseModel
{
    public $id;

    public $eventFilter;
    
    public function initialize()
    {
        $this->hasMany(
            'id',
            static::nsModel('Event'),
            'eventFilterId',
            static::foreignKey('eventFilterId')
        );
    }

    public static function uniqueKeys()
    {
        return ['eventFilter'];
    }
}
