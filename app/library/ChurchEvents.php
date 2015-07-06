<?php

namespace Brianwalden\SAS\Library;

class ChurchEvents
{
    public $churches;

    public $events;

    public $order;

    public $display;

    public $today;

    public $searchDate;

    public $lookup;

    public $chains;

    public function __construct(Temporal $searchDate = null)
    {
        $this->churches = [];
        $this->events = [];
        $this->order = [];
        $this->display = [];
        $this->lookup = Lookup::getshared();
        $this->chains = (object) [
            'jurisdiction' => ['parish', 'diocese', 'province', 'suiIuris'],
            'praxis' => ['rite', 'tradition', 'archtradition'],
            'location' => ['city', 'county', 'state', 'country', 'continent'],
            'affiliation' => ['religious', 'religious1', 'religious2', 'religious3', 'religiousTop'],
            'properties' => array_values($this->lookup->getLookup('ChurchAttr')),
        ];
        $temporal = new Temporal(null, null, $this->lookup);
        $this->today = $temporal->getDateProperties();
        $this->searchDate = ($searchDate) ? $searchDate->getDateProperties() : $this->today;
        $this->find();
    }

    public function find()
    {
        $select = implode(", ", [
            'church.id as churchId',
            'church.church',
            'church.parishId',
            'parish.parish',
            'parish.identifier as parishIdentifier',
            'parish.dioceseId',
            'diocese.diocese',
            'diocese.provinceId',
            'province.province',
            'province.suiIurisId',
            'suiIuris.suiIuris',
            'suiIuris.riteId',
            'rite.rite',
            'rite.traditionId',
            'tradition.tradition',
            'tradition.archtraditionId',
            'archtradition.archtradition',
            'church.cityId',
            'city.city',
            'city.countyId',
            'county.county',
            'county.stateId',
            'state.state2',
            'state.state',
            'state.countryId',
            'country.country2',
            'country.country3',
            'country.country',
            'country.continentId',
            'continent.continent',
            'church.religiousId',
            'religious.religious',
            'religious.religious1Id',
            'religious1.religious1',
            'religious1.religious2Id',
            'religious2.religious2',
            'religious2.religious3Id',
            'religious3.religious3',
            'religious3.religiousTopId',
            'religiousTop.religiousTop',
            'churchProp.id AS churchPropId',
            'churchProp.value',
            'churchAttr.attr',
        ]);
        $from = implode(" ", [
            Model::nsModel('Church') . ' AS church',
            'LEFT JOIN ' . Model::nsModel('Parish') . ' AS parish ' .
                'ON church.parishId = parish.id',
            'LEFT JOIN ' . Model::nsModel('Diocese') . ' AS diocese ' .
                'ON parish.dioceseId = diocese.id',
            'LEFT JOIN ' . Model::nsModel('Province') . ' AS province ' .
                'ON diocese.provinceId = province.id',
            'LEFT JOIN ' . Model::nsModel('SuiIuris') . ' AS suiIuris ' .
                'ON province.suiIurisId = suiIuris.id',
            'LEFT JOIN ' . Model::nsModel('Rite') . ' AS rite ' .
                'ON suiIuris.riteId = rite.id',
            'LEFT JOIN ' . Model::nsModel('Tradition') . ' AS tradition ' .
                'ON rite.traditionId = tradition.id',
            'LEFT JOIN ' . Model::nsModel('Archtradition') . ' AS archtradition ' .
                'ON tradition.archtraditionId = archtradition.id',
            'LEFT JOIN ' . Model::nsModel('City')  . ' AS city ' .
                'ON church.cityId = city.Id',
            'LEFT JOIN ' . Model::nsModel('County') . ' AS county ' .
                'ON city.countyId = county.id',
            'LEFT JOIN ' . Model::nsModel('State')  . ' AS state ' .
                'ON county.stateId = state.id',
            'LEFT JOIN ' . Model::nsModel('Country') . ' AS country ' .
                'ON state.countryId = country.id',
            'LEFT JOIN ' . Model::nsModel('Continent') . ' AS continent ' .
                'ON country.continentId = continent.id',
            'LEFT JOIN ' . Model::nsModel('Religious') . ' AS religious ' .
                'ON church.religiousId = religious.id',
            'LEFT JOIN ' . Model::nsModel('Religious1') . ' AS religious1 ' .
                'ON religious.religious1Id = religious1.id',
            'LEFT JOIN ' . Model::nsModel('Religious2') . ' AS religious2 ' .
                'ON religious1.religious2Id = religious2.id',
            'LEFT JOIN ' . Model::nsModel('Religious3') . ' AS religious3 ' .
                'ON religious2.religious3Id = religious3.id',
            'LEFT JOIN ' . Model::nsModel('ReligiousTop') . ' AS religiousTop ' .
                'ON religious3.religiousTopId = religiousTop.id',
            'LEFT JOIN ' . Model::nsModel('ChurchProp') . ' AS churchProp ' .
                'ON church.id = churchProp.churchId',
            'LEFT JOIN ' . Model::nsModel('ChurchAttr') . ' AS churchAttr ' .
                'ON churchProp.churchAttrId = churchAttr.id',
        ]);
        $order = "church.id, churchProp.churchAttrId, churchProp.multi";
        $order = "church.id";
        $phql = "SELECT $select FROM $from ORDER BY $order";

        foreach (Model::query($phql) as $row) {
            $props = (empty($row->churchPropId)) ? [] : [
                "{$row->attr}Id" => $row->churchPropId,
                $row->attr => $row->value
            ];

            if (!isset($this->churches[$row->churchId])) {
                unset(
                    $row->churchPropId,
                    $row->value,
                    $row->attr
                );
                $this->churches[$row->churchId] = $row;
                $this->churches[$row->churchId]->events = [];
            }

            foreach ($props as $key => $value) {
                if (property_exists($this->churches[$row->churchId], $key)) {
                    $temp = (array) $this->churches[$row->churchId]->$key;
                    $temp[] = $value;
                    $this->churches[$row->churchId]->$key = $temp;
                } else {
                    $this->churches[$row->churchId]->$key = $value;

                    if ($key == 'nickname') {
                        $names = "$value {$row->church} ";
                        $padId = str_pad($row->churchId, 10, '0', STR_PAD_LEFT);
                        $this->order["$names$padId"] = $row->churchId;
                    }
                }
            }
        }

        ksort($this->order);
        $bind = array_keys($this->churches);
        $select = implode(", ", [
            'event.id AS eventId',
            'event.event',
            'event.eventTypeId',
            'eventType.eventType',
            'event.eventFilterId',
            'eventFilter.eventFilter',
            'event.churchId',
            'event.startDate',
            'event.stopDate',
            'event.startMonth',
            'startM.month as startM',
            'event.stopMonth',
            'stopM.month as stopM',
            'event.startWeek',
            'startW.week as startW',
            'event.stopWeek',
            'stopW.week as stopW',
            'event.startDay',
            'startD.day as startD',
            'event.stopDay',
            'stopD.day as stopD',
            'event.startTime',
            'event.stopTime',
            'eventProp.id as eventPropId',
            'eventProp.value',
            'eventAttr.attr',
        ]);
        $from = implode(" ", [
            Model::nsModel('Event') . ' AS event',
            'LEFT JOIN ' . Model::nsModel('EventType') . ' AS eventType ' .
                'ON event.eventTypeId = eventType.id',
            'LEFT JOIN ' . Model::nsModel('EventFilter') . ' AS eventFilter ' .
                'ON event.eventFilterId = eventFilter.id',
            'LEFT JOIN ' . Model::nsModel('Month') . ' AS startM ' .
                'ON event.startMonth = startM.id',
            'LEFT JOIN ' . Model::nsModel('Month') . ' AS stopM ' .
                'ON event.stopMonth = stopM.id',
            'LEFT JOIN ' . Model::nsModel('Week') . ' AS startW ' .
                'ON event.startWeek = startW.id',
            'LEFT JOIN ' . Model::nsModel('Week') . ' AS stopW ' .
                'ON event.stopWeek = stopW.id',
            'LEFT JOIN ' . Model::nsModel('Day') . ' AS startD ' .
                'ON event.startDay = startD.id',
            'LEFT JOIN ' . Model::nsModel('Day') . ' AS stopD ' .
                'ON event.stopDay = stopD.id',
            'LEFT JOIN ' . Model::nsModel('EventProp') . ' AS eventProp ' .
                'ON event.id = eventProp.eventId',
            'LEFT JOIN ' . Model::nsModel('EventAttr') . ' AS eventAttr ' .
                'ON eventProp.eventAttrId = eventAttr.id',
        ]);
        $where = 'event.churchId in ' . Model::in($bind);
        $order = implode(", ", [
            'event.startDay',
            'event.stopDay',
            'event.startTime',
            'event.stopTime',
            'event.id',
            'eventProp.eventAttrId',
            'eventProp.multi'
        ]);
        $phql = "SELECT $select FROM $from WHERE $where ORDER BY $order";

        foreach (Model::query($phql, $bind) as $row) {
            $props = (empty($row->eventPropId)) ? [] : [
                "{$row->attr}Id" => $row->eventPropId,
                $row->attr => $row->value
            ];

            if (!isset($this->events[$row->eventId])) {
                unset(
                    $row->churchPropId,
                    $row->value,
                    $row->attr
                );
                $this->churches[$row->churchId]->events[] = $row->eventId;
                $this->events[$row->eventId] = $row;
                
                foreach (['start', 'stop'] as $prefix) {
                    $timeString = $prefix . 'Time';
                    $temporal = new Temporal($row->$timeString, null, $this->lookup);
                    foreach ($temporal->getTimeProperties() as $key => $value) {
                        $key = $prefix . ucfirst($key);
                        if ($key != $timeString) {
                             $this->events[$row->eventId]->$key = $value;
                        }
                    }
                }

                $this->display[$row->eventId] = $this->isDisplayable($row->eventId);
            }

            foreach ($props as $key => $value) {
                if (property_exists($this->events[$row->eventId], $key)) {
                    $temp = (array) $this->events[$row->eventId]->$key;
                    $temp[] = $value;
                    $this->events[$row->eventId]->$key = $temp;
                } else {
                    $this->events[$row->eventId]->$key = $value;
                }
            }
        }
    }

    public function isDisplayable($eventId)
    {
        $result = false;

        if (isset($this->events[$eventId]) && isset($this->searchDate)) {
            $e = $this->events[$eventId];
            $s = $this->searchDate;

            if ($e->startDate <= $s->date && $s->date <= $e->stopDate &&
                $e->startMonth <= $s->month && $s->month <= $e->stopMonth &&
                $e->startWeek <= $s->weekOfMonth && $s->weekOfMonth <= $e->stopWeek &&
                $e->startDay <= $s->dayOfWeek && $s->dayOfWeek <= $e->stopDay &&
                ($e->eventFilterId == 1 || $e->eventFilterId == 7)
            ) {
                $result = $e->churchId;
            }
        }

        return $result;
    }
}
