function initializeContactPage(controller) {
    var className = '.navlink-' + controller;
    var suffix = (controller == 'index') ? '' : ' > a';
    var links = [
        { selector: '.contact-github', href: 'https://github.com/brianwalden/', anchorText: 'github.com/brianwalden' },
    ];

    // set the active navbar link
    $(className).addClass('active');
    $(className + suffix).append(' <span class="sr-only">(current)</span>');

    // lets try to keep contact info from being scraped
    if (controller == "contact" || controller == "resume") {
        $('.contact-domain').append(['@ou', 'tloo', 'k.com'].join(''));
        $('.contact-area').html('518');
        $('.contact-prefix').html('772');
        $('.contact-line').html('9133');
        $('.contact-house').html('115');
        $('.contact-philosopher').html('Euclid');
        $('.contact-hail').html('Ave');
        $('.contact-zip').html('12203');

        //set links that are used in multiple locations
        $.each(links, function(i, link) {
            $(link.selector).html('<a href="' + link.href + '" target="_blank">' + link.anchorText + '</a>');
        });
    }   
}
