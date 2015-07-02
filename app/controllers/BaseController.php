<?php

namespace Brianwalden\SAS\Controllers;

use Phalcon\Mvc\Controller;

abstract class BaseController extends Controller
{
    const TITLE_BASE = 'St. Anthony Search';
    const TITLE_SEPARATOR = ' | ';
    const LAYOUT = 'base';

    protected static $defaultAssets = [
        'addCss' => [
            '//fonts.googleapis.com/css?family=Montserrat' => false,
            '//maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css' => false,
            'css/style.css' => true,
        ],
        'addJs' => [
            '//code.jquery.com/jquery-2.1.4.min.js' => false,
            '//maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js' => false,
            'js/script.js' => true,
        ],
    ];

    protected $controller;
    protected $action;
    protected $params;

    protected function initialize()
    {
        foreach (['controller', 'action'] as $part) {
            $method = 'get' . ucfirst($part) . 'Name';
            $this->$part = $this->dispatcher->$method();
            $this->view->setVar($part, $this->$part);
        }

        if (static::LAYOUT) {
            $this->view->setLayout(static::LAYOUT);
        }

        $this->params = $this->dispatcher->getParams();
        $this->setTitle();
        $this->addAssets();
    }

    /**
     * set page title
     *
     * @param array $parts array with keys 'base', 'controller', 'action'
     *     if any keys are not set, the default will be used
     *
     * @return void
     */
    protected function setTitle(array $parts = array())
    {
        foreach (['base', 'controller', 'action'] as $part) {
            $isPartSet = isset($parts[$part]);

            if ($part == 'base') {
                $this->tag->setTitle(($isPartSet) ? $parts[$part] : static::TITLE_BASE);
                $this->tag->setTitleSeparator(static::TITLE_SEPARATOR);
            } else {
                $value = ($isPartSet) ? $parts[$part] : $this->$part;
                
                if ($value && $value != "index") {
                    $this->tag->appendTitle(ucfirst($value));
                }
            }
        }
    }

    /**
     * Add assets to the asset mannager
     *
     * @param array $assets, if empty defaults to static::$defaultAssets
     *
     * @return void
     */
    protected function addAssets(array $assets = array())
    {
        $validMethods = array_keys(static::$defaultAssets);

        if (!$assets) {
            $assets = static::$defaultAssets;
        }

        foreach ($assets as $method => $resources) {
            if (in_array($method, $validMethods)) {
                foreach ($resources as $resource => $isLocal) {
                    $this->assets->$method($resource, $isLocal);
                }
            }
        }
    }
}
