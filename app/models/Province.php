<?php

namespace Brianwalden\SAS\Models;

class Province extends BaseModel
{
    const IS_LOOKUP = true;
    
    public $id;

    public $province;

    public $suiIurisId;

    public function initialize()
    {
        $this->relationship('belongsTo', 'SuiIuris', 'suiIurisId', false);
        $this->relationship('hasMany', 'Diocese', 'provinceId', false);
        $this->relationship('hasMany', 'ProvinceProp', 'provinceId', false);
    }

    public static function uniqueKeys()
    {
        return ['province'];
    }
}
