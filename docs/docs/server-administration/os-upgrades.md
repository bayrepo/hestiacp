# Обновления операционной системы

::: danger
Перед обновлением операционной системы обязательно сделайте резервную копию! Мы не оказываем поддержку для неисправных установок операционной системы. Мы предоставляем эту страницу только для информации о проблемах Hestia, которые могут возникнуть при обновлении.
:::

## General

::: info
Убедитесь, что MariaDB работает на поддерживаемой версии для новой операционной системы. Если это не так, обновите версию MariaDB до поддерживаемой версии перед обновлением ОС!
:::

После создания резервной копии обновите Hestia до последней поддерживаемой версии:

```bash
yum update
```

## MSVSphere, AlmaLinux, RockyLinux 9

### Шифрование паролей SHA512

```bash
sed -i "s/obscure yescrypt/obscure sha512/g" /etc/pam.d/common-password
```

### Конфигурация Exim4

```bash
rm -f /etc/exim4/exim4.conf.template
cp -f /usr/local/hestia/install/deb/exim/exim4.conf.4.94.template /etc/exim4/exim4.conf.template
```

### ProFTPD

Закомментируйте [строку 29](https://github.com/hestiacp/hestiacp/blob/1ff8a4e5207aae1e241954a83b7e8070bcdca788/install/deb/proftpd/proftpd.conf#L29) в `/etc/profpd/prodtpd.conf`.