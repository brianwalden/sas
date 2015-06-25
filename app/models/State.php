<?php

namespace Brianwalden\SAS\Models;

class State extends BaseModel
{
    public $id;

    public $state2;

    public $state;

    public $countryId;

    public function initialize()
    {
        $this->belongsTo(
            'countryId',
            static::nsModel('Country'),
            'id',
            static::foreignKey('countryId')
        );
        $this->hasMany(
            'id',
            static::nsModel('County'),
            'stateId',
            static::foreignKey('stateId')
        );
        $this->hasMany(
            'id',
            static::nsModel('StateProp'),
            'stateId',
            static::foreignKey('stateId')
        );
    }

    public static function uniqueKeys()
    {
        return [['state2', 'countryId'], ['state', 'countryId']];
    }
}
