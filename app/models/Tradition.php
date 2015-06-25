<?php

namespace Brianwalden\SAS\Models;

class Tradition extends BaseModel
{
    public $id;

    public $tradition;

    public $archtraditionId;

    public function initialize()
    {
        $this->belongsTo(
            'archtradtionId',
            static::nsModel('Archtradition'),
            'id',
            static::foreignKey('archtraditionId')
        );
        $this->hasMany(
            'id',
            static::nsModel('Rite'),
            'traditionId',
            static::foreignKey('traditionId')
        );
        $this->hasMany(
            'id',
            static::nsModel('TraditionProp'),
            'traditionId',
            static::foreignKey('traditionId')
        );
    }

    public static function uniqueKeys()
    {
        return ['tradition'];
    }
}
