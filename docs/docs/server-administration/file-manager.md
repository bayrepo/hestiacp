# Файловый менеджер

## Как включить или отключить файловый менеджер

В новой установке файловый менеджер будет включен по умолчанию.

Чтобы включить или обновить файловый менеджер, выполните следующую команду:

```bash
v-add-sys-filemanager
```

Чтобы отключить файловый менеджер, выполните следующую команду:

```bash
v-delete-sys-filemanager
```

## Файловый менеджер выдает сообщение «Неизвестная ошибка»

Похоже, это происходит, когда строка `Subsystem sftp /usr/lib/openssh/sftp-server` удалена или изменена в `/etc/ssh/sshd_config` таким образом, что скрипт установки не может обновить ее до `Subsystem sftp internal-sftp`.

Короткий ответ: добавьте `Subsystem sftp internal-sftp` в `/etc/ssh/sshd_config`.

Длинный ответ: обратитесь к установочному скрипту `./install/hst-install-{distro}.sh` для всех изменений, внесенных в `/etc/ssh/sshd_config`. Для Debian изменения можно обобщить следующим образом:

```bash
# HestiaCP Изменения в /etc/ssh/sshd_config по умолчанию в Debian 10 Buster

# Принудительное значение по умолчанию yes
PasswordAuthentication yes

# Изменено с 2m по умолчанию на 1m
LoginGraceTime 1m

# Изменено с /usr/lib/openssh/sftp-server по умолчанию на internal-sftp
Subsystem sftp internal-sftp

# Изменено с yes по умолчанию
DebianBanner no
```

Изменение всех остальных параметров на значения по умолчанию, а также изменение на `PasswordAuthentication no` не воспроизвело ошибку, поэтому она, по-видимому, связана с параметром `Subsystem sftp internal-sftp`.

Для получения дополнительной информации об отладке проверьте журнал Hestia Nginx:

```bash
tail -f -s0.1 /var/log/hestia/nginx-error.log
```

## Я изменил порт SSH и больше не могу использовать файловый менеджер

Порт SSH загружен в сеансе PHP. Выход из системы и повторный вход в систему сбросят сеанс, исправив проблему.