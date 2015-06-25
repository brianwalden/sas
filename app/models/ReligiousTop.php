<?php

namespace Brianwalden\SAS\Models;

class ReligiousTop extends BaseModel
{
    public $id;

    public $religiousTop;

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
            static::nsModel('Religious3'),
            'religiousTopId',
            static::foreignKey('religiousTopId')
        );
        $this->hasMany(
            'id',
            static::nsModel('ReligiousTopProp'),
            'religiousTopId',
            static::foreignKey('religiousTopId')
        );
    }

    public static function uniqueKeys()
    {
        return [['religiousTop', 'suiIurisId']];
    }
}
