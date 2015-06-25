<?php

namespace Brianwalden\SAS\Models;

class Continent extends BaseModel
{
    public $id;

    public $continent;

    public function initialize()
    {
        $this->hasMany(
            'id',
            static::nsModel('Country'),
            'continentId',
            static::foreignKey('continentId')
        );
        $this->hasMany(
            'id',
            static::nsModel('ContinentProp'),
            'continentId',
            static::foreignKey('continentId')
        );
    }

    public static function uniqueKeys()
    {
        return ['continent'];
    }
}
