# DNS-кластеры и DNSSEC

::: info
С выпуском версии 1.7.0 мы реализовали поддержку DNSSEC. DNSSEC требует настройки Master -> Slave. ЕСЛИ существующая реализация — это настройка Master <-> Master, она не поддерживается. DNSSEC также требует как минимум Ubuntu 22.04 или Debian 11!
:::

## Разместите свой DNS на Hestia

[Создайте зону DNS](../user-guide/dns.md#adding-a-dns-zone) с шаблоном **child-ns**, затем войдите в панель регистратора домена и измените серверы имен домена. В зависимости от панели регистратора вы можете создать связующие записи. Возможно, вам придется подождать до 24 часов, прежде чем серверы имен станут активными.

## Настройка DNS-кластера

::: tip
Создайте для каждого сервера уникального пользователя и назначьте ему роль «Sync DNS User» или «dns-cluster»!
:::

Если вы ищете варианты минимизации простоев, связанных с DNS, или способа управления DNS на всех ваших серверах, вы можете рассмотреть возможность настройки DNS-кластера.

1. Добавьте IP-адрес вашего главного сервера в белый список в **Настройка сервера** -> **Безопасность** -> **Разрешенные IP-адреса для API**, в противном случае вы получите ошибку при добавлении подчиненного сервера в кластер.

2. Включите доступ к API для администраторов (или всех пользователей).

3. Создайте ключ API под пользователем **admin** с разрешением не ниже **sync-dns-cluster**.

::: info
С выпуском 1.6.0 мы внедрили новую систему аутентификации API. Мы настоятельно рекомендуем использовать этот метод вместо старой системы, так как он более безопасен из-за длины ключа доступа и секретного ключа!

Если вы все еще хотите использовать устаревший API для аутентификации с именем пользователя **admin** и паролем, убедитесь, что **Enable legacy API** access установлен на **yes**.
:::

### DNS-кластер с API Hestia (Master <-> Master) "Default setup!"

::: warning
Этот метод не поддерживает DNSSEC!
:::

1. Создайте нового пользователя на сервере Hestia, который будет действовать как "Slave". Убедитесь, что он использует имя пользователя "dns-cluster" или имеет роль `dns-cluster`
2. Выполните следующую команду, чтобы включить DNS-сервер.

```bash
v-add-remote-dns-host slave.yourhost.com 8083 'accesskey:secretkey' '' 'api' 'username'
```

Или если вы все еще хотите использовать аутентификацию администратора и пароля

```bash
v-add-remote-dns-host slave.yourhost.com 8083 'admin' 'strongpassword' 'api' 'username'
```

Таким образом вы можете настроить кластер Master -> Slave или Master <-> Master <-> Master.

Нет ограничений на то, как сцеплять DNS-серверы.

### DNS-кластер с API Hestia (Master -> Slave)

1. Создайте нового пользователя на сервере Hestia, который будет действовать как «Slave». Убедитесь, что используется имя пользователя "dns-user" или роль `dns-cluster`
2. В `/usr/local/hestia/conf/hestia.conf` измените `DNS_CLUSTER_SYSTEM='hestia'` на `DNS_CLUSTER_SYSTEM='hestia-zone'`.
3. На главном сервере откройте `/etc/bind/named.conf.options`, внесите следующие изменения, затем перезапустите bind9 с помощью `systemctl restart bind9`.

```bash
# Измените эту строку
allow-transfer { "none"; };
# На эту
allow-transfer { your.slave.ip.address; };
# Или на эту, если добавляете несколько подчиненных
allow-transfer { first.slave.ip.address; second.slave.ip.address; };
# Добавьте эту строку, если добавляете несколько подчиненных
also-notify { second.slave.ip.address; };
```

4. На подчиненном сервере откройте `/etc/bind/named.conf.options`, внесите следующие изменения, затем перезапустите bind9 с помощью `systemctl restart bind9`:

```bash
# Измените эту строку
allow-recursion { 127.0.0.1; ::1; };

# На эту
allow-recursion { 127.0.0.1; ::1; your.master.ip.address; };
# Добавьте эту строку
allow-notify{ your.master.ip.address; };
```

5. Выполните следующую команду, чтобы включить DNS-сервер:

```bash
v-add-remote-dns-host slave.yourhost.com 8083 'accesskey:secretkey' '' 'api' 'user-name'
```

Если вы все еще хотите использовать аутентификацию администратора и пароля:

```bash
v-add-remote-dns-host slave.yourhost.com 8083 'admin' 'strongpassword' 'api' 'user-name'
```

### Преобразование существующего DNS-кластера в Master -> Slave

1. В `/usr/local/hestia/conf/hestia.conf` измените `DNS_CLUSTER_SYSTEM='hestia'` на `DNS_CLUSTER_SYSTEM='hestia-zone'`.

2. На главном сервере откройте `/etc/bind/named.options`, внесите следующие изменения, затем перезапустите bind9 с помощью `systemctl restart bind9`.

```bash
# Измените эту строку
allow-transfer { "none"; };

# На это
allow-transfer { your.slave.ip.address; };

# Или это, если добавляете несколько подчиненных
allow-transfer { first.slave.ip.address; second.slave.ip.address; };

# Добавьте эту строку, если добавляете несколько подчиненных
also-notify { second.slave.ip.address; };
```

3. На подчиненном сервере откройте `/etc/bind/named.options`, внесите следующие изменения, затем перезапустите bind9 с помощью `systemctl restart bind9`:

```bash
# Измените эту строку
allow-recursion { 127.0.0.1; ::1; };
# К этому
allow-recursion { 127.0.0.1; ::1; your.master.ip.address; };
# Добавьте эту строку
allow-notify{ your.master.ip.address; };
```

4. Обновите DNS с помощью `v-sync-dns-cluster`

## Включение DNSSEC

::: warning
DNSSEC нельзя использовать, когда Hestia Cluster активен как Master <-> Master
:::

Чтобы включить DNSSEC, установите флажок перед DNSSEC и сохраните.

Чтобы просмотреть открытый ключ. Перейдите к списку доменов DNS и щелкните значок <i class="fas fas-key"></i>.

В зависимости от вашего регистратора вы сможете создать новую запись на основе DNSKEY или на основе ключа DS. После добавления открытого ключа DNSSEC к регистратору DNSSEC будет включен и запущен.

::: danger
Удаление или отключение закрытого ключа в Hestia сделает домен недоступным.
:::

## Могу ли я разделить учетные записи DNS по пользователям

Да, вы можете просто указать переменную пользователя в конце команды.

````bash
v-add-remote-dns-host slave.yourhost.com 8083 'access_key:secret_key' '' '' 'username'```
````

или

```bash
v-add-remote-dns-host slave.yourhost.com 8083 admin p4sw0rd '' 'username'
```

С новой системой API вы также можете заменить `api_key` на `access_key:secret_key`

::: info
По умолчанию пользователь `dns-cluster` или пользователь с ролью `dns-cluster` освобождены от синхронизации с другими DNS-серверами!
:::

## Я не могу добавить сервер как DNS-хост

При попытке добавить DNS-сервер для кластера я получаю следующую ошибку:

```bash
/usr/local/hestia/func/remote.sh: строка 43: return: Ошибка:: требуется числовой аргумент
Ошибка: подключение API к slave.domain.tld не удалось
```

По умолчанию доступ API для нелокальных IP-адресов отключен. Добавьте свой IP-адрес в поле **Разрешенные IP-адреса для API** в настройках сервера.