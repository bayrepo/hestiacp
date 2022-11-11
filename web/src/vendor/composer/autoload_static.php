<?php

// autoload_static.php @generated by Composer

namespace Composer\Autoload;

class ComposerStaticInitad49aa92feae01e661d9db6c08b45fab
{
    public static $prefixLengthsPsr4 = array (
        'W' =>
        array (
            'Whoops\\' => 7,
        ),
        'P' =>
        array (
            'Psr\\Log\\' => 8,
        ),
        'H' =>
        array (
            'Hestia\\' => 7,
        ),
    );

    public static $prefixDirsPsr4 = array (
        'Whoops\\' =>
        array (
            0 => __DIR__ . '/..' . '/filp/whoops/src/Whoops',
        ),
        'Psr\\Log\\' =>
        array (
            0 => __DIR__ . '/..' . '/psr/log/Psr/Log',
        ),
        'Hestia\\' =>
        array (
            0 => __DIR__ . '/../..' . '/app',
        ),
    );

    public static function getInitializer(ClassLoader $loader)
    {
        return \Closure::bind(function () use ($loader) {
            $loader->prefixLengthsPsr4 = ComposerStaticInitad49aa92feae01e661d9db6c08b45fab::$prefixLengthsPsr4;
            $loader->prefixDirsPsr4 = ComposerStaticInitad49aa92feae01e661d9db6c08b45fab::$prefixDirsPsr4;

        }, null, ClassLoader::class);
    }
}
