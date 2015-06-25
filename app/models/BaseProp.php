<?php

namespace Brianwalden\SAS\Models;

abstract class BaseProp extends BaseModel
{
    const BASE_TABLE = 'putBaseTableNameHere';

    public $id;

    /**
     * used to distinguish properties with multiple values, defaults to 1
     *
     * For example if a mass is in two languages you would use 1 for the primary
     * language and 2 for the secondary language. Or if they were both equal use
     * null for both
     *
     * @var int
     */
    public $multi;

    public $value;

    public function initialize()
    {
        $this->belongsTo(
            static::baseId(),
            static::baseModel(),
            'id',
            static::foreignKey(static::baseId())
        );
        $this->belongsTo(
            static::baseId(true),
            static::baseModel(true),
            'id',
            static::foreignKey(static::baseId(true))
        );
    }

    public function validation()
    {
        return (bool) $this->validateMulti(parent::validation());
    }

    public static function uniqueKeys()
    {
        return [[static::baseId(), static::baseId(true), 'multi']];
    }

    public static function defaultFields()
    {
        return ['multi'];
    }

    public static function baseModel($isAttrTable = false)
    {
        return static::nsModel(ucfirst(static::getBase($attr)));
    }

    public static function baseId($isAttrTable = false)
    {
        return static::getBase($attr) . 'Id';
    }

    protected static function getBase($isAttrTable = false)
    {
        $attr = ($isAttrTable) ? "Attr" : '';
        return static::BASE_TABLE . $attr;
    }

    protected function validateMulti($success = true)
    {
        if ($success) {
            $baseId = static::baseId();
            $attrId = static::baseId(true);
            $attr = ($this->$attrId) ?
                call_user_func([static::baseModel(true), 'findFirst'], $this->$attrId) :
                null;
            $message = 'Could Not Find Matching Attribute: $attrId';

            if ($attr) {
                $message = '';
                if ($attr->multiLimit) {
                    $rowCount = static::count([
                        "id != :id: and $baseId = :baseId: and $attrId = :attrId:",
                        "bind" => [
                            'id' => (empty($this->id)) ? 0 : $this->id,
                            'baseId' => $this->$baseId,
                            'attrId' => $this->$attrId,
                        ],
                    ]);

                    if ($rowcount >= $attr->multiLimit) {
                        $message = "MultiLimit Exceeded";
                    }
                }
            }

            if ($message) {
                $this->appendMessage(new Message($message, 'multi', 'MultiValidation'));
                $success = false;
            }
        }

        return $success;
    }
}
