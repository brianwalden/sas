<?php

namespace Brianwalden\SAS\Models;

class Church extends BaseModel
{
    public $id;

    public $church;

    public $parishId;

    public $religiousId;

    public $cityId;

    public function initialize()
    {
        $this->belongsTo(
            'parishId',
            static::nsModel('Parish'),
            'id',
            static::foreignKey('parishId')
        );
        $this->belongsTo(
            'religiousId',
            static::nsModel('Religious'),
            'id',
            static::foreignKey('religiousId')
        );
        $this->belongsTo(
            'cityId',
            static::nsModel('City'),
            'id',
            static::foreignKey('cityId')
        );
        $this->hasMany(
            'id',
            static::nsModel('Event'),
            'churchId',
            static::foreignKey('churchId')
        );
        $this->hasMany(
            'id',
            static::nsModel('ChurchProp'),
            'churchId',
            static::foreignKey('churchId')
        );
    }

    public static function uniqueKeys()
    {
        return [['church', 'parishId', 'religiousId', 'cityId']];
    }

    public static function defaultFields()
    {
        return ['parishId', 'religiousId'];
    }
}
