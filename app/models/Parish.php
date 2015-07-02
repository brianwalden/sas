<?php

namespace Brianwalden\SAS\Models;

class Parish extends BaseModel
{
    public $id;

    public $parish;

    public $identifier;

    public $dioceseId;

    public function initialize()
    {
        $this->relationship('belongsTo', 'Province', 'provinceId', false);
        $this->relationship('hasMany', 'Church', 'parishId', false);
        $this->relationship('hasMany', 'ParishProp', 'parishId', false);
    }

    public static function uniqueKeys()
    {
        return [['parish', 'identifier', 'dioceseId']];
    }

    public static function defaultFields()
    {
        return ['identifier'];
    }
}
