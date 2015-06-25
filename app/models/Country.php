<?php

namespace Brianwalden\SAS\Models;

class Country extends BaseModel
{
    public $id;

    public $country2;

    public $country3;

    public $country;

    public $contentId;

    public function initialize()
    {
        $this->belongsTo(
            'continentId',
            static::nsModel('Continent'),
            'id',
            static::foreignKey('continentId')
        );
        $this->hasMany(
            'id',
            static::nsModel('State'),
            'countryId',
            static::foreignKey('countryId')
        );
        $this->hasMany(
            'id',
            static::nsModel('CountryProp'),
            'countryId',
            static::foreignKey('countryId')
        );
    }

    public static function uniqueKeys()
    {
        return ['country2', 'country3', 'country'];
    }
}
