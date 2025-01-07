# База данных и phpMyAdmin SSO

## Как настроить удаленный сервер базы данных

1. Предполагается, что у вас уже есть второй сервер, который работает.
2. На сервере Hestia выполните следующую команду (`mysql` можно заменить на `postgresql`):

```bash
v-add-database-host mysql new-server.com root password
```

Чтобы убедиться, что хост добавлен, выполните следующую команду:

```bash
v-list-database-hosts
```

## Почему я не могу использовать `http://ip/phpmyadmin/`

В целях безопасности мы решили отключить эту опцию. Вместо этого используйте `https://host.domain.tld/phpmyadmin/`.

## Как включить доступ к `http://ip/phpmyadmin/`

### Для Apache2

```bash
nano /etc/apache2/conf.d/ip.conf

# Добавьте следующий код перед обоими закрывающимися тегами </VirtualHost>
IncludeOptional /etc/apache2/conf.d/*.inc

# Перезапустите apache2
systemctl restart apache2

# Вы также можете добавить следующее в /etc/apache2.conf вместо этого
IncludeOptional /etc/apache2/conf.d/*.inc
```

### Для httpd

```bash
nano /etc/httpd/conf.h.d/ip.conf

# Добавьте следующий код перед обоими закрывающимися тегами </VirtualHost>
IncludeOptional /etc/httpd/conf.h.d/*.inc

# Перезапустите apache2
systemctl restart httpd

# Вы также можете добавить следующее в /etc/apache2.conf вместо этого
IncludeOptional /etc/httpd/conf.h.d/*.inc
```

### Для Nginx

```bash
nano /etc/nginx/conf.d/ip.conf

# Замените следующее
location /phpmyadmin/ {
alias /var/www/document_errors/;
return 404;
}
location /phppgadmin/ {
alias /var/www/document_errors/;
return 404;
}

# На следующее
include /etc/nginx/conf.d/phpmyadmin.inc*;
include /etc/nginx/conf.d/phppgadmin.inc*;
```

## Как подключиться из удаленного расположения к базе данных

По умолчанию соединения с портом 3306 отключены в брандмауэре. Откройте
порт 3306 в брандмауэре ([документация](./firewall.md)), затем отредактируйте `/etc/mysql/mariadb.conf.d/50-server.cnf`:

```bash
nano /etc/mysql/mariadb.conf.d/50-server.cnf

# Установите bind-address на одно из следующих значений
bind-address = 0.0.0.0
bind-address = "your.server.ip.address"
```

## PhpMyAdmin Single Sign On

### Не удалось активировать phpMyAdmin Single Sign on

Убедитесь, что API включен и работает правильно. Функция единого входа PhpMyAdmin Hestia подключается через API Hestia.

### При нажатии кнопки единого входа phpMyAdmin я перенаправляюсь на страницу входа в phpMyAdmin

Иногда автоматизация может вызывать проблемы. Войдите через SSH и откройте `/var/log/{webserver}/domains/{hostname.domain.tld.error.log` и найдите одно из следующих сообщений об ошибке:

- `Невозможно подключиться через API, проверьте подключение API`

1. Проверьте, включен ли API.
2. Добавьте публичный IP вашего сервера в разрешенные IP в **Настройках сервера**.
- `Отказано в доступе: несоответствие токена безопасности`
1. Отключите и снова включите единый вход phpMyAdmin. Это обновит оба ключа.
2. Если вы находитесь за брандмауэром или прокси-сервером, вы можете отключить его и повторить попытку.
- `Срок действия ссылки истек`
1. Обновите страницу базы данных и повторите попытку.

## Удаленные базы данных

При необходимости вы можете просто разместить Mysql или Postgresql на удаленном сервере.

Чтобы добавить удаленную базу данных:

```bash
v-add-database-host TYPE HOST DBUSER DBPASS [MAX_DB] [CHARSETS] [TPL] [PORT]
```

Например:

```bash
v-add-database-host mysql db.hestiacp.com root mypassword 500
```

Если хотите, вы можете настроить phpMyAdmin на хост-сервере, чтобы разрешить подключение к базе данных. Создайте копию файла `01-localhost` в /etc/phpmyadmin/conf.d и измените:

```php
$cfg["Servers"][$i]["host"] = "localhost";
$cfg["Servers"][$i]["port"] = "3306";
$cfg["Servers"][$i]["pmadb"] = "phpmyadmin";
$cfg["Servers"][$i]["controluser"] = "pma";
$cfg["Servers"][$i]["controlpass"] = "random password";
$cfg["Servers"][$i]["bookmarktable"] = "pma__bookmark";
```

Обязательно создайте также пользователя и базу данных phpmyadmin.

См. `/usr/local/hestia/install/deb/phpmyadmin/pma.sh`