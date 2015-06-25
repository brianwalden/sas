<?php

namespace Brianwalden\SAS\Models;

class Month extends BaseModel
{
    public $id;

    public $month;
    
    public function initialize()
    {
        //alias EventStart points to `event`.`startMonth`
        //alias EventStop points to `event`.`stopMonth`
        foreach (['start', 'stop'] as $prefix) {
            $field = "{$prefix}Month";
            $options = static::foreignKey($field);
            $options['alias'] = "Event{ucfirst($prefix)}";
            $this->hasMany(
                'id',
                static::nsModel('Event'),
                $field,
                $options
            );
        }
    }

    public static function uniqueKeys()
    {
        return ['month'];
    }
}
