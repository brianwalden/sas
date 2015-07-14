<?php

namespace Brianwalden\SAS\Library;

class ChurchEvents
{
    public $churches;

    public $churchMeta;

    public $events;

    public $eventMeta;

    public $currentDay;

    public $lookups;

    protected $lookup;

    public function __construct(Temporal $searchDate = null)
    {
        $this->churches = [];
        $this->churchMeta = ['sortKeys' => [], 'ordered' => []];
        $this->events = [];
        $this->eventMeta = ['sortKeys' => [], 'ordered' => [], 'days' => []];
        $temporal = ($searchDate) ? $searchDate : new Temporal();
        $this->currentDay = $temporal->toDateString();

        for ($i = 0; $i < 7; $i++) {
            if ($i) {
                $temporal->addDay();
            }

            $dateProps = $temporal->getDateProperties();
            $this->eventMeta['days'][$dateProps['date']] = $dateProps;
        }
        
        $this->lookup = $temporal->getLookup();
        $weekdays = $this->lookup->getLookup('Day');
        $filters = $this->lookup->getLookup('EventFilter');
        $types = $this->lookup->getLookup('EventType');

        $this->lookups = [
            'weekdays' => [
                'getValue' => $weekdays,
                'getId' => array_flip($weekdays),
                'orderedIds' => array_keys($weekdays),
                'orderedValues' => array_values($weekdays),
            ],
            'filters' => [
                'getValue' => $filters,
                'getId' => array_flip($filters),
                'orderedIds' => array_keys($filters),
                'orderedValues' => array_values($filters),
            ],
            'types' => [
                'getValue' => $types,
                'getId' => array_flip($types),
                'orderedIds' => array_keys($types),
                'orderedValues' => array_values($types),
            ],
        ];

        $this->find();

        /* this might be useful one day
        $this->chains = [
            'jurisdiction' => ['parish', 'diocese', 'province', 'suiIuris'],
            'praxis' => ['rite', 'tradition', 'archtradition'],
            'location' => ['city', 'county', 'state', 'country', 'continent'],
            'affiliation' => ['religious', 'religious1', 'religious2', 'religious3', 'religiousTop'],
            'properties' => array_values($this->lookup->getLookup('ChurchAttr')),
        ];
        */
    }

    public function find()
    {
        $select = implode(", ", [
            'church.id as churchId',
            'church.church',
            'church.parishId',
            'parish.parish',
            'parish.identifier as parishIdentifier',
            'parishProp.id as isIntentionalId',
            'parishProp.value as isIntentional',
            'parish.dioceseId',
            'diocese.diocese',
            'dioceseProp.id as isMetroId',
            'dioceseProp.value as isMetro',
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
            'LEFT JOIN ' . Model::nsModel('ParishProp') . ' AS parishProp ON (' .
                'parishProp.parishId = parish.id AND ' .
                'parishProp.parishAttrId = :isIntentionalId:)',
            'LEFT JOIN ' . Model::nsModel('Diocese') . ' AS diocese ' .
                'ON parish.dioceseId = diocese.id',
            'LEFT JOIN ' . Model::nsModel('DioceseProp') . ' AS dioceseProp ON (' .
                'dioceseProp.dioceseId = diocese.id AND ' .
                'dioceseProp.dioceseAttrId = :isMetroId:)',
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
        $phql = "SELECT $select FROM $from ORDER BY $order";
        $bind = [
            'isIntentionalId' => $this->lookup->getId('parishAttr', 'isIntentional'),
            'isMetroId' => $this->lookup->getId('dioceseAttr', 'isMetro'),
        ];
        foreach (Model::query($phql, $bind) as $row) {
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

                    if ($key == 'site') {
                        $this->churches[$row->churchId]->siteAT = rtrim(preg_replace(
                            '/^(http)?s?:?\/?\/?(www\.)?/i',
                            '',
                            $value
                        ), " /");

                    }

                    if ($key == 'nickname') {
                        $names = "$value {$row->church} ";
                        $padId = $this->padId($row->churchId);
                        $this->churchMeta['sortKeys']["$names$padId"] = $row->churchId;
                    }
                }
            }
        }

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

                $times = implode(" ", [
                    $row->startDay,
                    $row->stopDay,
                    $row->startTime,
                    $row->stopTime,
                ]);
                $padId = $this->padId($row->eventId);
                $this->eventMeta['sortKeys']["$times$padId"] = $row->eventId;
                $this->eventMeta['ordered'][] = $row->eventId;
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

        ksort($this->churchMeta['sortKeys']);
        foreach ($this->churchMeta['sortKeys'] as $churchId) {
            $this->churchMeta['ordered'][] = $churchId;
            $this->makeDescription($churchId);
            $this->makeSchedule($churchId);
        }
    }

    protected function padId($id)
    {
        return str_pad($id, 10, '0', STR_PAD_LEFT);
    }

    protected function makeDescription($churchId)
    {
        $church = $this->churches[$churchId];
        $description = $church->nickname . ' is';
        $religious = [];
        $and = '';

        if (!empty($church->isBasilica)) {
            $description .= "$and a minor basilica";
            $and = ' and';
        }

        if (!empty($church->isShrine)) {
            $description .= "$and a {$church->isShrine} shrine";
            $and = ' and';
        }

        if (!empty($church->isCathedral)) {
            $description .= "$and the {$church->isCathedral}";
        } elseif (!empty($church->isParish)) {
            $description .= "$and a {$church->isParish} church";

            if ($church->isParish != "parish") {
                $description .= " of {$church->parish} Parish";
            }
        } else {
            $mission = (empty($church->isMission)) ? '' : ' mission';
            $parish = (empty($church->parish)) ? '' : " of {$church->parish} Parish";
            $description .= "$and a$mission church";
        }

        if (!empty($church->isIntentional)) {
            $description .= " for {$church->isIntentional} Catholics";
        }

        foreach (['', '1', '2', '3', 'Top'] as $r) {
            $key = "religious$r";
            if (!empty($church->$key)) {
                $religious[] = $church->$key;
            }
        }

        if (!empty($church->diocese)) {
            $description .= " of the {$church->diocese}";

            if (empty($church->isMetro)) {
                $description .= ", {$church->province}";
            }
        } elseif ($religious) {
            $description .= ' of the ' . implode(', ', $religious);
        }

        $description .= ". It is a {$church->rite} rite church of the {$church->suiIuris}";

        if (!empty($church->diocese) && $religious) {
            $description .= ' administered by ' . implode(', ', $religious);
        }

        $this->churches[$churchId]->description = "$description.";
    }

    protected function makeSchedule($churchId)
    {
        $schedule = [];
        $blank = [1 => [], 2 => [], 3 => [], 4 => [], 5 => [], 6 => [], 7 => []];

        foreach ($this->churches[$churchId]->events as $eventId) {
            $event = $this->events[$eventId];
            if ($event->startDate <= $this->currentDay && $this->currentDay <= $event->stopDate) {
                $name = $event->event;
                $type = $event->eventType;
                $filter = $event->eventFilter;

                if (empty($schedule[$filter])) {
                    $schedule[$filter] = [];
                }

                if (empty($schedule[$filter][$type])) {
                    $schedule[$filter][$type] = $blank;
                }

                $weekOfMonth = '';
                $timespan = $event->startTimeHumanSchedule;
                $note = (empty($event->note)) ? '' : $event->note;

                if ($event->startWeek != 1 || $event->stopWeek != 5) {
                    $separator = '';

                    for ($i = $event->startWeek; $i <= $event->stopWeek; $i++) {
                        $weekOfMonth .= $separator . $this->lookup->getValue('Week', $i);
                        $separator = ($i == $event->stopWeek) ? ' and ' : ', ';
                    }
                }

                if ($type != 'Mass') {
                    if ($event->startAmpm == $event->stopAmpm) {
                        $timespan = $event->startTimeHuman;
                    }

                    $timespan .= '<span class="hidden-sm"> </span>-' .
                        '<span class="hidden-sm"> </span>' .
                        $event->stopTimeHumanSchedule;
                }

                for ($i = $event->startDay; $i <= $event->stopDay; $i++) {
                    if (empty($schedule[$filter][$type][$i][$name])) {
                        $schedule[$filter][$type][$i][$name] = [];
                    }

                    $day = $this->lookups['weekdays']['getValue'][$i];
                    $timeToday = $timespan;

                    if ($weekOfMonth) {
                        $timeToday = "$weekOfMonth $day of the month: " .
                            '<span class="hidden-xs"><br /></span>' + $timespan;
                    }

                    if ($note) {
                        $timeToday .= ' <span class="hidden-xs"><br /></span>' .
                            '<span class="eventNote">(' . $note . ')</span>';
                    }

                    $schedule[$filter][$type][$i][$name][] = $timeToday;
                }
            }
        }

        $this->churches[$churchId]->schedule = $schedule;
    }
}
