<?php

namespace Brianwalden\SAS\Models;

class Religious1 extends BaseModel
{
    public $id;

    public $religious1;

    public $religious2Id;

    public function initialize()
    {
        $this->relationship('belongsTo', 'Religious2', 'religious2Id', false);
        $this->relationship('hasMany', 'Religious', 'religious1Id', false);
        $this->relationship('hasMany', 'Religious1Prop', 'religious1Id', false);
    }

    public static function uniqueKeys()
    {
        return [['religious1', 'religious2Id']];
    }
}
