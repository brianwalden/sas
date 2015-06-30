<?php

namespace Brianwalden\SAS\Library;

use Brianwalden\SAS\Models\BaseModel;

class Lookup
{
    protected $month;

    protected $week;

    protected $day;

    protected $eventType;
    
    /**
     * get the id for a given value
     *
     * @param string $property    the array you want to lookup
     * @param string $value    the value you want to search for
     *
     * @return mixed    (int) the id if found, else (bool) false
     */
    public function getId($property, $value)
    {
        $result = false;

        if (is_numeric($value)) {
            $result = $this->getValue($property, $value);
        } else {
            $lookup = $this->getLookup($property, true);
            $formatted = $this->formatValue($value);

            if ($lookup && isset($lookup[$formatted])) {
                $result = $lookup[$formatted];
            }
        }

        return ($result && !is_numeric($result)) ?
            $this->getId($property, $result) : $result;
    }

    /**
     * get the value for a given id
     *
     * @param string $property    the array you want to lookup
     * @param integer $id    the id you want to search for
     *
     * @return mixed    (string) the value if found, else (bool) false
     */
    public function getValue($property, $id)
    {
        $result = false;

        if (is_numeric($id)) {
            $lookup = $this->getLookup($property);

            if ($lookup && isset($lookup[$id])) {
                $result = $lookup[$id];
            }
        } else {
            $result = $this->getId($property, $id);
        }

        return ($result && is_numeric($result)) ?
            $this->getValue($property, $result) : $result;
    }

    /**
     * is $property one of the arrays defined above
     *
     * @param string $property    the array you want to check
     *
     * @return boolean     is $property defined above
     */
    public function isLookup($property)
    {
        return property_exists($this, $property);
    }

    /**
     * return one of the static arrays defined above
     *
     * @param string $property    the array you want to get
     * @param boolean $flip    perform array_flip() on the result; default: false
     *
     * @return mixed    (array) the array if found, else (bool) false
     */
    public function getLookup($property, $flip = false)
    {
        $result = false;

        if ($this->isLookup($property)) {
            if (!isset($this->$property)) {
                $this->$property = [];
                $rows = call_user_func(
                    ['\\' . BaseModel::BASE_NS . ucfirst($property), 'find'],
                    ['order' => 'id']
                );

                foreach ($rows as $row) {
                    $this->$property[$row->id] = $row->$property;
                }
            }

            $result = ($flip) ? array_flip($this->$property) : $this->$property;
        }

        return $result;
    }

    /**
     * format a value for searching for it in $property
     *
     * @param string $property    the array you'll be looking up
     * @param string $value    the value you want to format
     *
     * @return string    the formatted value
     */
    protected function formatValue($property, $value)
    {
        $formatted = strtolower($value);
        $doUc1 = [
            'week' => true,
            'day' => true,
            'eventType' => ($formatted == 'eucharist'),
        ];

        return (empty($doUc1[$property])) ? $formatted : ucfirst($formatted);
    }
}
