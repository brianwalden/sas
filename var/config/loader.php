<?php

/**
 * We're a registering a set of namespaces taken from the configuration file
 */
$namespaces = [];
$configArray = $config->toArray();

foreach ($configArray['namespaces'] as $namespace => $path) {
    $namespaces[$namespace] = APP_PATH . $path;
}

$loader = new \Phalcon\Loader();
$loader->registerNamespaces($namespaces);
$loader->register();
