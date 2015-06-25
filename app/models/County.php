<?php

namespace Brianwalden\SAS\Models;

class County extends BaseModel
{
    public $id;

    public $county;

    public $stateId;

    public function initialize()
    {
        $this->belongsTo(
            'stateId',
            static::nsModel('State'),
            'id',
            static::foreignKey('stateId')
        );
        $this->hasMany(
            'id',
            static::nsModel('City'),
            'countyId',
            static::foreignKey('countyId')
        );
        $this->hasMany(
            'id',
            static::nsModel('CountyProp'),
            'countyId',
            static::foreignKey('countyId')
        );
    }

    public static function uniqueKeys()
    {
        return [['county', 'stateId']];
    }
}
