var sasTimeline = {
    timeline: {
        divId: 'timeline',
        columns: [
            { type: 'string', id: 'Church' },
            { type: 'string', id: 'Sacrament' },
            { type: 'date', id: 'Start' },
            { type: 'date', id: 'End' },
        ],
        rowHeight: 41,
    },
    initialize: function(divId) {
        var me = this;

        $('.dayLink').click(function() {
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
        var size = saintAnthonySearch.getBootstrapSize();

        if (size == 'xs') {
            $('.dayLink').addClass('btn-xs');
            $('.dayTh').addClass('dayTh-xs');
        }

        $.each(me.eventMeta.days, function(day, props) {
            var id = props['dayOfWeek'];
            var weekday = props['dayOfWeekHuman'];
            var month = props['monthHuman'] + ' '; 
            var showDay = props['dayHuman'];

            if (size == 'sm') {
                month = month.substr(0, 3) + ' '; 
            } else if (size == 'xs') {
                weekday = weekday.substr(0, 3);
                month = props['month'] + '/';
                showDay = props['day'];
            }

            $('.dayLink-' + id).prop('id', props['date']).html(
                weekday + '<br /><span class="small">' + month + showDay + '</span>'
            );

            if (day == me.currentDay) {
                $('.dayTh-' + id).addClass('active');
            } else {
                $('.dayTh-' + id).removeClass('active');
            }
        });

        $('.searchAlert').addClass('hidden');
        $('.dayTable').removeClass('hidden');
    },
    writeChurches: function() {
        var me = this;
        var html = '';
        var size = saintAnthonySearch.getBootstrapSize();
        var headClass = 'h3';
        var buttonClass = '';

        if (size == 'xs') {
            headClass = 'h4';
            buttonClass = 'btn-sm';
        }

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
                        '<div class="pull-right">',
                            '<button type="button" class="btn btn-link ' + buttonClass + ' scrollUp">',
                                '<span class="glyphicon glyphicon-arrow-up" aria-hidden="true"></span>',
                                '<span class="sr-only">Scroll:</span>',
                                'Top',
                            '</button>',
                        '</div>',
                        '<div class="pull-left">',
                            '<h2 class="' + headClass + '">' + church.church + '</h2>',
                        '</div>',
                        '<div class="clearfix"></div>',
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
        $('.scrollUp').off('click');
        $('.scrollUp').on('click', function() {
            $.scrollTo(0, saintAnthonySearch.scrollDuration);
        });

        me.writeSchedules();
    },
    writeSchedules: function(churchId) {
        var me = this;
        var tablecount = 0;
        var size = saintAnthonySearch.getBootstrapSize();
        var headClass = (size == 'xs') ? 'h5 semi-strong' : 'h4';

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
                        '<h3 class="' + headClass + ' text-center">' + filter + ' Schedule</h3>';
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
                                var td = '<div class="semi-strong">' + type + '</div>';

                                if (keys.length) {
                                    var first = true;

                                    $.each(keys, function(l, name) {
                                        td += [
                                            (first) ? '' : '<div>&nbsp;</div>', //HACK!
                                            (name) ? '<div><em>' + name + '</em><div>' : '',
                                            '<div>' +
                                                church.schedule[filter][type][day][name]
                                                    .join('</div><div>') +
                                            '</div>',
                                        ].join(''); 
                                    });
                                } else {
                                    td += '<div>&mdash;</div>';
                                }

                                table[row].push(td);
                            });
                        }
                    });

                    html += (html) ? '\n' + heading : heading;
                    html += '<div class="visible-xs-block">\n<table class="table">\n';

                    for (var y = 0; y < 7; y++) {
                        for (var x = 0; x <= row; x++) {
                            td = (x == 0) ? 'th' : 'td';
                            html += '<tr><' + td + '>' + table[x][y] + '</' + td + '></tr>\n';
                        }
                    }

                    html += '</table>\n</div>\n<div class="hidden-xs">\n<table class="table">\n';

                    for (var x = 0; x <= row; x++) {
                        if (x == 0) {
                            html += '<thead>\n'; 
                        } else if (x == 1) {
                            html += '<tbody>\n';
                        }

                        html += '<tr>\n';

                        for (var y = 0; y < 7; y++) {
                            td = (x == 0) ? 'th' : 'td';
                            html += '<' + td + '>' + table[x][y] + '</' + td + '>\n';
                        }

                        html += '</tr>\n';

                        if (x == 0) {
                            html += '</thead>\n'; 
                        } else if (x == row) {
                            html += '</tbody>\n';
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