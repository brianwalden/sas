<?php

namespace Brianwalden\SAS\Models;

class Church extends BaseModel
{
    public $id;

    public $church;

    public $parishId;

    public $religiousId;

    public $cityId;

    public function initialize()
    {
        $this->relationship('belongsTo', 'Parish', 'parishId', false);
        $this->relationship('belongsTo', 'Religious', 'religiousId', false);
        $this->relationship('belongsTo', 'City', 'cityId', false);
        $this->relationship('hasMany', 'Event', 'churchId', false);
        $this->relationship('hasMany', 'ChurchProp', 'churchId', false);
    }

    public static function uniqueKeys()
    {
        return [['church', 'parishId', 'religiousId', 'cityId']];
    }

    public static function defaultFields()
    {
        return ['parishId', 'religiousId'];
    }
}
