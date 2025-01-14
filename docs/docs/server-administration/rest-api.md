# REST API

Hestia REST API доступен для выполнения основных функций панели управления. Например, мы используем его для внутренней синхронизации кластеров DNS и интеграции биллинговой системы WHMCS. API также можно использовать для создания новых учетных записей пользователей, доменов, баз данных или даже для создания альтернативного веб-интерфейса.

[Справочник API](../reference/api.md) предоставляет примеры кода PHP, демонстрирующие, как можно интегрировать API в приложение или скрипт. Однако вы также можете использовать любой другой язык для взаимодействия с API.

С выпуском Hestia v1.6.0 мы представили более продвинутую систему API, которая позволит пользователям, не являющимся администраторами, использовать определенные команды.

## Я не могу подключиться к API

С выпуском Hestia v1.4.0 мы решили усилить безопасность. Если вы хотите подключиться к API с удаленного сервера, вам сначала нужно будет добавить его IP-адрес в белый список. Чтобы добавить несколько адресов, разделите их новой строкой.

## Можно ли отключить API?

Да, вы можете отключить API через настройки сервера. Файл будет удален с сервера, а все соединения будут игнорироваться. Обратите внимание, что некоторые функции могут не работать при отключенном API.

## Пароль, ключ API или ключи доступа

### Пароль

- Должен использоваться только администратором.
- Изменение пароля администратора требует его обновления везде, где он используется.
- Разрешено запускать все команды.

### Ключ API

- Должен использоваться только администратором.
- Изменение пароля администратора не имеет последствий.
- Разрешено запускать все команды.

### Ключи доступа

- Зависит от пользователя.
- Может ограничивать разрешения. Например, только `v-purge-nginx-cache`.
- Возможность отключить вход другими методами, но при этом разрешить использование ключей API
- Может быть ограничено только администратором или разрешено всем пользователям.

## Настройка аутентификации по ключу доступа/секретному ключу

Чтобы создать ключ доступа, следуйте [руководству в нашей документации](../user-guide/account.md#api-access-keys).

Если используемое вами программное обеспечение уже поддерживает формат хэша, используйте `ACCESS_KEY:SECRET_KEY` вместо старого ключа API.

## Создание ключа API

::: warning
Этот метод был заменен на указанную выше аутентификацию по ключу доступа/секретному ключу. Мы **настоятельно** рекомендуем использовать этот более безопасный метод.
:::

Запустите команду `v-generate-api-key`.

## Коды возврата

| Значение | Имя | Комментарий |
| ----- | ------------- | ------------------------------------------------------------ |
| 0 | OK | Команда успешно выполнена |
| 1 | E_ARGS | Недостаточно аргументов |
| 2 | E_INVALID | Недопустимый объект или аргумент |
| 3 | E_NOTEXIST | Объект не существует |
| 4 | E_EXISTS | Объект уже существует |
| 5 | E_SUSPENDED | Объект уже приостановлен |
| 6 | E_UNSUSPENDED | Объект уже разблокирован |
| 7 | E_INUSE | Объект не может быть удален, так как он используется другим объектом |
| 8 | E_LIMIT | Объект не может быть создан из-за ограничений пакета хостинга |
| 9 | E_PASSWORD | Неверный / недействительный пароль |
| 10 | E_FORBIDEN | Этот пользователь не может получить доступ к объекту |
| 11 | E_DISABLED | Подсистема отключена |
| 12 | E_PARSING | Конфигурация нарушена |
| 13 | E_DISK | Недостаточно места на диске для завершения действия |
| 14 | E_LA | Сервер слишком занят для завершения действия |
| 15 | E_CONNECT | Соединение не удалось. Хост недоступен |
| 16 | E_FTP | FTP-сервер не отвечает |
| 17 | E_DB | Сервер базы данных не отвечает |
| 18 | E_RDD | RRDtool не удалось обновить базу данных |
| 19 | E_UPDATE | Операция обновления не удалась |
| 20 | E_RESTART | Перезапуск службы не удался |