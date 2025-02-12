# Почтовые домены

Чтобы управлять почтовыми доменами, перейдите на вкладку **Почта <i class="fas fa-fw fa-mail-bulk"></i>**.

## Добавление почтового домена

1. Нажмите кнопку **<i class="fas fa-fw fa-plus-circle"></i> Добавить почтовый домен**.

2. Введите имя домена.
3. Выберите нужные параметры.
4. Нажмите кнопку **<i class="fas fa-fw fa-save"></i> Сохранить** в правом верхнем углу.

## Редактирование почтового домена

1. Наведите указатель мыши на домен, который хотите отредактировать.
2. Нажмите значок <i class="fas fa-fw fa-pencil-alt"><span class="visually-hidden">изменить</span></i> справа от почтового домена.
3. Отредактируйте поля.
4. Нажмите кнопку **<i class="fas fa-fw fa-save"></i> Сохранить** в правом верхнем углу.

## Приостановка веб-домена

1. Наведите указатель мыши на домен, который вы хотите приостановить.
2. Нажмите значок <i class="fas fa-fw fa-pause"><span class="visually-hidden">приостановить</span></i> справа от почтового домена.
3. Чтобы отменить приостановку, нажмите значок <i class="fas fa-fw fa-play"><span class="visually-hidden">отменить</span></i> справа от почтового домена.

## Удаление веб-домена

1. Наведите указатель мыши на домен, который вы хотите удалить.
2. Нажмите значок <i class="fas fa-fw fa-trash"><span class="visually-hidden">удалить</span></i> справа от почтового домена. Будут удалены как почтовый домен, так и **все** почтовые учетные записи.

## Конфигурация почтового домена

### Клиент веб-почты

В настоящее время мы поддерживаем Roundcube, Rainloop и SnappyMail (необязательная установка). Вы также можете отключить доступ к веб-почте.

### Перехват всех писем

Этот адрес электронной почты будет получать все письма для этого домена, отправленные пользователям, которых не существует.

### Ограничение скорости

::: info
Эта опция доступна только для пользователя-администратора.
:::

Установите ограничение на количество писем, которые учетная запись может отправлять в час.

### Фильтр спама

::: info
Эта опция доступна не всегда.
:::

Включить Spam Assassin для этого домена.

### Антивирус

::: info
Эта опция не всегда доступна
:::

Включить ClamAV для этого домена.

### DKIM

Включить DKIM для этого домена.

### SSL

1. Установите флажок **Включить SSL для этого домена**.

2. Установите флажок **Использовать Let’s Encrypt для получения сертификата SSL**, чтобы использовать Let’s Encrypt.
3. В зависимости от ваших требований вы можете включить **Включить автоматическое перенаправление HTTPS** или **Включить HTTP Strict Transport Security (HSTS)**.
4. Нажмите кнопку **<i class="fas fa-fw fa-save"></i> Сохранить** в правом верхнем углу.

Если вы хотите использовать собственный сертификат SSL, вы можете ввести сертификат SSL в текстовом поле.

Если у вас возникли проблемы с включением Let’s Encrypt, обратитесь к нашей документации [SSL-сертификаты](../server-administration/ssl-certificates.md).

### Ретрансляция SMTP

Эта опция позволяет пользователю использовать ретранслятор SMTP, отличный от определенного сервером, или обойти маршрут Exim по умолчанию. Это может улучшить доставку.

1. Установите флажок **Ретрансляция SMTP**, и появится форма.

2. Введите информацию от вашего поставщика ретрансляции SMTP.

### Получить записи DNS

Если вы не размещаете свой DNS в Hestia, но все равно хотите использовать его службу электронной почты, щелкните значок <i class="fas fa-atlas"><span class="visually-hidden">DNS</span></i>, чтобы просмотреть записи DNS, которые вам нужно добавить к вашему поставщику DNS.

### Веб-почта

По умолчанию веб-почта доступна по адресу `https://webmail.domain.tld` или `https://mail.domain.tld`, если включен SSL. В противном случае используйте `http://`.

## Добавление почтовой учетной записи в домен

1. Щелкните почтовый домен.
2. Щелкните кнопку **<i class="fas fa-fw fa-plus-circle"></i> Добавить учетную запись почты**.
3. Введите имя учетной записи (без части `@domain.tld`) и пароль.
4. При желании укажите адрес электронной почты, на который будут отправлены данные для входа.
5. Щелкните кнопку **<i class="fas fa-fw fa-save"></i> Сохранить** в правом верхнем углу.

При необходимости вы также можете изменить **Дополнительные параметры**, которые описаны ниже.

С правой стороны вы можете увидеть методы доступа к вашей почтовой учетной записи через SMTP, IMAP и POP3.

## Редактирование почтовой учетной записи

1. Наведите указатель мыши на учетную запись, которую вы хотите отредактировать.
2. Нажмите значок <i class="fas fa-fw fa-pencil-alt"><span class="visually-hidden">редактировать</span></i> справа от почтовой учетной записи.
3. Отредактируйте поля.
4. Нажмите кнопку **<i class="fas fa-fw fa-save"></i> Сохранить** в правом верхнем углу.

## Приостановка почтовой учетной записи

1. Наведите указатель мыши на учетную запись, которую вы хотите приостановить.
2. Нажмите значок <i class="fas fa-fw fa-pause"><span class="visually-hidden">приостановить</span></i> справа от почтовой учетной записи.
3. Чтобы разблокировать его, нажмите значок <i class="fas fa-fw fa-play"><span class="visually-hidden">разблокировать</span></i> справа от почтовой учетной записи.

## Удаление почтовой учетной записи

1. Наведите указатель мыши на учетную запись, которую вы хотите удалить.
2. Нажмите значок <i class="fas fa-fw fa-trash"><span class="visually-hidden">удалить</span></i> справа от почтовой учетной записи.

## Конфигурация почтовой учетной записи

### Квота

Максимальное пространство, которое разрешено использовать учетной записи. Сюда входит почта, контакты и т. д.

### Псевдонимы

Добавьте псевдоним для перенаправления почты на основную учетную запись. Введите только имя пользователя. Например: `alice`.

### Отменить всю почту

Вся входящая почта не будет пересылаться и будет удалено.

### Не хранить пересланную почту

Если выбран этот параметр, вся пересланная почта будет удалена.

### Автоматический ответ

Настройте автоматический ответ.

### Пересылка почты

Пересылать всю входящую почту на указанный адрес электронной почты.

::: warning
Многие спам-фильтры могут помечать пересланную почту как спам по умолчанию!
:::

### Ограничение скорости

Установите ограничение на количество писем, которые аккаунт может отправить в час.