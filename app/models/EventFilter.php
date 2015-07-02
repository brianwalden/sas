<?php

namespace Brianwalden\SAS\Models;

class EventFilter extends BaseModel
{
    const IS_LOOKUP = true;
    
    public $id;

    public $eventFilter;
    
    public function initialize()
    {
        $this->relationship('hasMany', 'Event', 'eventFilterId', false);
        $this->relationship('hasMany', 'EventFilterProp', 'eventFilterId', false);
    }

    public static function uniqueKeys()
    {
        return ['eventFilter'];
    }
}
