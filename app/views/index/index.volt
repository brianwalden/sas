{# index/index.volt #}

<h1 class="h3">Albany Confession Times <small>{{ temporal.toHumanDate() }}</small></h1>

<div id="timeline"><div>

<script>
    timelineData = {
        divId: 'timeline',
        columns: [
            { type: 'string', id: 'Church' },
            { type: 'string', id: 'Time' },
            { type: 'date', id: 'Start' },
            { type: 'date', id: 'End' },
        ],
        data: [
        {% for c in confession %}
            {% set start = temporal.getNew(c.startTime) %}
            {% set stop = temporal.getNew(c.stopTime) %}
            [
                '{{ c.nickname|escape_js }}',
                '{{ start.toHumanTime() }} - {{ stop.toHumanTime() }}',
                new Date(0, 0, 0, {{ start.hour }}, {{ start.minute }}, 0),
                new Date(0, 0, 0, {{ stop.hour }}, {{ stop.minute }}, 0),
            ],
        {% endfor %}
        ],
    };
</script>