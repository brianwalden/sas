<?php

namespace Brianwalden\SAS\Models;

class Day extends BaseModel
{
    const IS_LOOKUP = true;
    
    public $id;

    public $day;
    
    public function initialize()
    {
        //alias EventStart points to `event`.`startDay`
        //alias EventStop point to `event`.`stopDay`
        foreach (['start', 'stop'] as $prefix) {
            $alias = 'Event' . ucfirst($prefix);
            $this->relationship('hasMany', 'Event', "{$prefix}Day", false, $alias);
        }
    }

    public static function uniqueKeys()
    {
        return ['day'];
    }
}
