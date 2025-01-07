# Сборка пакетов

::: info
Для сборки `hestia-nginx` или `hestia-php` требуется не менее 2 ГБ памяти!
:::

Вот более подробная информация о скриптах сборки, которые запускаются из `src`:

## Установка Hestia из ветки

Следующее полезно для тестирования запроса на извлечение или ветки в форке.

1. Установите Node.js [Загрузить](https://nodejs.org/en/download) или используйте [Node Source APT](https://github.com/nodesource/distributions)

```bash
# Замените на https://github.com/username/hestiacp.git, если хотите протестировать ветку, которую создали сами
git clone https://github.com/hestiacp/hestiacp.git
cd ./hestiacp/

# Замените main на ветку, которую хотите протестировать
git checkout main

# Установите зависимости
npm install
# Сборка
npm run build

cd ./src/

# Скомпилируйте пакеты
./hst_autocompile.sh --all --noinstall --keepbuild '~localsrc'

cd ../install

bash hst-install-{os}.sh --with-debs /tmp/hestiacp-src/deb/
```

К команде установщика можно добавить любую опцию. [См. полный список](../introduction/getting-started#list-of-installation-options).

## Только сборка пакетов

```bash
# Только Hestia
./hst_autocompile.sh --hestia --noinstall --keepbuild '~localsrc'
```

```bash
# Hestia + hestia-nginx и hestia-php
./hst_autocompile.sh --all --noinstall --keepbuild '~localsrc'
```

## Сборка и установка пакетов

::: info
Используйте, если у вас уже установлена ​​Hestia, чтобы изменения вступили в силу.
:::

```bash
# Только Hestia
./hst_autocompile.sh --hestia --install '~localsrc'
```

```bash
# Hestia + hestia-nginx и hestia-php
./hst_autocompile.sh --all --install '~localsrc'
```

## Обновление Hestia с GitHub

Следующее полезно для извлечения последних изменений staging/beta с GitHub и компиляции изменений.

::: info
Следующий метод поддерживает только сборку пакета `hestia`. Если вам нужно собрать `hestia-nginx` или `hestia-php`, используйте одну из предыдущих команд.
:::

1. Установите Node.js [Загрузить](https://nodejs.org/en/download) или используйте [Node Source APT](https://github.com/nodesource/distributions)

```bash
v-update-sys-hestia-git [ИМЯ ПОЛЬЗОВАТЕЛЯ] [ВЕТКА]
```

**Примечание:** Иногда зависимости добавляются или удаляются при установке пакетов с помощью `dpkg`. Предварительная загрузка зависимостей невозможна. Если это произойдет, вы увидите ошибку, подобную этой:

```bash
dpkg: ошибка при обработке пакета hestia (–install):
проблемы с зависимостями - оставляем ненастроенным
```

Чтобы решить эту проблему, выполните:

```bash
apt install -f
```