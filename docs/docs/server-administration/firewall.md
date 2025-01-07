# Брандмауэр

::: warning
После каждого изменения или обновления брандмауэра Hestia очистит текущие iptables, если только правила не будут добавлены через Hestia и [пользовательский скрипт](#how-can-i-customize-iptables-rules).
:::

## Как открыть или заблокировать порт или IP?

1. Перейдите к настройкам сервера, нажав значок <i class="fas fa-fw fa-cog"><span class="visually-hidden">Сервер</span></i> в правом верхнем углу.
2. Нажмите кнопку **<i class="fas fa-fw fa-shield-alt"></i> Брандмауэр**.
3. Нажмите кнопку **<i class="fas fa-fw fa-plus-circle"></i> Добавить правило**.
4. Выберите нужное действие.
5. Выберите нужный протокол.
6. Введите порт(ы), к которым вы хотите применить это правило (`0` для всех портов).
7. Установите IP, к которому это правило будет применяться (`0.0.0.0/0` для всех IP) или выберите IPSet.
8. При желании опишите функцию правила.
9. Нажмите кнопку **<i class="fas fa-fw fa-save"></i> Save** в правом верхнем углу.

Вы также можете использовать команду [v-add-firewall-rule](../reference/cli.md#v-add-firewall-rule).

## Как настроить черный или белый список IPSet?

IPSet — это большие списки IP-адресов или подсетей. Их можно использовать для черных и белых списков.

1. Перейдите к настройкам сервера, нажав на значок <i class="fas fa-fw fa-cog"><span class="visually-hidden">Сервер</span></i> в правом верхнем углу.
2. Нажмите кнопку **<i class="fas fa-fw fa-shield-alt"></i> Брандмауэр**.
3. Нажмите кнопку **<i class="fas fa-fw fa-list"></i> Управление списками IP**.
4. Нажмите кнопку **<i class="fas fa-fw fa-plus-circle"></i> Добавить список IP**.
5. Дайте имя вашему списку IP.
6. Выберите источник данных, введя один из следующих вариантов:
- URL: `http://ipverse.net/ipblocks/data/countries/nl.zone`
- Скрипт (с `chmod 755`): `/usr/local/hestia/install/deb/firewall/ipset/blacklist.sh`
- Файл: `file:/location/of/file`
- Вы также можете использовать один из включенных источников Hestia.
7. Выберите нужную версию IP (v4 или v6).
8. Выберите, следует ли автоматически обновлять список.
9. Нажмите кнопку **<i class="fas fa-fw fa-save"></i> Сохранить** в правом верхнем углу.

## Как настроить правила iptables?

::: danger
Это опасно продвинутая функция, убедитесь, что вы понимаете, что делаете.
:::

Hestia поддерживает настройку пользовательских правил, цепочек или флагов и т. д. с помощью скрипта.

Скрипт должен быть здесь: `/usr/local/hestia/data/firewall/custom.sh`

1. Создайте custom.sh: `touch /usr/local/hestia/data/firewall/custom.sh`
2. Сделайте его исполняемым: `chmod +x /usr/local/hestia/data/firewall/custom.sh`
3. Отредактируйте его в своем любимом редакторе.
4. Проверьте и убедитесь, что он работает.
5. Чтобы сделать пользовательские правила постоянными, выполните: `v-update-firewall`

**НЕЯВНАЯ ЗАЩИТА:** Перед тем, как сделать правила постоянными, если вы накосячите или заблокируете себе доступ к серверу, просто перезагрузите его.

пример custom.sh:

```bash
#!/bin/bash

IPTABLES="$(command -v iptables)"

$IPTABLES -N YOURCHAIN
$IPTABLES -F YOURCHAIN
$IPTABLES -I YOURCHAIN ​​-s 0.0.0.0/0 -j RETURN
$IPTABLES -I INPUT -p TCP -m multiport --dports 1:65535 -j YOURCHAIN
```

## Мой IPSet не работает

IPSet должен содержать не менее 10 IP-адресов или диапазонов IP-адресов.

## Могу ли я объединить несколько источников в один?

Если вы хотите объединить несколько источников IP, вы можете сделать это с помощью следующего скрипта:

```bash
#!/bin/bash

BEL=(
"https://raw.githubusercontent.com/ipverse/rir-ip/master/country/be/ipv4-aggregated.txt"
"https://raw.githubusercontent.com/ipverse/rir-ip/master/country/nl/ipv4-aggregated.txt"
"https://raw.githubusercontent.com/ipverse/rir-ip/master/country/lu/ipv4-aggregated.txt"
)

IP_BEL_TMP=$(mktemp)
for i in "${BEL[@]}"; do
IP_TMP=$(mktemp)
((HTTP_RC = $(curl -L --connect-timeout 10 --max-time 10 -o "$IP_TMP" -s -w "%{http_code}" "$i")))
if ((HTTP_RC == 200 || HTTP_RC == 302 || HTTP_RC == 0)); then # "0", потому что file:/// возвращает 000
command grep -Po '^(?:\d{1,3}\.){3}\d{1,3}(?:/\d{1,2})?' "$IP_TMP" | sed -r 's/^0*([0-9]+)\.0*([0-9]+)\.0*([0-9]+)\.0*([0-9]+)$/\1.\2.\3.\4/' >> "$IP_BEL_TMP"
elif ((HTTP_RC == 503)); then
echo >&2 -e "\\nНедоступно (${HTTP_RC}): $i"
else
echo >&2 -e "\\nПредупреждение: curl вернул код ответа HTTP $HTTP_RC для URL $i"
fi
rm -f "$IP_TMP"
done

sed -r -e '/^(0\.0\.0\.0|10\.|127\.|172\.1[6-9]\.|172\.2[0-9]\.|172\.3[0-1]\.|192\.168\.|22[4-9]\.|23[0-9]\.)/d' "$IP_BEL_TMP" | sort -n | sort -mu
rm -f "$IP_BEL_TMP"
```