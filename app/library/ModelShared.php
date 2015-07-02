<?php

namespace Brianwalden\SAS\Library;

class ModelShared
{
    public $model;

    public $nsModel;

    public $sqlModel;

    public $lookupField;

    protected $db;

    public function __construct($model = null)
    {
        $this->set($model);
    }

    public function set($model)
    {
        $this->reset();

        foreach (Model::modelNames($model) as $key => $value) {
            $this->$key = $value;
        }

        return isset($this->model);
    }

    public function find(array $params = array())
    {
        $nsModel = $this->nsModel;
        return ($nsModel) ? $nsModel::find($params) : [];
    }

    public function findFirst(array $params = array())
    {
        $nsModel = $this->nsModel;
        return ($nsModel) ? $nsModel::find($params) : false;
    }

    public function query($phql, array $bind = array())
    {
        $this->setDb();
        return $this->db->executeQuery($phql, $bind);
    }

    public function queryFirst($phql, array $bind = array())
    {
        return $this->query($phql, $bind)->getFirst();
    }

    protected function reset()
    {
        foreach (['model', 'nsModel', 'sqlModel', 'lookupField'] as $property) {
            $this->$property = null;
        }
    }

    protected function setDb()
    {
        if (!isset($this->db)) {
            $this->db = Model::getModelsManager();
        }

        return isset($this->db);
    }
}
