#!/usr/bin/env bash
# Проверяет ответы обоих DNS-серверов, системное разрешение имён и режим SELinux.
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"

# Сверяет DNS-код, флаг авторитетного ответа и весь набор A-записей.
# Параметры: клиент, DNS-сервер, имя, ожидаемый код и список IPv4 через пробел.
expect_dns() {
    local client=$1 server=$2 name=$3 expected_code=$4 expected_ips=${5:-}
    local reply code ips rc
    reply=$(vagrant ssh "$client" --no-tty -c "dig @$server $name. A +norecurse +tries=2 +time=2 +noall +comments +answer" 2>&1 | tr -d "\r") || {
        rc=$?
        printf 'Сбой выполнения DNS-запроса: %s → %s, %s (код %s)\n%s\n' \
            "$client" "$server" "$name" "$rc" "$reply" >&2
        return "$rc"
    }
    code=$(sed -n 's/^.*status: \([A-Z]*\),.*$/\1/p' <<< "$reply")
    ips=$(awk '$4 == "A" {print $5}' <<< "$reply" | sort -u | paste -sd ' ' -)

    if [[ "$code" != "$expected_code" || "$ips" != "$expected_ips" ]] ||
        { [[ "$code" != REFUSED ]] && ! grep -Eq '^;; flags:.*[[:space:]]aa[[:space:];]' <<< "$reply"; }; then
        printf 'Ошибка DNS: %s → %s, %s (ожидалось %s %s)\n%s\n' \
            "$client" "$server" "$name" "$expected_code" "$expected_ips" "$reply" >&2
        return 1
    fi
    printf '%s → %s  %-18s %-8s %s\n' "$client" "$server" "$name" "$code" "$ips"
}

for server in 192.168.50.10 192.168.50.11; do
    expect_dns client "$server" web1.dns.lab NOERROR 192.168.50.15
    expect_dns client "$server" web2.dns.lab NXDOMAIN
    expect_dns client "$server" www.newdns.lab NOERROR "192.168.50.15 192.168.50.16"
    expect_dns client2 "$server" web1.dns.lab NOERROR 192.168.50.15
    expect_dns client2 "$server" web2.dns.lab NOERROR 192.168.50.16
    expect_dns client2 "$server" www.newdns.lab REFUSED
done

vagrant ssh client --no-tty -c 'getent ahostsv4 web1.dns.lab. && getent ahostsv4 www.newdns.lab.'
vagrant ssh client --no-tty -c 'getent ahostsv4 web2.dns.lab. >/dev/null; test $? -eq 2'
vagrant ssh client2 --no-tty -c 'getent ahostsv4 web1.dns.lab. && getent ahostsv4 web2.dns.lab.'
vagrant ssh client2 --no-tty -c 'getent ahostsv4 www.newdns.lab. >/dev/null; test $? -eq 2'

for vm in ns01 ns02 client client2; do
    mode=$(vagrant ssh "$vm" --no-tty -c getenforce | tr -d "\r")
    [[ "$mode" == Enforcing ]] || { printf '%s: SELinux %s\n' "$vm" "$mode" >&2; exit 1; }
    printf '%s: SELinux %s\n' "$vm" "$mode"
done

# v3 · 2026-11-11 · Вывод диагностики при ошибке SSH или dig.
