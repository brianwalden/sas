<?php

namespace Brianwalden\SAS\Models;

class Province extends BaseModel
{
    public $id;

    public $province;

    public $suiIurisId;

    public function initialize()
    {
        $this->belongsTo(
            'suiIurisId',
            static::nsModel('SuiIuris'),
            'id',
            static::foreignKey('suiIurisId')
        );
        $this->hasMany(
            'id',
            static::nsModel('Diocese'),
            'provinceId',
            static::foreignKey('provinceId')
        );
        $this->hasMany(
            'id',
            static::nsModel('ProvinceProp'),
            'provinceId',
            static::foreignKey('provinceId')
        );
    }

    public static function uniqueKeys()
    {
        return ['province'];
    }
}
