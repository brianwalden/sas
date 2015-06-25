<?php

namespace Brianwalden\SAS\Models;

class Archtradition extends BaseModel
{
    public $id;

    public $archtradition;

    public function initialize()
    {
        $this->hasMany(
            'id',
            static::nsModel('Tradition'),
            'archtraditionId',
            static::foreignKey('archtraditionId')
        );
        $this->hasMany(
            'id',
            static::nsModel('ArchtraditionProp'),
            'archtraditionId',
            static::foreignKey('archtraditionId')
        );
    }

    public static function uniqueKeys()
    {
        return ['archtradition'];
    }
}
