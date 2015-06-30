<?php

namespace Brianwalden\SAS\Library;

use Brianwalden\SAS\Models\BaseModel;

class Query
{
    protected $model;

    protected $params;

    public function __construct($model = null, array $params = null)
    {
        $this->set('model', $model);
        $this->set('params', $params);
    }

    public function get($property)
    {
        return ($property == 'model' || $property == 'params') ? $this->$property : false;
    }

    public function set($property, $value)
    {
        $success = true;
        $isEmpty = empty($value);

        if ($property == 'model' && ($isEmpty || is_string($value))) {
            $this->model = ($isEmpty) ? '' : $value;
        } elseif ($property == 'params' && ($isEmpty || is_array($value))) {
            $this->params = ($isEmpty) ? [] : $value;

            foreach ($this->params as $k => $v) {
                if (!$this->isAllowed($k)) {
                    unset($this->params[$k]);
                }
            }
        } else {
            $success = false;
        }

        return $success;
    }

    public function reset()
    {
        $success = true;

        foreach (['model', 'params'] as $property) {
            if (!$this->set($property, null)) {
                $success = false;
                break;
            }
        }
        
        return $success;
    }

    public function getParam($property)
    {
        $result = false;

        if ($this->isAllowed($property)) {
            $result = isset($this->params[$property]) ? $this->params[$property] : null;
        }

        return $result;
    }
    
    public function setParam($property, $value)
    {
        $success = false;

        if ($this->isAllowed($property)) {
            $this->params[$property] = $value;
            $success = true;
        }

        return $success;
    }

    public function addCondition($field, $value, $operator = '=', $conditional = 'and')
    {
        $placeholder = $this->getPlaceholder($field);
        $this->params['conditions'] = (empty($this->params['conditions'])) ?
            '' : "{$this->params['conditions']} $conditional ";

        if (empty($this->params['bind'])) {
            $this->params['bind'] = [];
        }
        
        if (is_array($value)) {
            $in = [];
            
            foreach ($value as $v) {
                $in[] = ":$placeholder:";
                $this->params['bind'][$placeholder] = $v;
                $placeholder = $this->getPlaceholder($field);
            }

            $this->params['conditions'] .= "$field in ({implode(', ', $in)})";
        } else {
            $this->params['conditions'] .= "$field $operator :$placeholder:";
            $this->params['bind'][$placeholder] = $value;
        }

        return true;
    }

    public function find()
    {
        return call_user_func(['\\' . BaseModel::BASE_NS . $this->model, 'find'], $this->params);
    }

    public function findFirst()
    {
        return call_user_func(['\\' . BaseModel::BASE_NS . $this->model, 'findFirst'], $this->params);
    }

    protected function isAllowed($property)
    {
        $allowed = [
            'conditions' => true,
            'columns' => true,
            'bind' => true,
            'bindTypes' => true,
            'order' => true,
            'limit' => true,
            'group' => true,
            'for_update' => true,
            'shared_lock' => true,
            'cache' => true,
            'hydration' => true,
        ];
        return isset($allowed[$property]);
    }

    protected function getPlaceholder($field)
    {
        $i = 1;

        if (!empty($this->params['bind'])) {
            while (array_key_exists("$field$i", $this->params['bind'])) {
                $i++;
            }
        }

        return "$field$i";
    }
}
