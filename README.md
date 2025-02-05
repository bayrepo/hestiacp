<h1 align="center">Hestia Control Panel (RPM Edition)</h1>

<h2 align="center">Легкая и мощная панель управления для современного сервера. Организуй собственный сервер в два счета.</h2>

<p align="center"><strong>Ссылки на оригинальный проект для Ubuntu и Debian:</strong> | <a href="https://www.hestiacp.com/">HestiaCP.com</a> |
</p>

<p align="center">
	<strong>Информация по RPM Edition сборке:</strong> |
	<a href="https://hestiadocs.brepo.ru/">Documentation for version with RPM support</a>
</p>

Hestia Control Panel (RPM Edition) поддерживается и дорабатывается отдельной командой связанной с RPM Based операционными системаи, с момента форка от оригинального, данный проект включил изменения, которые не позволяют просто подтягивать доработки из оригинального проекта (и не все доработки Ubuntu и Debian нужны в RPM Based системах). Поэтому все изменения из оригинальной Hestia CP не подтягиваются автоматически, поэтому о найденных ошибках в текущей реализации необходимо репортить в текущий проект.

Ниже общее описание панели.

## **Добро пожаловать!**

Панель управления Hestia предназначена для предоставления администраторам простого в использовании веб-интерфейса и интерфейса командной строки, что позволяет им быстро развертывать веб-домены, почтовые аккаунты, зоны DNS и базы данных и управлять ими с единой центральной панели без необходимости вручную развертывать и настраивать отдельные компоненты или сервисы.

## Функции и сервисы

- Apache2 и NGINX с PHP-FPM
- Несколько версий PHP (7.4 — 8.2, 8.0 по умолчанию, как из Remi репозитория, так и дополнительная самостоятельная сборка PHP пакетов)
- DNS-сервер (Bind)
- почтовые сервисы POP/IMAP/SMTP с защитой от вирусов, спама и веб-почтой (ClamAV, SpamAssassin, Sieve, Roundcube)
- базы данных MariaDB/MySQL и/или PostgreSQL
- поддержка SSL Let's Encrypt
- брандмауэр с защитой от атак методом перебора и списками IP (iptables, fail2ban и ipset).

## Поддерживаемые ОС

- **MSVSphere:** 9
- **AlmaLinux:** 9
- **RockyLinux:** 9

**ПРИМЕЧАНИЯ:**

- Панель управления Hestia не поддерживает 32-разрядные операционные системы!
- Панель управления Hestia в сочетании с OpenVZ 7 или более ранними версиями может иметь проблемы с DNS и/или брандмауэром. Если вы используете виртуальный частный сервер, мы настоятельно рекомендуем использовать что-то на основе KVM или LXC!

## Установка панели управления Hestia

- **ПРИМЕЧАНИЕ:** для обеспечения правильной работы необходимо установить панель управления Hestia поверх новой операционной системы.

Несмотря на то, что мы приложили все усилия, чтобы сделать процесс установки и интерфейс панели управления максимально удобными (даже для новых пользователей), предполагается, что вы уже обладаете некоторыми базовыми знаниями и пониманием того, как настроить сервер Linux, прежде чем продолжить.

### Шаг 1. Войдите в систему

Чтобы начать установку, вам нужно войти в систему как **root** или пользователь с правами суперпользователя. Вы можете выполнить установку непосредственно из командной строки или удалённо через SSH:

```bash
ssh root@your.server
```

### Шаг 2. Загрузка

Загрузите установочный скрипт для последней версии:

```bash
wget https://dev.brepo.ru/bayrepo/hestiacp/raw/branch/master/install/hst-install.sh
```

### Шаг 3: Запустите

Чтобы начать процесс установки, просто запустите скрипт и следуйте инструкциям на экране:

```bash
bash hst-install.sh
```

После завершения установки вы получите приветственное электронное письмо на адрес, указанный во время установки (если применимо), и инструкции на экране для входа в систему и доступа к вашему серверу.

### Пользовательская установка

Во время установки вы можете указать несколько различных флагов, чтобы установить только те функции, которые вам нужны. Чтобы просмотреть список доступных опций, выполните:

```bash
bash hst-install.sh -h
```

## Как обновить существующую установку

Автоматические обновления включены по умолчанию в новых установках Hestia Control Panel, и ими можно управлять из **Server Settings > Updates**. Чтобы вручную проверить наличие доступных обновлений и установить их, воспользуйтесь системным менеджером пакетов:

```bash
dnf update
```

## Проблемы и запросы в службу поддержки

- Если вы столкнулись с общей проблемой при использовании Hestia Control Panel для системы на основе RPM, воспользуйтесь [отчётом о проблеме](https://github.com/bayrepo/hestiacp-rpm/issues)

 Для оригинальной HestiaCP для Debian и Ubuntu используйте [оригинальную версию](https://github.com/hestiacp/hestiacp):

## Авторские права

Ознакомьтесь с оригинальными авторскими правами [HestiaCP](https://github.com/hestiacp/hestiacp)

## Лицензия

Панель управления Hestia распространяется по лицензии [GPL v3](https://github.com/hestiacp/hestiacp/blob/release/LICENSE) и основана на проекте [VestaCP](https://vestacp.com/).<br>
