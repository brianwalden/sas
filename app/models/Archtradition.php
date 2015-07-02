<?php

namespace Brianwalden\SAS\Models;

class Archtradition extends BaseModel
{
    const IS_LOOKUP = true;

    public $id;

    public $archtradition;

    public function initialize()
    {
        $this->relationship('hasMany', 'Tradition', 'archtraditionId', false);
        $this->relationship('hasMany', 'ArchtraditionProp', 'archtraditionId', false);
    }

    public static function uniqueKeys()
    {
        return ['archtradition'];
    }
}
