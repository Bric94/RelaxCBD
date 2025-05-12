<?php

use App\Kernel;

require_once dirname(__DIR__) . '/vendor/autoload_runtime.php';

ini_set('session.gc_maxlifetime', 0);
ini_set('session.cookie_lifetime', 31536000);

return function (array $context) {
    return new Kernel($context['APP_ENV'], (bool) $context['APP_DEBUG']);
};
