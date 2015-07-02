<?php

namespace Brianwalden\SAS\Models;

use Phalcon\Mvc\Model;
use Phalcon\Db\RawValue;
use Phalcon\Text;

abstract class BaseModel extends Model
{
    const BASE_NS = 'Brianwalden\SAS\Models\\';

    const IS_LOOKUP = false;

    public function getSource()
    {
        //Phalcon can't find camelcase table names
        return lcfirst(Text::camelize(parent::getSource()));
    }

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

    public static function sqlModel($model)
    {
        return static::BASE_NS . $model;
    }

    public static function nsModel($model)
    {
        return '\\' . static::sqlModel($model);
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

    protected function relationship($relationship, $model, $field, $foreignKey = null, $alias = null)
    {
        $success = false;
        $relationships = ['belongsTo' => [$field, 'id'], 'hasMany' => ['id', $field]];
        $options = ['alias' => ($alias) ? $alias : $model];

        if ($foreignKey !== null) {
            $options['foreignKey'] = [
                'allowNull' => (bool) $foreignKey,
                'message' => "Foreign Key Violation: $field",
            ];
        }

        $r = (empty($relationships[$relationship])) ? null : $relationships[$relationship];
        if ($r) {
            $this->$relationship($r[0], static::sqlModel($model), $r[1], $options);
            $success = true;
        }

        return $success;
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
                            'message' => "Unique Key Violation: $message",
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
