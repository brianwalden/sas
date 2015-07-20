<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        {{ get_title() }}

        {{ assets.outputCss('headerCss') }}
        {{ assets.outputJs('headerJs') }}
    </head>
    <body>
        <header>
            <nav class="navbar navbar-sas">
                <div class="container-fluid">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand navlink-index navlink" href="/">St. Anthony Search</a>
                    </div>

                    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                        <ul class="nav navbar-nav">
                            <li class="navlink-about"><a class="navlink" href="/about">About</a></li>
                        </ul>
                    </div>
                </div>
            </nav>
        </header>

        <div class="container-fluid">
            {{ content() }}
        </div>

        <footer class="text-center light italic">
            Saint Anthony Search is a lay project and is not associated with the Catholic Church or any of its particular churches
        </footer>

        {{ assets.outputJs('footerJs') }}

        <script>
            $(document).ready(function() {
                saintAnthonySearch.initialize('{{controller}}');
                {% if !(onload is empty) %}
                {{ onload }}
                {% endif %}
            });   
        </script>
    </body>
</html>