<?php

namespace Brianwalden\SAS\Models;

class Religious2 extends BaseModel
{
    public $id;

    public $religious2;

    public $religious3Id;

    public function initialize()
    {
        $this->relationship('belongsTo', 'Religious3', 'religious3Id', false);
        $this->relationship('hasMany', 'Religious1', 'religious2Id', false);
        $this->relationship('hasMany', 'Religious2Prop', 'religious2Id', false);
    }

    public static function uniqueKeys()
    {
        return [['religious2', 'religious3Id']];
    }
}
