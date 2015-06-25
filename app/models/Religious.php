<?php

namespace Brianwalden\SAS\Models;

class Religious extends BaseModel
{
    public $id;

    public $religious;

    public $religious1Id;

    public function initialize()
    {
        $this->belongsTo(
            'religious1Id',
            static::nsModel('Religious1'),
            'id',
            static::foreignKey('religious1Id')
        );
        $this->hasMany(
            'id',
            static::nsModel('Church'),
            'religiousId',
            static::foreignKey('religiousId')
        );
        $this->hasMany(
            'id',
            static::nsModel('ReligiousProp'),
            'religiousId',
            static::foreignKey('religiousId')
        );
    }

    public static function uniqueKeys()
    {
        return [['religious', 'religious1Id']];
    }
}
