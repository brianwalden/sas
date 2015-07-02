<?php

namespace Brianwalden\SAS\Models;

class Week extends BaseModel
{
    const IS_LOOKUP = true;
    
    public $id;

    public $week;
    
    public function initialize()
    {
        //alias EventStart points to `event`.`startWeek`
        //alias EventStop point to `event`.`stopWeek`
        foreach (['start', 'stop'] as $prefix) {
            $alias = 'Event' . ucfirst($prefix);
            $this->relationship('hasMany', 'Event', "{$prefix}Week", false, $alias);
        }
    }

    public static function uniqueKeys()
    {
        return ['week'];
    }
}
