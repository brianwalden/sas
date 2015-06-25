<?php

namespace Brianwalden\SAS\Models;

class Religious2 extends BaseModel
{
    public $id;

    public $religious2;

    public $religious3Id;

    public function initialize()
    {
        $this->belongsTo(
            'religious3Id',
            static::nsModel('Religious3'),
            'id',
            static::foreignKey('religious3Id')
        );
        $this->hasMany(
            'id',
            static::nsModel('Religious1'),
            'religious2Id',
            static::foreignKey('religious2Id')
        );
        $this->hasMany(
            'id',
            static::nsModel('Religious2Prop'),
            'religious2Id',
            static::foreignKey('religious2Id')
        );
    }

    public static function uniqueKeys()
    {
        return [['religious2', 'religious3Id']];
    }
}
