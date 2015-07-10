<?php

namespace Brianwalden\SAS\Controllers;

use Phalcon\Mvc\Controller;
use Phalcon\Http\Response;

abstract class BaseController extends Controller
{
    const TITLE_BASE = 'St. Anthony Search';
    const TITLE_SEPARATOR = ' | ';
    const LAYOUT = 'base';

    protected static $defaultAssets = [
        'headerCss' => [
            'addCss' => [
                '//fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800,300italic,400italic,600italic,700italic,800italic' => false,
                '//maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css' => false,
                'css/style.css' => true,
            ],
        ],
        'headerJs' => ['addJs' => [ '//code.jquery.com/jquery-2.1.4.min.js' => false ]],
        'footerJs' => [
            'addJs' => [
                '//maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js' => false,
                '//cdn.jsdelivr.net/jquery.scrollto/2.1.0/jquery.scrollTo.min.js' => false,
                'js/script.js' => true,
            ],
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
        $validCollections = array_keys(static::$defaultAssets);

        if (!$assets) {
            $assets = static::$defaultAssets;
        }

        foreach ($assets as $collection => $asset) {
            if (array_key_exists($collection, static::$defaultAssets)) {
                foreach ($asset as $method => $resources) {
                    if (array_key_exists($method, static::$defaultAssets[$collection])) {
                        foreach ($resources as $resource => $isLocal) {
                            $this->assets->collection($collection)->$method($resource, $isLocal);
                        }
                    }
                }
            }
        }
    }

    protected function ajaxResponse($content, $toJson = true)
    {
        if (!$this->request->isAjax()) {
            $content = json_encode(['error' => "Invalid Request"]);
        } elseif ($toJson) {
            $content = json_encode($content);
        }

        $response = new Response();
        $response->setStatusCode(200, 'OK');
        $response->setContentType('application/json', 'UTF-8');
        $response->setContent($content);
        return $response;
    }
}
