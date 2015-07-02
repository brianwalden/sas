<?php

namespace Brianwalden\SAS\Models;

class County extends BaseModel
{
    public $id;

    public $county;

    public $stateId;

    public function initialize()
    {
        $this->relationship('belongsTo', 'State', 'stateId', false);
        $this->relationship('hasMany', 'City', 'countyId', false);
        $this->relationship('hasMany', 'CountyProp', 'countyId', false);
    }

    public static function uniqueKeys()
    {
        return [['county', 'stateId']];
    }
}
