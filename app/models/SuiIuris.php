<?php

namespace Brianwalden\SAS\Models;

class SuiIuris extends BaseModel
{
    public $id;

    public $suiIuris;

    public $riteId;

    public function initialize()
    {
        $this->belongsTo(
            'riteId',
            static::nsModel('Rite'),
            'id',
            static::foreignKey('riteId')
        );
        $this->hasMany(
            'id',
            static::nsModel('Province'),
            'suiIurisId',
            static::foreignKey('suiIurisId')
        );
        $this->hasMany(
            'id',
            static::nsModel('ReligiousTop'),
            'suiIurisId',
            static::foreignKey('suiIurisId')
        );
    }

    public static function uniqueKeys()
    {
        return ['suiIuris'];
    }
}
