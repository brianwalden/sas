<?php

namespace Brianwalden\SAS\Models;

class City extends BaseModel
{
    public $id;

    public $city;

    public $countyId;

    public function initialize()
    {
        $this->relationship('belongsTo', 'County', 'countyId', false);
        $this->relationship('hasMany', 'Church', 'cityId', false);
        $this->relationship('hasMany', 'CityProp', 'cityId', false);
    }

    public static function uniqueKeys()
    {
        return [['city', 'countyId']];
    }
}
