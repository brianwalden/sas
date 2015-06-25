<?php

namespace Brianwalden\SAS\Models;

use Phalcon\Mvc\Model;
use Phalcon\Db\RawValue;

abstract class BaseModel extends Model
{
    const BASE_NS = 'Brianwalden\SAS\Models\\';

    public function beforeValidation()
    {
        foreach (static::defaultFields() as $field) {
            //Phalcon treats empty string as null
            if ($this->$field === null || $this->field === '') {
                $this->$field = new RawValue('default');
            }
        }
    }

    public function validation()
    {
        $success = $this->validateUniqueKeys();
        //$success = $this->nextValidtionMethod();
        return (bool) $success;
    }

    public static function nsModel($model)
    {
        return static::BASE_NS . $model;
    }

    public static function foreignKey($field = '', $allowNull = false)
    {
        $field = ($field) ? ': ' . $field : '';
        return [
            "foreignKey" => [
                'allowNull' => (bool) $allowNull,
                'message' => 'Foreign Key Violation' . $field,
            ],
        ];
    }

    public static function uniqueKeys()
    {
        /**
         * this must be an array (for each unique key) of strings or arrays
         * (for each unique field in the key)
         *
         * example:
         * [
         *     'field1', //unique key on field1
         *     ['field3', 'field4'], //unique key on field3 and field4 combined
         *     'etc',
         * ]
         */
        return [];
    }

    public static function defaultFields()
    {
        //only return fields that cannot be null AND have a default
        return []; //['field1', 'field2', 'etc'];
    }

    protected function validateUniqueKeys($success = true)
    {
        if ($success) {
            $uniqueKeys = static::uniqueKeys();
        
            if ($uniqueKeys) {
                if (!is_array($uniqueKeys)) {
                    $uniqueKeys = [$uniqueKeys];
                }

                foreach ($uniqueKeys as $fields) {
                    if ($fields) {
                        $message = (is_array($fields)) ?
                            implode(', ', $fields) : $fields;
                        $this->validate(new Uniqueness([
                            'field' => $fields,
                            'message' => 'Unique Key Violation: ' . $message,
                        ]));

                        if ($this->validationHasFailed()) {
                            $success = false;
                            break;
                        }
                    }
                }
            }
        }

        return $success;
    }
}
