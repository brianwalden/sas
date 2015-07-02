<?php

namespace Brianwalden\SAS\Models;

abstract class BaseAttr extends BaseModel
{
    const IS_LOOKUP = 'attr';

    const BASE_TABLE = 'putBaseTableNameHere';

    public $id;

    public $attr;

    /**
     * The number of times this attribute can be used per property, default 1
     * For no limit, set to 0
     *
     * For example, if a more than one language is used at a Mass you might want
     * to set this to 2 or 3 to more than one property for the language attribute
     *
     * @var int
     */
    public $multiLimit;

    public function initialize()
    {
        $this->relationship('hasMany', static::propModel(), static::attrId(), false);
    }

    public static function uniqueKeys()
    {
        return ['attr'];
    }

    public static function defaultFields()
    {
        return ['multiLimit'];
    }

    public static function propModel()
    {
        return ucfirst(static::BASE_TABLE . 'Prop');
    }

    public static function attrId()
    {
        return static::BASE_TABLE . 'AttrId';
    }
}
