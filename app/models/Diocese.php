<?php

namespace Brianwalden\SAS\Models;

class Diocese extends BaseModel
{
    const IS_LOOKUP = true;

    public $id;

    public $diocese;

    public $provinceId;

    public function initialize()
    {
        $this->relationship('belongsTo', 'Province', 'provinceId', false);
        $this->relationship('hasMany', 'Parish', 'dioceseId', false);
        $this->relationship('hasMany', 'DioceseProp', 'dioceseId', false);
    }

    public static function uniqueKeys()
    {
        return ['diocese'];
    }
}
