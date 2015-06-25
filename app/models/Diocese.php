<?php

namespace Brianwalden\SAS\Models;

class Diocese extends BaseModel
{
    public $id;

    public $diocese;

    public $provinceId;

    public function initialize()
    {
        $this->belongsTo(
            'provinceId',
            static::nsModel('Province'),
            'id',
            static::foreignKey('provinceId')
        );
        $this->hasMany(
            'id',
            static::nsModel('Parish'),
            'dioceseId',
            static::foreignKey('dioceseId')
        );
        $this->hasMany(
            'id',
            static::nsModel('DioceseProp'),
            'dioceseId',
            static::foreignKey('dioceseId')
        );
    }

    public static function uniqueKeys()
    {
        return ['diocese'];
    }
}
