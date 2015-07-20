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
        conflictHeight: 30, //google charts height for each "stacked" time bar per row
        showInstructions: true,
    },
    initialize: function(divId) {
        var me = this;

        $('.day-nav button').click(function() {
            me.currentDay = this.id;
            me.refresh(me.currentDay);
        });

        $('.instructions .remove').click(function() {
            me.timeline.showInstructions = false;
            $('.instructions').addClass('hidden');
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
        me.highlightSchedules();
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
                var holiday = false;
                
                if (props['isHolyDay']) {
                    holiday = props['isHolyDay'];
                } else if (props['isVigil']) {
                    holiday = props['isVigil'];
                } else if (props['isHoliday']) {
                    holiday = props['isHoliday']
                }

                if (holiday) {
                    $('.holiday-today').html((props['isToday']) ? 'Today' : props['dayOfWeekHuman']);
                    $('.holiday-name').html(holiday)
                    $('.holiday').removeClass('hidden');
                } else {
                    $('.holiday').addClass('hidden');
                }
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

        $.each(me.churchMeta.ordered, function(i, churchId) {
            var church = me.churches[churchId];
            var html = '';
            var scheduleCount = 0;
            
            $.each(church.schedule, function(k, v) {
                scheduleCount++;
            });

            $.each(me.lookups.filters.orderedValues, function(i, filter) {
                if (church.schedule[filter]) {
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

                    var heading = church.nickname;
                    
                    if (i || scheduleCount > 1) {
                        heading += ' ' + filter.replace(/ \(.*\)/, '');
                    }

                    heading += ' Schedule';

                    /**
                     * This creates a 7 column wide table that collapses down
                     * to 1 column for xs screen sizes. To do it, I create two
                     * tables, one that's only visible for xs sizes, and one that's
                     * visible the rest of the time. I tried to do it in one shot
                     * but there was no simple way to get individual divs to all
                     * have the same height like cells of the same table row do.
                     */
                    html += (html) ? '\n' : '';
                    html += '<div class="filter filter-' + me.lookups.filters.getId[filter] + ' hidden">\n';
                    html += '<h3 class="text-center">' + heading + '</h3>\n';
                    html += '<div class="visible-xs-block">\n';
                    html += '<table class="table">\n<tbody>\n';

                    for (var y = 0; y < 7; y++) {
                        var dayClass = 'weekday' + me.lookups.weekdays.getId[table[0][y]];

                        for (var x = 0; x <= row; x++) {
                            var td = (x == 0) ? "th" : "td";
                            html += '<tr>\n<' + td + ' class="' + dayClass + '">\n';
                            html += table[x][y] + '</td>\n</tr>\n';
                        }
                    }

                    html += '</tbody>\n</table>\n</div>\n';
                    html += '<div class="hidden-xs">\n<table class="table">\n';

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

                    html += '</table>\n</div>\n</div\n>';
                }
            });

            if (scheduleCount > 1) {
                html += '<div class="panel-body more-schedules text-center">\n';
                html += '<button type="button" class="btn btn-link" id="more-schedules-' + churchId + '">\n';
                html += 'Show more schedules\n</button>\n</div>\n';
            }

            $('.schedule-' + churchId).html(html);
        });

        $('.more-schedules button').click(function() {
            var id = this.id.split('-')[2];
            $('.schedule-' + id + ' .filter').removeClass('hidden');
            $('.schedule-' + id + ' div.more-schedules').addClass('hidden');
        });
    },
    drawTimeline: function() {
        var me = this;
        me.timeline.dataTable = new google.visualization.DataTable();
        me.timeline.data = [];
        me.timeline.rowsToChurchIds = { };
        var row = 0;
        var conflicts = { };
        var height = me.timeline.rowHeight + 10; //magic number, 10 makes it work no scroll bar
        var typeNames = { };
        var colors = [];

        if (me.timeline.hasOwnProperty('chart')) {
            me.timeline.chart.clearChart();
        }

        $.each(me.timeline.columns, function(i, column) {
            me.timeline.dataTable.addColumn(column);
        });
        
        $.each(me.churchMeta.ordered, function(i, churchId) {
            $.each(me.churches[churchId].events, function(j, eventId) {
                if (me.eventMeta.days[me.currentDay].display[eventId]) {
                    var e = me.events[eventId];
                    me.timeline.data.push([
                        me.churches[churchId].nickname,
                        (e.event) ? e.event : e.eventType,
                        me.getTime('start', eventId),
                        me.getTime('stop', eventId),
                    ]);

                    /**
                     * this is so we can send the user to the church details when
                     * they click on a bar in the chart
                     */
                    me.timeline.rowsToChurchIds[row] = churchId;
                    row++;

                    /**
                     * Tell google how to color each event
                     */
                    if (!typeNames.hasOwnProperty(e.eventTypeId)) {
                        typeNames[e.eventTypeId] = { };
                    }

                    if (!typeNames[e.eventTypeId].hasOwnProperty(e.event)) {
                        typeNames[e.eventTypeId][e.event] = true;
                        colors.push(me.eventMeta.colors[e.eventTypeId]);
                    }

                    /**
                     * this is a big complicated process to figure out if google
                     * will need to use more than 1 row per church to display all
                     * the events and adjust the chart height accordingly
                     */
                    if (!conflicts.hasOwnProperty(churchId)) {
                        height += me.timeline.rowHeight;
                        conflicts[churchId] = [[]];
                    }

                    var conflict = false;
                    var stack = 0;

                    $.each(conflicts[churchId], function (i, segments) {
                        conflict = false;

                        $.each(segments, function(j, times) {
                            if (
                                (e.startTime >= times.start && e.startTime < times.stop) ||
                                (e.stopTime > times.start && e.stopTime <= times.stop)
                            ) {
                                conflict = true;
                                return false;
                            }
                        });

                        if (!conflict) {
                            stack = i;
                            return false;
                        }
                    });

                    if (conflict) {
                        height += me.timeline.conflictHeight;
                        stack = conflicts[churchId].length;
                        conflicts[churchId][stack] = [];
                    }

                    conflicts[churchId][stack].push({ start: e.startTime, stop: e.stopTime });
                }
            });
        });

        $('#' + me.timeline.divId).height(height);
        me.timeline.dataTable.addRows(me.timeline.data);
        me.timeline.chart = new google.visualization.Timeline(document.getElementById(me.timeline.divId));
        me.timeline.options = { height: height, backgroundColor: '#fff8e1', colors: colors };
        me.timeline.chart.draw(me.timeline.dataTable, me.timeline.options);
        
        google.visualization.events.addListener(me.timeline.chart, 'select', function() {
            $.scrollTo(
                '.church-' + me.timeline.rowsToChurchIds[me.timeline.chart.getSelection()[0].row],
                saintAnthonySearch.scrollDuration
            );
        });

        if (me.timeline.showInstructions) {
            $('.instructions').removeClass('hidden');
        }
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
                    var isDisplayable = (
                        e.startDate <= d.date && d.date <= e.stopDate &&
                        e.startMonth <= d.month && d.month <= e.stopMonth && ((
                            e.startWeek <= d.weekOfMonth && d.weekOfMonth <= e.stopWeek
                            ) || e.startWeek == 6 && d.isLastWeekOfMonth
                        ) && e.startDay <= d.dayOfWeek && d.dayOfWeek <= e.stopDay
                    ) ? me.filter(e.eventFilterId, day) : false;

                    me.eventMeta.days[day].display[eventId] = (isDisplayable) ?
                        e.churchId : false;
                }
            });

            if (me.eventMeta.days[me.currentDay].display[eventId]) {
                var churchId = me.eventMeta.days[me.currentDay].display[eventId];
                me.churchMeta.display[churchId] = true;
                $('.church-' + churchId).removeClass('hidden');
            }
        });
    },
    filter: function (eventFilterId, currentDay) {
        var me = this;
        var pass = false;

        if (!currentDay || !me.eventMeta.days.hasOwnProperty(currentDay)) {
            currentDay = me.currentDay;
        }

        var day = me.eventMeta.days[me.currentDay];

        if (eventFilterId == 1) {
            pass = true;
        } else if (eventFilterId == 2) {
            if (!day.isHolyDay && !day.isVigil) {
                pass = true;
            }
        } else if (eventFilterId == 3) {
            if (day.isHolyDay) {
                pass = true;
            }
        } else if (eventFilterId == 4) {
            if (day.isVigil) {
                pass = true;
            }
        } else if (eventFilterId == 5) {
            if (day.isHoliday) {
                pass = true;
            }
        } else if (eventFilterId == 6) {
            if (day.isSeason == "Advent") {
                pass = true;
            }
        } else if (eventFilterId == 7) {
            if (day.isSeason == "Lent") {
                pass = true;
            }
        } else if (eventFilterId == 8) {
            if (day.isSeason == "Advent" || day.isSeason == "Lent") {
                pass = true;
            }
        } else if (eventFilterId == 9) {
            if (!day.isHolyDay && !day.isHoliday) {
                pass = true;
            }
        } else if (eventFilterId == 10) {
            if (!day.isHolyDay && !day.isHoliday && !day.isVigil) {
                pass = true;
            }
        } else if (eventFilterId == 11) {
            if (day.isSeason != "Lent") {
                pass = true;
            }
        }

        return pass;
    },
    highlightSchedules: function() {
        var me = this;
        var dayClass = 'weekday' + me.eventMeta.days[me.currentDay].dayOfWeek;
        var selector = [];
        $('.schedule table th, .schedule table td').removeClass('active');
        
        $.each(me.lookups.filters.orderedIds, function(i, id) {
            $('.filter-' + id).addClass('hidden');
            if (me.filter(id)) {
                $('.filter-' + id).removeClass('hidden');
                $.each(['th', 'td'], function(j, td) {
                    selector.push('.filter-' + id + ' table ' + td + '.' + dayClass);
                });
            }
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