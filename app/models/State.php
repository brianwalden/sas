<?php

namespace Brianwalden\SAS\Models;

class State extends BaseModel
{
    public $id;

    public $state2;

    public $state;

    public $countryId;

    public function initialize()
    {
        $this->relationship('belongsTo', 'Country', 'countryId', false);
        $this->relationship('hasMany', 'County', 'stateId', false);
        $this->relationship('hasMany', 'StateProp', 'stateId', false);
    }

    public static function uniqueKeys()
    {
        return [['state2', 'countryId'], ['state', 'countryId']];
    }
}
