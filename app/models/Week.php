<?php

namespace Brianwalden\SAS\Models;

class Week extends BaseModel
{
    public $id;

    public $week;
    
    public function initialize()
    {
        //alias EventStart points to `event`.`startWeek`
        //alias EventStop point to `event`.`stopWeek`
        foreach (['start', 'stop'] as $prefix) {
            $field = "{$prefix}Week";
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
        return ['week'];
    }
}
