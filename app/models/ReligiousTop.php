<?php

namespace Brianwalden\SAS\Models;

class ReligiousTop extends BaseModel
{
    public $id;

    public $religiousTop;

    public $suiIurisId;

    public function initialize()
    {
        $this->relationship('belongsTo', 'SuiIuris', 'suiIurisId', false);
        $this->relationship('hasMany', 'Religious3', 'religiousTopId', false);
        $this->relationship('hasMany', 'ReligiousTopProp', 'religiousTopId', false);
    }

    public static function uniqueKeys()
    {
        return [['religiousTop', 'suiIurisId']];
    }
}
