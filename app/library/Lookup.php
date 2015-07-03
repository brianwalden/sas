<?php

namespace Brianwalden\SAS\Library;

use Phalcon\DI;

class Lookup
{
    protected $lookups;

    protected $modelShared;

    /**************************************************************************
     * Instance methods *******************************************************
     **************************************************************************/
    
    public function __construct()
    {
        $this->lookups = [];
        $this->modelShared = Model::getShared();
    }

    public function getId($model, $value)
    {
        $result = false;

        if (static::isIntLike($value)) {
            $result = $this->getValue($model, $value);
        } else {
            $lookup = $this->getLookup($model);
            $testValue = trim(strtolower($value));
            
            if ($lookup) {
                foreach ($lookup as $id => $lookupValue) {
                    if ($testValue == trim(strtolower($lookupValue))) {
                        $result = $id;
                        break;
                    }
                }
            }
        }

        return ($result && !static::isIntLike($result)) ?
            $this->getId($model, $result) : $result;
    }

    public function getValue($model, $id)
    {
        $result = false;

        if (static::isIntLike($id)) {
            $lookup = $this->getLookup($model);

            if ($lookup && isset($lookup[$id])) {
                $result = $lookup[$id];
            }
        } else {
            $result = $this->getId($model, $id);
        }

        return ($result && static::isIntLike($result)) ?
            $this->getValue($model, $result) : $result;
    }

    public function getLookup($model, $flip = false)
    {
        $result = false;

        if ($this->isLookup($model)) {
            if (!isset($this->lookups[$this->modelShared->model])) {
                $this->lookups[$this->modelShared->model] = [];
                $field = $this->modelShared->lookupField;

                foreach ($this->modelShared->find(['order' => 'id']) as $row) {
                    $this->lookups[$this->modelShared->model][$row->id] = $row->$field;
                }
            }

            $result = $this->lookups[$model];
        }

        return ($result && $flip) ? array_flip($result) : $result;
    }

    public function isLookup($model)
    {
        $this->modelShared->set($model);
        return (bool) $this->modelShared->lookupField;
    }

    /**************************************************************************
     * Static methods *********************************************************
     **************************************************************************/

    public static function getShared()
    {
        return DI::getDefault()->getLookup();
    }

    public static function id($model, $value)
    {
        return static::getShared()->getId($model, $value);
    }

    public static function value($model, $id)
    {
        return static::getShared()->getValue($model, $id);
    }

    public static function get($model, $flip = false)
    {
        return static::getShared()->getLookup($model, $flip);
    }

    public static function is($model)
    {
        return static::getShared()->isLookup($model);
    }

    public static function isIntLike($value)
    {
        return (is_numeric($value) && $value == (int) $value);
    }
}
