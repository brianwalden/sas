<?php

namespace Brianwalden\SAS\Models;

class City extends BaseModel
{
    public $id;

    public $city;

    public $countyId;

    public function initialize()
    {
        $this->belongsTo(
            'countyId',
            static::nsModel('County'),
            'id',
            static::foreignKey('countyId')
        );
        $this->hasMany(
            'id',
            static::nsModel('Church'),
            'cityId',
            static::foreignKey('cityId')
        );
        $this->hasMany(
            'id',
            static::nsModel('CityProp'),
            'cityId',
            static::foreignKey('cityId')
        );
    }

    public static function uniqueKeys()
    {
        return [['city', 'countyId']];
    }
}
