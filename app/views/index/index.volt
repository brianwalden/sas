{# index/index.volt #}

<h1 class="h3">Albany Confession Times <small>{{ temporal.toHumanDate() }}</small></h1>

<div id="timeline"></div>

{% for i, churchId in churchEvents.order %}
    {% set church = churchEvents.churches[churchId] %}
<div class="church-{{ churchId }}-main hidden">
    <h2 class="h4">{{ church.church }}</h2>
    <div class="row">
        <div class="col-sm-6 ">
            <div>
    <?php echo (is_array($church->street)) ? implode('<br />', $church->street) : $church->street; ?>
            </div>
            <div>{{ church.city }}, {{ church.state2 }} {{ church.zip }}</div>
        </div>
        <div class="col-sm-6 ">
            <div><b>Confession:</b></div>
    {% for j, eventId in church.events %}
            <div>
        {% set event = churchEvents.events[eventId] %}
        {% if event.eventFilterId == 1 or event.eventFilterId == 7 %}
            {% if event.startWeek != 1 or event.stopWeek != 5 %}
                {{ event.startW }}
                {% if event.startWeek != event.stopWeek %} - {{ event.stopW }}{% endif %}
            {% endif %}
            {% if event.startDay == 1 and event.stopDay == 7 %}
                Everyday
            {% else %} 
                {{ event.startD }}
                {% if event.startDay != event.stopDay %} - {{ event.stopD }}{% endif %}
            {% endif %}
            {% if event.startWeek != 1 or event.stopWeek != 5 %}
                of the month
            {% endif %}
                , {{ event.startTimeHumanLong }} - {{ event.stopTimeHumanLong }}
        {% endif %}
            </div>
    {% endfor %}
        </div>
    </div>
</div>
{% endfor %}

<script>
    timelineData = {
        divId: 'timeline',
        columns: [
            { type: 'string', id: 'Church' },
            { type: 'string', id: 'Sacrament' },
            { type: 'date', id: 'Start' },
            { type: 'date', id: 'End' },
        ],
        data: [
{% for churchId, church in churchEvents.churches %}
    {% for i, eventId in church.events %}
        {% if churchEvents.display[eventId] %}
            {% set event = churchEvents.events[eventId] %}
            [
                '{{ church.nickname|escape_js }}',
                '{{ event.event ? event.event : event.eventType }}',
                new Date(
                    {{ churchEvents.searchDate.year }},
                    {{ churchEvents.searchDate.monthJs }},
                    {{ churchEvents.searchDate.day }},
                    {{ event.startHour }},
                    {{ event.startMinute }},
                    {{ event.startSecond }}
                ),
                new Date(
                    {{ churchEvents.searchDate.year }},
                    {{ churchEvents.searchDate.monthJs }},
                    {{ churchEvents.searchDate.day }},
                    {{ event.stopHour }},
                    {{ event.stopMinute }},
                    {{ event.stopSecond }}
                ),
            ],
        {% endif %}
    {% endfor %}
{% endfor %}
        ],
    };

    $(document).ready(function() {
        var unhide = {{ churchEvents.display|json_encode }};
        $.each(unhide, function(eventId, churchId) {
            if (churchId) {
                $('.church-' + churchId + '-main').removeClass('hidden');
            }
        });
    });
</script>