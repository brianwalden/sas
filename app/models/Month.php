<?php

namespace Brianwalden\SAS\Models;

class Month extends BaseModel
{
    const IS_LOOKUP = true;

    public $id;

    public $month;
    
    public function initialize()
    {
        //alias EventStart points to `event`.`startMonth`
        //alias EventStop points to `event`.`stopMonth`
        foreach (['start', 'stop'] as $prefix) {
            $alias = 'Event' . ucfirst($prefix);
            $this->relationship('hasMany', 'Event', "{$prefix}Month", false, $alias);
        }
    }

    public static function uniqueKeys()
    {
        return ['month'];
    }
}
