<?php

$loader = new \Phalcon\Loader();

/**
 * We're a registering a set of namespaces taken from the configuration file
 */
$loader->registerNamespaces([
        'Brianwalden\SAS\Controllers' => APP_PATH . $config->application->controllersDir,
        'Brianwalden\SAS\Models' => APP_PATH . $config->application->modelsDir,
        'Brianwalden\SAS\Library' => APP_PATH . $config->application->libraryDir,
        'Brianwalden\SAS\Plugins' => APP_PATH . $config->application->pluginsDir,
]);

$loader->register();
