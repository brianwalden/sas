<?php

namespace Brianwalden\SAS\Models;

class Tradition extends BaseModel
{
    const IS_LOOKUP = true;
    
    public $id;

    public $tradition;

    public $archtraditionId;

    public function initialize()
    {
        $this->relationship('belongsTo', 'Archtradition', 'archtraditionId', false);
        $this->relationship('hasMany', 'Rite', 'traditionId', false);
        $this->relationship('hasMany', 'TraditionProp', 'traditionId', false);
    }

    public static function uniqueKeys()
    {
        return ['tradition'];
    }
}
