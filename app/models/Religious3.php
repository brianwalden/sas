<?php

namespace Brianwalden\SAS\Models;

class Religious3 extends BaseModel
{
    public $id;

    public $religious3;

    public $religiousTopId;

    public function initialize()
    {
        $this->relationship('belongsTo', 'ReligiousTop', 'religiousTopId', false);
        $this->relationship('hasMany', 'Religious2', 'religious3Id', false);
        $this->relationship('hasMany', 'Religious3Prop', 'religious3Id', false);
    }

    public static function uniqueKeys()
    {
        return [['religious3', 'religiousTopId']];
    }
}
