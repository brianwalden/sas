<?php

namespace Brianwalden\SAS\Models;

class Continent extends BaseModel
{
    const IS_LOOKUP = true;

    public $id;

    public $continent;

    public function initialize()
    {
        $this->relationship('hasMany', 'Country', 'continentId', false);
        $this->relationship('hasMany', 'ContinentProp', 'continentId', false);
    }

    public static function uniqueKeys()
    {
        return ['continent'];
    }
}
