<?php

namespace Brianwalden\SAS\Models;

class Religious1 extends BaseModel
{
    public $id;

    public $religious1;

    public $religious2Id;

    public function initialize()
    {
        $this->belongsTo(
            'religious2Id',
            static::nsModel('Religious2'),
            'id',
            static::foreignKey('religious2Id')
        );
        $this->hasMany(
            'id',
            static::nsModel('Religious'),
            'religious1Id',
            static::foreignKey('religious1Id')
        );
        $this->hasMany(
            'id',
            static::nsModel('Religious1Prop'),
            'religious1Id',
            static::foreignKey('religious1Id')
        );
    }

    public static function uniqueKeys()
    {
        return [['religious1', 'religious2Id']];
    }
}
