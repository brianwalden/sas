<?php

namespace Brianwalden\SAS\Models;

class Day extends BaseModel
{
    public $id;

    public $day;
    
    public function initialize()
    {
        //alias EventStart points to `event`.`startDay`
        //alias EventStop point to `event`.`stopDay`
        foreach (['start', 'stop'] as $prefix) {
            $field = "{$prefix}Day";
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
        return ['day'];
    }
}
