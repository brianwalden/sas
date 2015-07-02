<?php

namespace Brianwalden\SAS\Models;

class Religious extends BaseModel
{
    public $id;

    public $religious;

    public $religious1Id;

    public function initialize()
    {
        $this->relationship('belongsTo', 'Religious1', 'religious1Id', false);
        $this->relationship('hasMany', 'Church', 'religiousId', false);
        $this->relationship('hasMany', 'ReligiousProp', 'religiousId', false);
    }

    public static function uniqueKeys()
    {
        return [['religious', 'religious1Id']];
    }
}
