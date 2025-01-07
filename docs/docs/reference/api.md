# API

::: info
Эта страница находится в разработке. Много информации будет отсутствовать.
:::

## Примеры

Примеры можно найти в отдельном [репозитории](https://dev.brepo.ru/brepo/hestiacp-api-examples).

## Обновление с аутентификации по имени пользователя/паролю на доступ/секретные ключи

Замените следующий код:

```php
// Подготовка запроса POST
$postvars = [
"user" => $hst_username,
"password" => $hst_password,
"returncode" => $hst_returncode,
"cmd" => $hst_command,
"arg1" => $username,
];
```

С помощью следующего:

```php
// Подготовить запрос POST
$postvars = [
"hash" => "access_code:secret_code",
"returncode" => $hst_returncode,
"cmd" => $hst_command,
"arg1" => $username,
];
```