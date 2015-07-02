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
        $this->relationship('belongsTo', 'Continent', 'continentId', false);
        $this->relationship('hasMany', 'State', 'countryId', false);
        $this->relationship('hasMany', 'CountryProp', 'countryId', false);
    }

    public static function uniqueKeys()
    {
        return ['country2', 'country3', 'country'];
    }
}
