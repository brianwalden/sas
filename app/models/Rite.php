<?php

namespace Brianwalden\SAS\Models;

class Rite extends BaseModel
{
    const IS_LOOKUP = true;
    
    public $id;

    public $rite;

    public $traditionId;

    public function initialize()
    {
        $this->relationship('belongsTo', 'Tradition', 'traditionId', false);
        $this->relationship('hasMany', 'SuiIuris', 'riteId', false);
        $this->relationship('hasMany', 'RiteProp', 'riteId', false);
    }

    public static function uniqueKeys()
    {
        return ['rite'];
    }
}
