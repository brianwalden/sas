<?php

namespace Brianwalden\SAS\Models;

class Religious3 extends BaseModel
{
    public $id;

    public $religious3;

    public $religiousTopId;

    public function initialize()
    {
        $this->belongsTo(
            'religiousTopId',
            static::nsModel('ReligiousTop'),
            'id',
            static::foreignKey('religiousTopId')
        );
        $this->hasMany(
            'id',
            static::nsModel('Religious2'),
            'religious3Id',
            static::foreignKey('religious3Id')
        );
        $this->hasMany(
            'id',
            static::nsModel('Religious3Prop'),
            'religious3Id',
            static::foreignKey('religious3Id')
        );
    }

    public static function uniqueKeys()
    {
        return [['religious3', 'religiousTopId']];
    }
}
