saintAnthonySearch = {
    scrollDuration: 500,
    initialize: function(controller) {
        var me = this;
        me.controller = controller;
        me.setNavbar();
    },
    setNavbar: function() {
        var me = this;
        var className = '.navlink-' + me.controller;
        var suffix = (me.controller == 'index') ? '' : ' > a';
        $(className).addClass('active');
        $(className + suffix).append(' <span class="sr-only">(current)</span>');
    },
    fillContact: function() {
        var me = this;
        $('.contact-domain').append(['@ou', 'tloo', 'k.com'].join(''));

        var links = [
            {
                selector: '.contact-github',
                href: 'https://github.com/brianwalden/sas',
                anchorText: 'github.com/brianwalden/sas'
            },
        ];

        //set links that are used in multiple locations
        $.each(links, function(i, link) {
            $(link.selector).html(
                '<a href="' + link.href + '" target="_blank">' + link.anchorText + '</a>'
            );
        });
    }
}
