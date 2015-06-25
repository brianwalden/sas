<?php

namespace Brianwalden\SAS\Models;

class Rite extends BaseModel
{
    public $id;

    public $rite;

    public $traditionId;

    public function initialize()
    {
        $this->belongsTo(
            'tradtionId',
            static::nsModel('Tradition'),
            'id',
            static::foreignKey('traditionId')
        );
        $this->hasMany(
            'id',
            static::nsModel('SuiIuris'),
            'riteId',
            static::foreignKey('riteId')
        );
        $this->hasMany(
            'id',
            static::nsModel('RiteProp'),
            'riteId',
            static::foreignKey('riteId')
        );
    }

    public static function uniqueKeys()
    {
        return ['rite'];
    }
}
