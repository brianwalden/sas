saintAnthonySearch = {
    scrollDuration: 500,
    initialize: function(controller) {
        var me = this;
        me.controller = controller;
        me.makeSizeAdjustments();
        me.setNavbar();
    },
    setNavbar: function() {
        var me = this;
        var className = '.navlink-' + me.controller;
        var suffix = (me.controller == 'index') ? '' : ' > a';
        $(className).addClass('active');
        $(className + suffix).append(' <span class="sr-only">(current)</span>');
    },
    makeSizeAdjustments: function() {
        var me = this;
        var size = me.getBootstrapSize();

        if (size == 'xs') {
            $('.pageHead').removeClass('h2').addClass('h3');
        }
    },
    getBootstrapSize: function () {
        var me = this;
        var width = $(document).width();
        var size = 'xs';
        
        if (width >= 992) {
            size = (width >= 1200) ? 'lg' : 'md';
        } else if (width >= 768) {
            size = 'sm';
        }

        return size;
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
