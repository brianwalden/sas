{# index/index.volt #}

<h1 class="page-head text-center">St. Anthony Help Me Find: Churches in Albany</h1>

<div class="alert alert-sas search-alert text-center" role="alert">Searching...</div>

<div class="alert alert-sas holiday hidden text-center">
    <span class="holiday-today"></span> is <span class="holiday-name"></span>
    and schedules may be different from what's listed here.
    Please confirm all times with the church.
</div>

<div class="alert alert-sas instructions hidden" role="alert">
    <div class="row">
        <div class="col-xs-10 col-sm-offset-1 message">
            Click a bar in the timeline for details
        </div>
        <div class="col-xs-2 col-sm-1 text-right">
            <button type="button" class="btn btn-link remove">
                <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
                <span class="sr-only">Close</span>
            </button>
        </div>
    </div>
</div>

<div class="row day-nav hidden topLeft topRight">
    <div class="col-xs-1 day-col-1 text-center">
        <button type="button" class="btn btn-link"></button>
    </div>
    <div class="col-xs-1 day-col-2 text-center">
        <button type="button" class="btn btn-link"></button>
    </div>
    <div class="col-xs-1 day-col-3 text-center">
        <button type="button" class="btn btn-link"></button>
    </div>
    <div class="col-xs-1 day-col-4 text-center">
        <button type="button" class="btn btn-link"></button>
    </div>
    <div class="col-xs-1 day-col-5 text-center">
        <button type="button" class="btn btn-link"></button>
    </div>
    <div class="col-xs-1 day-col-6 text-center">
        <button type="button" class="btn btn-link"></button>
    </div>
    <div class="col-xs-1 day-col-7 text-center">
        <button type="button" class="btn btn-link"></button>
    </div>
</div>


<div id="timeline"></div>

<div class="churches"></div>
