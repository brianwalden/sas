<?php

namespace Brianwalden\SAS\Models;

class SuiIuris extends BaseModel
{
    const IS_LOOKUP = true;
    
    public $id;

    public $suiIuris;

    public $riteId;

    public function initialize()
    {
        $this->relationship('belongsTo', 'Rite', 'riteId', false);
        $this->relationship('hasMany', 'Province', 'suiIurisId', false);
        $this->relationship('hasMany', 'ReligiousTop', 'suiIurisId', false);
        $this->relationship('hasMany', 'SuiIurisProp', 'suiIurisId', false);
    }

    public static function uniqueKeys()
    {
        return ['suiIuris'];
    }
}
