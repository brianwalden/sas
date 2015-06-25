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
        $this->belongsTo(
            'provinceId',
            static::nsModel('Province'),
            'id',
            static::foreignKey('provinceId')
        );
        $this->hasMany(
            'id',
            static::nsModel('Church'),
            'parishId',
            static::foreignKey('parishId')
        );
        $this->hasMany(
            'id',
            static::nsModel('ParishProp'),
            'parishId',
            static::foreignKey('parishId')
        );
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
