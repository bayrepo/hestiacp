# Приложение для быстрой установки

Одной из самых востребованных функций Hestia является добавление поддержки Softaculous. Однако из-за необходимости использования Ioncube в hestia-php и из-за того, что мы против использования проприетарного программного обеспечения, мы вместо этого разработали собственное решение **Приложение для быстрой установки**.

Дополнительную информацию можно найти в репозитории [hestia-quick-install](https://dev.brepo.ru/brepo/hestia-quick-install/src/branch/main/Example/ExampleSetup.php)

## Создание нового приложения

1. Создайте новую папку с именем `Example` в `/usr/local/hestia/web/src/app/WebApp/Installers/`
2. Создайте файл с именем `ExampleSetup.php`.

3. Скопируйте [содержимое файла примера](https://dev.brepo.ru/brepo/hestia-quick-install/src/branch/main/Example/ExampleSetup.php) в новый файл.

Это добавит приложение с именем «Example» при открытии страницы **Быстрая установка приложения**.

## Информация

Следующие настройки необходимы для отображения информации в списке **Быстрая установка приложения**:

- Имя: Отображаемое имя приложения. Обратите внимание, что наименование вашего приложения должно соответствовать следующему регулярному выражению: `[a-zA-Z][a-zA-Z0,9]`. В противном случае оно не будет зарегистрировано как рабочее приложение!
- Группа: В настоящее время не используется, но мы можем добавить функции, которые используют его в будущем. В настоящее время используются: `cms`, `ecommerce`, `framework`.
- Включено: Показывать или нет приложение на странице **Быстрая установка приложения**. По умолчанию установлено значение `true`.

- Версия: `x.x.x` или `latest`.
- Миниатюра: файл изображения для значка приложения, включите его в ту же папку. Максимальный размер 300 на 300 пикселей.

## Настройки

### Поля формы

Доступны следующие поля:

- Ввод текста
- Раскрывающийся список выбора
- Флажок
- Радиокнопка

Поскольку это довольно сложная функция, пожалуйста, проверьте наши существующие приложения на наличие примеров использования.

### База данных

Флаг для включения автоматического создания базы данных. Если включено, отображается флажок, позволяющий пользователю автоматически создать новую базу данных, а также 3 следующих поля:

- Имя базы данных
- Пользователь базы данных
- Пароль базы данных

### Загрузка исходного кода приложения

В настоящее время поддерживаются следующие методы загрузки:

- Загрузка архива с URL-адреса.
- Через [Composer](https://getcomposer.org).
- Через [WP-CLI](https://wp-cli.org).

### Настройки сервера

Позволяет вам устанавливать требования к приложению и шаблоны веб-сервера. Например, некоторые приложения требуют определенного шаблона Nginx или будут работать только на PHP 8.0 или выше.

- Nginx: Шаблон, используемый для настройки Nginx + PHP-FPM.
- Apache2: Шаблон, используемый для настройки Apache2. Обычно может быть опущен.
- Версия PHP: Массив всех поддерживаемых версий PHP.

## Установка веб-приложения

Существует несколько способов установки и настройки веб-приложения после его загрузки.

- Манипулирование файлами конфигурации.
- Выполнение команд. Например, используйте `drush` для установки [Drupal](https://dev.brepo.ru/bayrepo/hestiacp/src/branch/master/web/src/app/WebApp/Installers/Drupal/DrupalSetup.php#L56-L65).
- Использование curl для настройки приложения по HTTP.

::: warning
Чтобы избежать проблем, сделайте так, чтобы все команды выполнялись от имени пользователя, а не `root` или `admin`. Все команды, предоставляемые HestiaCP, делают это по умолчанию.
:::
