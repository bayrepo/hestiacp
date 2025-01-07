# PHP cli selector

PHP cli селектор заменяет системный - `/usr/bin/php` ссылкой на утилиту, которая анализирует конфигурационный файл пользователя HestiaCP и запускает установленную для пользователя версию PHP.

Пример:

```
# readlink -f /usr/bin/php
/usr/bin/hestiacp-php-selector
```
По умолчанию php cli селектор отключен и системным PHP является стандартный бинарный файл PHP приносимый пакетами системы.
Для включения PHP cli селектора необходимо перейти в "Server Options"->"Options"->"Web-server".
Найти селектор "Syetem PHP" и под селектором установить чекбокс "Use PHP cli selector".

![php_cli_selector](/images/php_cli_selector.png)
