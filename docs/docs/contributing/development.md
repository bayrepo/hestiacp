# Вклад в разработку Hestia

Hestia — проект с открытым исходным кодом, и мы приветствуем вклад сообщества. Пожалуйста, прочтите [руководство по вкладу](https://github.com/hestiacp/hestiacp/blob/main/CONTRIBUTING.md) для получения дополнительной информации.

Hestia предназначена для установки на веб-сервер. Для разработки Hestia на локальном компьютере рекомендуется виртуальная машина.

::: warning
Сборки для разработки нестабильны. Если вы столкнулись с ошибкой, [сообщите о ней через GitHub](https://github.com/hestiacp/hestiacp/issues/new/choose) или [отправьте запрос на извлечение](https://github.com/hestiacp/hestiacp/pulls).
:::

## Создание виртуальной машины для разработки

Это примеры инструкций по созданию виртуальной машины, на которой запущена Hestia для разработки.

В этих инструкциях для создания виртуальной машины используется [Multipass](https://multipass.run/). Вы можете адаптировать команды для любого программного обеспечения виртуализации, которое вам нравится.

::: warning
Иногда сопоставление между каталогом исходного кода на локальной машине и каталогом в виртуальной машине может быть потеряно с ошибкой «не удалось получить статус выхода для удаленного процесса». Если это произошло, просто размонтируйте и перемонтируйте, например,

```bash
multipass unmount hestia-dev
multipass mount $HOME/projects/hestiacp hestia-dev:/home/ubuntu/hestiacp
```

:::

1. [Установите Multipass](https://multipass.run/install) для вашей ОС.

1. [Fork Hestia](https://github.com/hestiacp/hestiacp/fork) и клонируйте репозиторий на локальную машину

```bash
git clone https://github.com/YourUsername/hestiacp.git $HOME/projects
```

1. Создайте виртуальную машину Ubuntu с объемом памяти не менее 2 ГБ и дисковым пространством 15 ГБ

```bash
multipass launch --name hestia-dev --memory 2G --disk 15G
```

1. Сопоставьте клонированный репозиторий с домашним каталогом виртуальной машины

```bash
multipass mount $HOME/projects/hestiacp hestia-dev:/home/ubuntu/hestiacp
```

1. Подключитесь к виртуальной машине по SSH как root и установите некоторые необходимые пакеты

```bash
multipass exec hestia-dev -- sudo bash
sudo apt update && sudo apt install -y jq libjq1
```

1. За пределами виртуальной машины (в новом терминале) убедитесь, что установлен [Node.js](https://nodejs.org/)
16 или более поздней версии

```bash
node --version
```

1. Установите зависимости и соберите файлы темы:

```bash
npm install
npm run build
```

1. Вернитесь в терминал виртуальной машины, перейдите в `/src` и соберите пакеты Hestia

```bash
cd src
./hst_autocompile.sh --hestia --noinstall --keepbuild '~localsrc'
```

1. Перейдите в `/install` и установите Hestia

_(обновите [install flags](../introduction/getting-started#list-of-installation-options) по своему вкусу, обратите внимание, что учетные данные для входа задаются здесь)_

```bash
cd ../install
bash hst-install-ubuntu.sh -D /tmp/hestiacp-src/deb/ --interactive no --email admin@example.com --password Password123 --hostname demo.hestiacp.com -f
```

1. Перезагрузите ВМ (и выйдите из сеанса SSH)

```bash
reboot
```

1. Найдите IP-адрес ВМ

```bash
multipass list
```

1. Перейдите по IP-адресу ВМ в своем браузере, используя порт Hestia по умолчанию, и войдите с помощью `admin`/`Password123`

_(пропустите любые ошибки SSL, которые вы видите при загрузке страницы)_

```bash
например https://192.168.64.15:8083
```

Hestia теперь работает на виртуальной машине. Если вы хотите внести изменения в исходный код и протестировать их в браузере, перейдите к следующему разделу.

## Внесение изменений в Hestia

После настройки Hestia на виртуальной машине вы теперь можете вносить изменения в исходный код в `$HOME/projects/hestiacp` на локальной машине (вне виртуальной машины) с помощью редактора по вашему выбору.

Ниже приведены примеры инструкций по внесению изменений в пользовательский интерфейс Hestia и его локальному тестированию.

1. В корне проекта на локальной машине убедитесь, что установлены последние пакеты

```bash
npm install
```

1. Внесите изменения в файл, который мы сможем протестировать позже, затем соберите ресурсы пользовательского интерфейса

_например измените цвет фона тела на красный в `web/css/src/base.css`, затем запустите:_

```bash
npm run build
```

1. Подключитесь к виртуальной машине по SSH как root и перейдите в `/src`

```bash
multipass exec hestia-dev -- sudo bash
cd src
```

1. Запустите скрипт сборки Hestia

```bash
./hst_autocompile.sh --hestia --install '~localsrc'
```

1. Перезагрузите страницу в браузере, чтобы увидеть изменения

::: info
Резервная копия создается каждый раз при запуске скрипта сборки Hestia. Если вы запускаете его часто, он может заполнить дисковое пространство вашей виртуальной машины.
Вы можете удалить резервные копии, запустив `rm -rf /root/hst_backups` как пользователь root на виртуальной машине.
:::

Дополнительную информацию об отправке изменений кода на проверку см. в [руководстве по внесению изменений](https://github.com/hestiacp/hestiacp/blob/main/CONTRIBUTING.md).

## Запуск автоматизированных тестов

В настоящее время мы используем [Bats](https://github.com/bats-core/bats-core) для запуска наших автоматизированных тестов.

### Установка

```bash
# Клонирование репозитория Hestia с тестовыми подмодулями
git clone --recurse-submodules https://github.com/hestiacp/hestiacp
# Или использование существующего локального репозитория с актуальной основной веткой
git submodule update --init --recursive

# Установка Bats
test/test_helper/bats-core/install.sh /usr/local
```

### Запуск

::: danger
Не запускайте никаких тестовых скриптов на рабочем сервере. Это может вызвать проблемы или простои!
:::

```bash
# Запуск тестов Hestia
test/test.bats
```