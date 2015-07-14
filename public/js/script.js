saintAnthonySearch = {
    scrollDuration: 500,
    initialize: function(controller) {
        var me = this;
        me.controller = controller;
        me.setNavbar();
        $('.instructions .remove').click(function() {
            $('.instructions').addClass('hidden');
        });
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
        $('.contact-area').html('518');
        $('.contact-prefix').html('772');
        $('.contact-line').html('9133');
        $('.contact-house').html('115');
        $('.contact-philosopher').html('Euclid');
        $('.contact-hail').html('Ave');
        $('.contact-zip').html('12203');

        var links = [
            {
                selector: '.contact-github',
                href: 'https://github.com/brianwalden/',
                anchorText: 'github.com/brianwalden'
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
