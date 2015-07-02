prettyChart = {
    settingsVar: 'timelineData',
    initialize: function() {
        var me = prettyChart;
        me.dataTable = new google.visualization.DataTable();

        $.each(window[me.settingsVar], function(key, value) {
            me[key] = value;
        });
        
        $.each(me.columns, function(i, column) {
            me.dataTable.addColumn(column);
        });
        
        me.dataTable.addRows(me.data);
        me.container = document.getElementById(me.divId);
        me.chart = new google.visualization.Timeline(me.container);
        me.draw();
    },
    draw: function() {
        var me = this;
        me.chart.draw(me.dataTable);
    },
}

google.setOnLoadCallback(prettyChart.initialize);