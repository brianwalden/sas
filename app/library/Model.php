<?php

namespace Brianwalden\SAS\Library;

use Brianwalden\SAS\Models\BaseModel;
use Phalcon\DI;

class Model
{
    public static function getShared($model = null)
    {
        $shared = DI::getDefault()->getMyModel();
        $shared->set($model);
        return $shared;
    }

    public static function getModelsManager()
    {
        return DI::getDefault()->getModelsManager();
    }

    public static function find($model, array $params = array())
    {
        $nsModel = static::nsModel($model);
        return ($nsModel) ? $nsModel::find($params) : [];
    }

    public static function findFirst($model, array $params = array())
    {
        $nsModel = static::nsModel($model);
        return ($nsModel) ? $nsModel::findFirst($params) : false;
    }

    public static function query($phql, array $bind = array())
    {
        $db = static::getModelsManager();
        return $db->executeQuery($phql, $bind);
    }

    public static function queryFirst($phql, array $bind = array())
    {
        return static::query($phql, $bind)->getFirst();
    }

    public static function model($model)
    {
        $results = static::modelNames($model);
        return (empty($results['model'])) ? false : $results['model'];
    }

    public static function nsModel($model)
    {
        $results = static::modelNames($model);
        return (empty($results['nsModel'])) ? false : $results['nsModel'];
    }

    public static function sqlModel($model)
    {
        $results = static::modelNames($model);
        return (empty($results['nsModel'])) ? false : $results['nsModel'];
    }

    public static function lookupField($model)
    {
        $results = static::modelNames($model);
        return (empty($results['lookupField'])) ? false : $results['lookupField'];
    }

    public static function fieldIn($field, array $values = array(), $notIn = false)
    {
        $placeholders = [];
        $in = ($notIn) ? "NOT IN" : "IN";

        foreach ($values as $key => $value) {
            $placehoders[] = (Lookup::isIntLike($key)) ? "?$key" : ":$key:";
        }

        return "$field $in (" . implode(', ', $placeholders) . ')';
    }

    public static function modelNames($model)
    {
        $model = (is_string($model)) ? trim(ucfirst($model)) : '';
        $nsModel = BaseModel::nsModel($model);
        return (!$model || !class_exists($nsModel)) ? [] : [
            'model' => $model,
            'nsModel' => $nsModel,
            'sqlModel' => BaseModel::sqlModel($model),
            'lookupField' => ($nsModel::IS_LOOKUP === true) ?
                lcfirst($model) : $nsModel::IS_LOOKUP,
        ];
    }
}
