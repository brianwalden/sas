var sasTimeline = {
    timeline: {
        divId: 'timeline',
        columns: [
            { type: 'string', id: 'Church' },
            { type: 'string', id: 'Sacrament' },
            { type: 'date', id: 'Start' },
            { type: 'date', id: 'End' },
        ],
        rowHeight: 41, //google charts timeline row height
    },
    initialize: function(divId) {
        var me = this;

        $('.day-nav button').click(function() {
            me.currentDay = this.id;
            me.refresh(me.currentDay);
        });

        $.post('/ajax/getChurches', function(data) {
            $.each(data, function (k, v) {
                me[k] = v;
            });
            me.writeChurches();
            me.refresh();
        });
    },
    refresh: function(singleDay) {
        var me = this;
        me.writeDayLinks();
        me.calculateDisplayable(singleDay);
        me.drawTimeline();
    },
    writeDayLinks: function() {
        var me = this;

        $.each(me.eventMeta.days, function(day, props) {
            var id = props['dayOfWeek'];
            
            $('.day-col-' + id + ' button').prop('id', props['date']).html([
                props['dayOfWeekHuman'].substr(0, 3),
                '<span class="hidden-xs">' + props['dayOfWeekHuman'].substr(3) + '</span><br />\n', 
                '<span class="small">\n',
                    '<span class="visible-xs-inline">' + props['month'] + '/</span>',
                    '<span class="hidden-xs">' + props['monthHuman'].substr(0, 3),
                        '<span class="hidden-sm">' + props['monthHuman'].substr(3) + '</span>\n',
                    '</span>',
                    '<span class="visible-xs-inline">' + props['day'] + '</span>',
                    '<span class="hidden-xs">' + props['dayHuman'] + '</span>\n',
                '</span>\n',
            ].join(''));

            if (day == me.currentDay) {
                $('.day-col-' + id).addClass('active');
            } else {
                $('.day-col-' + id).removeClass('active');
            }
        });

        $('.search-alert').addClass('hidden');
        $('.day-nav').removeClass('hidden');
    },
    writeChurches: function() {
        var me = this;
        var html = '';

        $.each(me.churchMeta.ordered, function(i, churchId) {
            var church = me.churches[churchId];

            var address = '<div><address>';
            address += (typeof church.street == "object") ?
                church.street.join(', ') : church.street;
            address += ', ' + church.city + ', ' + church.state2 + ' '
                + church.zip + '</address></div>';
            
            var website = (!church.hasOwnProperty('site')) ? '' :
                '<div class="break"><a href="' + church.site + '" target="_blank">' +
                church.siteAT + '</a></div>';
            
            html += (html) ? '\n' : '';
            html += [
                '<div class="panel panel-sas church church-' + churchId + ' hidden">',
                    '<div class="panel-heading">',
                        '<div class="row">',
                            '<div class="col-xs-9 col-sm-11">',
                                '<h2>' + church.church + '</h2>',
                            '</div>',
                            '<div class="col-xs-3 col-sm-1 text-right scrollUp">',
                                '<button type="button" class="btn btn-link">',
                                    '<span class="glyphicon glyphicon-arrow-up" aria-hidden="true"></span>',
                                    '<span class="sr-only">Scroll:</span>',
                                    'Top',
                                '</button>',
                            '</div>',
                        '</div>',
                    '</div>',
                    '<div class="panel-body">',
                        address,
                        website,
                        '<div>' + church.description + '</div>',
                    '</div>',
                    '<div class="schedule schedule-' + churchId + '"></div>',
                '</div>',
            ].join('\n');
        });

        $('.churches').html(html);
        $('.scrollUp button').off('click');
        $('.scrollUp button').on('click', function() {
            $.scrollTo(0, saintAnthonySearch.scrollDuration);
        });

        me.writeSchedules();
    },
    writeSchedules: function(churchId) {
        var me = this;
        var tablecount = 0;

        $.each(me.churchMeta.ordered, function(i, churchId) {
            var church = me.churches[churchId];
            var html = '';
            
            if (!tablecount) {
                $.each(church.schedule, function(k, v) {
                    tablecount++;
                });
            }

            $.each(me.lookups.filters.orderedValues, function(i, filter) {
                if (church.schedule[filter]) {
                    var heading =  (!i && tablecount <= 1) ? '' :
                        '<h3 class="text-center">' + filter + ' Schedule</h3>\n';
                    var table = [me.lookups.weekdays.orderedValues];
                    var row = 0;

                    $.each(me.lookups.types.orderedValues, function(j, type) {
                        if (church.schedule[filter][type]) {
                            table.push([]);
                            row++;

                            $.each(me.lookups.weekdays.orderedIds, function(k, day) {
                                var keys = [];

                                $.each(church.schedule[filter][type][day], function(name, times) {
                                    keys.push(name);
                                });

                                keys.sort();
                                var td = '<span class="semi-strong">' + type + '</span>\n';
                                td += '<span class="hidden-xs"><br /></span>\n';

                                if (keys.length) {
                                    var firstKey = true;

                                    $.each(keys, function(l, name) {
                                        var lastKey = (l == (keys.length - 1));

                                        if (!firstKey) {
                                            td += '<br />\n';
                                        } else if (!lastKey) {
                                            td += '<span class="visible-xs-inline"><br /></span>\n';
                                        }

                                        if (name) {
                                            td += '<em>' + name + '</em>\n';
                                            td += '<span class="hidden-xs"><br /></span>\n';
                                        }
                                        
                                        td += church.schedule[filter][type][day][name]
                                            .join(
                                                '<span class="hidden-xs"><br /></span>' +
                                                '<span class="visible-xs-inline"> | </span>'
                                            );
                                        td += '<br />\n';

                                        firstKey = false;
                                    });
                                } else {
                                    td += '&mdash;\n';
                                }

                                table[row].push(td);
                            });
                        }
                    });

                    /**
                     * This creates a 7 column wide table that collapses down
                     * to 1 column for xs screen sizes. To do it, I create two
                     * tables, one that's only visible for xs sizes, and one that's
                     * visible the rest of the time. I tried to do it in one shot
                     * but there was no simple way to get individual divs to all
                     * have the same height like cells of the same table row do.
                     */
                    html += (html) ? '\n' + heading : heading;
                    var filterClass = 'filter' + me.lookups.filters.getId[filter];
                    html += '<div class="visible-xs-block">\n';
                    html += '<table class="table ' + filterClass + '">\n<tbody>\n';

                    for (var y = 0; y < 7; y++) {
                        var dayClass = 'weekday' + me.lookups.weekdays.getId[table[0][y]];

                        for (var x = 0; x <= row; x++) {
                            var td = (x == 0) ? "th" : "td";
                            html += '<tr>\n<' + td + ' class="' + dayClass + '">\n';
                            html += table[x][y] + '</td>\n</tr>\n';
                        }
                    }

                    html += '</tbody>\n</table>\n</div>\n';
                    html += '<div class="hidden-xs">\n<table class="table ' + filterClass + '">\n';

                    for (var x = 0; x <= row; x++) {
                        if (x <= 1) {
                            html += (x) ? '<tbody>\n' : '<thead>\n';
                        }

                        html += '<tr>\n';

                        for (var y = 0; y < 7; y++) {
                            var td = (x == 0) ? "th" : "td";
                            var dayClass = 'weekday' + me.lookups.weekdays.getId[table[0][y]];
                            html += '<' + td + ' class="' + dayClass + '">\n';
                            html += table[x][y] + '</td>\n';
                        }

                        html += '</tr>\n';

                        if (!x || x == row) {
                            html += (x) ? '</tbody>\n' : '</thead>\n';
                        }
                    }

                    html += '</table>\n</div>\n';
                }
            });

            $('.schedule-' + churchId).html(html);
        });
    },
    drawTimeline: function() {
        var me = this;
        me.timeline.dataTable = new google.visualization.DataTable();
        me.timeline.data = [];
        me.timeline.rowsToChurchIds = { };
        var row = 0;
        var uniqueChurches = { };
        var height = me.timeline.rowHeight + 10; //magic number, 10 makes it work no scroll bar

        if (me.timeline.hasOwnProperty('chart')) {
            me.timeline.chart.clearChart();
        }

        $.each(me.timeline.columns, function(i, column) {
            me.timeline.dataTable.addColumn(column);
        });
        
        $.each(me.churchMeta.ordered, function(i, churchId) {
            $.each(me.churches[churchId].events, function(j, eventId) {
                if (me.eventMeta.days[me.currentDay].display[eventId]) {
                    me.timeline.data.push([
                        me.churches[churchId].nickname,
                        (me.events[eventId].event) ?
                            me.events[eventId].event : me.events[eventId].eventType,
                        me.getTime('start', eventId),
                        me.getTime('stop', eventId),
                    ]);

                    me.timeline.rowsToChurchIds[row] = churchId;
                    row++;

                    if (!uniqueChurches.hasOwnProperty(me.churches[churchId].nickname)) {
                        height += me.timeline.rowHeight;
                        uniqueChurches[me.churches[churchId].nickname] = true;
                    }
                }
            });
        });

        $('#' + me.timeline.divId).height(height);
        me.timeline.dataTable.addRows(me.timeline.data);
        me.timeline.chart = new google.visualization.Timeline(document.getElementById(me.timeline.divId));
        me.timeline.options = {
            tooltip: { trigger : 'none' },
            height: height,
            backgroundColor: '#fff8e1',
            colors: [
                '#795548',
                '#ffc107',
                '#f44336',
                '#673ab7',
                '#2196f3',
                '#4caf50',
                '#ff5722',
                '#e91e63',
                '#3f51b5',
                '#8bc34a',
                '#ffeb3b',
                '#607d8b',
                '#9c27b0',
                '#03a9f4',
                '#ff9800',
                '#009688',
                '#00bcd4',
                '#cddc39',
                '#9e9e9e',
            ],
        };
        me.timeline.chart.draw(me.timeline.dataTable, me.timeline.options);
        google.visualization.events.addListener(me.timeline.chart, 'select', function() {
            $.scrollTo(
                '.church-' + me.timeline.rowsToChurchIds[me.timeline.chart.getSelection()[0].row],
                saintAnthonySearch.scrollDuration
            );
        });
        $('.instructions').removeClass('hidden');
        me.highlightSchedules();
    },
    calculateDisplayable: function(singleDay) {
        var me = this;
        var dates = me.eventMeta.days;
        me.churchMeta.display = { };
        $('.church').addClass('hidden');

        $.each(me.churchMeta.ordered, function(i, churchId) {
            me.churchMeta.display[churchId] = false;
        });

        if (singleDay && me.eventMeta.days.hasOwnProperty(singleDay)) {
            dates = { };
            dates[singleDay] = me.eventMeta.days[singleDay];
        }

        $.each(me.events, function(eventId, e) {
            $.each(dates, function(day, d) {
                if (!me.eventMeta.days[day].hasOwnProperty('display')) {
                    me.eventMeta.days[day].display = { };
                }

                if (!me.eventMeta.days[day].display.hasOwnProperty(eventId)) {
                    me.eventMeta.days[day].display[eventId] = (
                        e.startDate <= d.date && d.date <= e.stopDate &&
                        e.startMonth <= d.month && d.month <= e.stopMonth &&
                        e.startWeek <= d.weekOfMonth && d.weekOfMonth <= e.stopWeek &&
                        e.startDay <= d.dayOfWeek && d.dayOfWeek <= e.stopDay &&
                        e.eventFilterId <= 2
                    ) ? e.churchId : false;
                }
            });

            if (me.eventMeta.days[me.currentDay].display[eventId]) {
                var churchId = me.eventMeta.days[me.currentDay].display[eventId];
                me.churchMeta.display[churchId] = true;
                $('.church-' + churchId).removeClass('hidden');
            }
        });
    },
    highlightSchedules: function() {
        var me = this;
        var dayClass = 'weekday' + me.eventMeta.days[me.currentDay].dayOfWeek;
        var selector = [];
        $('.schedule table th, .schedule table td').removeClass('active');
        
        $.each([1, 2], function(i, id) {
            $.each(['th', 'td'], function(j, td) {
                selector.push('.filter' + id + ' ' + td + '.' + dayClass);
            });
        });

        $(selector.join(', ')).addClass('active');

    },
    getTime: function(which, eventId) {
        var me = this;
        which = (which == 'stop') ? 'stop' : 'start';
        return new Date(
            me.eventMeta.days[me.currentDay]['year'],
            me.eventMeta.days[me.currentDay]['monthJs'],
            me.eventMeta.days[me.currentDay]['day'],
            me.events[eventId][which + 'Hour'],
            me.events[eventId][which + 'Minute'],
            me.events[eventId][which + 'Second']
        );
    },
}