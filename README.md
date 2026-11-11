Создать домашнюю сетевую лабораторию;
Изучить основы DNS;
Научиться работать с технологией Split-DNS в Linux-based системах.

## Стенд

| ВМ | IP-адрес | Назначение |
| --- | --- | --- |
| `ns01` | `192.168.50.10` | Первичный BIND |
| `ns02` | `192.168.50.11` | Вторичный BIND |
| `client` | `192.168.50.15` | Первый клиент |
| `client2` | `192.168.50.16` | Второй клиент |


## Запуск


1. Из каталога репозитория запустите ВМ.

 ```bash
   root@nfsc:~/split-dns-lab# vagrant up --provider=virtualbox
Bringing machine 'ns01' up with 'virtualbox' provider...
Bringing machine 'ns02' up with 'virtualbox' provider...
Bringing machine 'client' up with 'virtualbox' provider...
Bringing machine 'client2' up with 'virtualbox' provider...
==> ns01: Box 'almalinux/9' could not be found. Attempting to find and install...
    ns01: Box Provider: virtualbox
    ns01: Box Version: >= 0
==> ns01: Loading metadata for box 'https://vagrant.almalinux.org/almalinux/9'
    ns01: URL: https://vagrant.almalinux.org/almalinux/9
==> ns01: Adding box 'almalinux/9' (v9.8.20261102) for provider: virtualbox (amd64)
    ns01: Downloading: https://almalinux-cloud.s3.amazonaws.com/images/9/9.8/vagrant/20261102122713/AlmaLinux-9-Vagrant-virtualbox-9.8-20261102.x86_64.box
==> ns01: Box download is resuming from prior download progress
    ns01: Calculating and comparing box checksum...
==> ns01: Successfully added box 'almalinux/9' (v9.8.20261102) for 'virtualbox (amd64)'!
==> ns01: Importing base box 'almalinux/9'...
==> ns01: Matching MAC address for NAT networking...
==> ns01: Checking if box 'almalinux/9' version '9.8.20261102' is up to date...
==> ns01: Setting the name of the VM: split-dns-lab_ns01_1794338278211_36234
==> ns01: Clearing any previously set network interfaces...
==> ns01: Preparing network interfaces based on configuration...
    ns01: Adapter 1: nat
    ns01: Adapter 2: intnet
==> ns01: Forwarding ports...
    ns01: 22 (guest) => 2222 (host) (adapter 1)
==> ns01: Running 'pre-boot' VM customizations...
==> ns01: Booting VM...
==> ns01: Waiting for machine to boot. This may take a few minutes...
    ns01: SSH address: 127.0.0.1:2222
    ns01: SSH username: vagrant
    ns01: SSH auth method: private key
    ns01: Warning: Connection reset. Retrying...
    ns01: Warning: Connection reset. Retrying...
    ns01: Warning: Connection reset. Retrying...
    ns01: Warning: Connection reset. Retrying...
    ns01: Warning: Connection reset. Retrying...
    ns01: Warning: Remote connection disconnect. Retrying...
    ns01: Warning: Connection reset. Retrying...
    ns01: Warning: Connection reset. Retrying...
    ns01:
    ns01: Vagrant insecure key detected. Vagrant will automatically replace
    ns01: this with a newly generated keypair for better security.
    ns01:
    ns01: Inserting generated public key within guest...
    ns01: Removing insecure key from the guest if it's present...
    ns01: Key inserted! Disconnecting and reconnecting using new SSH key...
==> ns01: Machine booted and ready!
==> ns01: Checking for guest additions in VM...
    ns01: The guest additions on this VM do not match the installed version of
    ns01: VirtualBox! In most cases this is fine, but in rare cases it can
    ns01: prevent things such as shared folders from working properly. If you see
    ns01: shared folder errors, please make sure the guest additions within the
    ns01: virtual machine match the version of VirtualBox you have installed on
    ns01: your host and reload your VM.
    ns01:
    ns01: Guest Additions Version: 7.2.22
    ns01: VirtualBox Version: 7.0
==> ns01: Setting hostname...
==> ns01: Configuring and enabling network interfaces...
==> ns01: Running provisioner: ansible...
    ns01: Running ansible-playbook...

PLAY [Проверить режим SELinux на всех ВМ] **************************************

TASK [Убедиться, что SELinux работает в режиме Enforcing] **********************
ok: [ns01]

PLAY [Настроить первичный и вторичный серверы BIND] ****************************

TASK [Установить BIND и диагностические утилиты] *******************************
changed: [ns01]

TASK [Установить файлы первичных зон] ******************************************
changed: [ns01] => (item=client1/dns.lab)
changed: [ns01] => (item=client1/newdns.lab)
changed: [ns01] => (item=client2/dns.lab)

TASK [Установить конфигурацию BIND с ключами переноса зон] *********************
changed: [ns01]

TASK [Восстановить штатные метки SELinux для BIND] *****************************
ok: [ns01]

TASK [Узнать состояние firewalld] **********************************************
ok: [ns01]

TASK [Проверить постоянное и текущее правила DNS] ******************************
skipping: [ns01] => (item=['--permanent'])
skipping: [ns01] => (item=[])
skipping: [ns01]

TASK [Добавить отсутствующие правила для TCP и UDP 53] *************************
skipping: [ns01] => (item=постоянное)
skipping: [ns01] => (item=текущее)
skipping: [ns01]

TASK [Применить изменения конфигурации BIND] ***********************************

RUNNING HANDLER [Перезапустить named] ******************************************
changed: [ns01]

TASK [Включить службу named] ***************************************************
changed: [ns01]

PLAY [Настроить DNS на клиентах] ***********************************************
skipping: no hosts matched

PLAY RECAP *********************************************************************
ns01                       : ok=8    changed=5    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0

==> ns02: Box 'almalinux/9' could not be found. Attempting to find and install...
    ns02: Box Provider: virtualbox
    ns02: Box Version: >= 0
==> ns02: Loading metadata for box 'https://vagrant.almalinux.org/almalinux/9'
    ns02: URL: https://vagrant.almalinux.org/almalinux/9
==> ns02: Adding box 'almalinux/9' (v9.8.20261102) for provider: virtualbox (amd64)
==> ns02: Importing base box 'almalinux/9'...
==> ns02: Matching MAC address for NAT networking...
==> ns02: Checking if box 'almalinux/9' version '9.8.20261102' is up to date...
==> ns02: Setting the name of the VM: split-dns-lab_ns02_1794338917607_13941
==> ns02: Fixed port collision for 22 => 2222. Now on port 2200.
==> ns02: Clearing any previously set network interfaces...
==> ns02: Preparing network interfaces based on configuration...
    ns02: Adapter 1: nat
    ns02: Adapter 2: intnet
==> ns02: Forwarding ports...
    ns02: 22 (guest) => 2200 (host) (adapter 1)
==> ns02: Running 'pre-boot' VM customizations...
==> ns02: Booting VM...
==> ns02: Waiting for machine to boot. This may take a few minutes...
    ns02: SSH address: 127.0.0.1:2200
    ns02: SSH username: vagrant
    ns02: SSH auth method: private key
    ns02: Warning: Remote connection disconnect. Retrying...
    ns02: Warning: Connection reset. Retrying...
    ns02: Warning: Connection reset. Retrying...
    ns02: Warning: Connection reset. Retrying...
    ns02: Warning: Connection reset. Retrying...
    ns02: Warning: Connection reset. Retrying...
    ns02: Warning: Connection reset. Retrying...
    ns02: Warning: Remote connection disconnect. Retrying...
    ns02: Warning: Connection reset. Retrying...
    ns02:
    ns02: Vagrant insecure key detected. Vagrant will automatically replace
    ns02: this with a newly generated keypair for better security.
    ns02:
    ns02: Inserting generated public key within guest...
    ns02: Removing insecure key from the guest if it's present...
    ns02: Key inserted! Disconnecting and reconnecting using new SSH key...
==> ns02: Machine booted and ready!
==> ns02: Checking for guest additions in VM...
    ns02: The guest additions on this VM do not match the installed version of
    ns02: VirtualBox! In most cases this is fine, but in rare cases it can
    ns02: prevent things such as shared folders from working properly. If you see
    ns02: shared folder errors, please make sure the guest additions within the
    ns02: virtual machine match the version of VirtualBox you have installed on
    ns02: your host and reload your VM.
    ns02:
    ns02: Guest Additions Version: 7.2.22
    ns02: VirtualBox Version: 7.0
==> ns02: Setting hostname...
==> ns02: Configuring and enabling network interfaces...
==> ns02: Running provisioner: ansible...
    ns02: Running ansible-playbook...

PLAY [Проверить режим SELinux на всех ВМ] **************************************

TASK [Убедиться, что SELinux работает в режиме Enforcing] **********************
ok: [ns02]

PLAY [Настроить первичный и вторичный серверы BIND] ****************************

TASK [Установить BIND и диагностические утилиты] *******************************
changed: [ns02]

TASK [Установить файлы первичных зон] ******************************************
skipping: [ns02] => (item=client1/dns.lab)
skipping: [ns02] => (item=client1/newdns.lab)
skipping: [ns02] => (item=client2/dns.lab)
skipping: [ns02]

TASK [Установить конфигурацию BIND с ключами переноса зон] *********************
changed: [ns02]

TASK [Восстановить штатные метки SELinux для BIND] *****************************
ok: [ns02]

TASK [Узнать состояние firewalld] **********************************************
ok: [ns02]

TASK [Проверить постоянное и текущее правила DNS] ******************************
skipping: [ns02] => (item=['--permanent'])
skipping: [ns02] => (item=[])
skipping: [ns02]

TASK [Добавить отсутствующие правила для TCP и UDP 53] *************************
skipping: [ns02] => (item=постоянное)
skipping: [ns02] => (item=текущее)
skipping: [ns02]

TASK [Применить изменения конфигурации BIND] ***********************************

RUNNING HANDLER [Перезапустить named] ******************************************
changed: [ns02]

TASK [Включить службу named] ***************************************************
changed: [ns02]

PLAY [Настроить DNS на клиентах] ***********************************************
skipping: no hosts matched

PLAY RECAP *********************************************************************
ns02                       : ok=7    changed=4    unreachable=0    failed=0    skipped=3    rescued=0    ignored=0

==> client: Box 'almalinux/9' could not be found. Attempting to find and install...
    client: Box Provider: virtualbox
    client: Box Version: >= 0
==> client: Loading metadata for box 'https://vagrant.almalinux.org/almalinux/9'
    client: URL: https://vagrant.almalinux.org/almalinux/9
==> client: Adding box 'almalinux/9' (v9.8.20261102) for provider: virtualbox (amd64)
==> client: Importing base box 'almalinux/9'...
==> client: Matching MAC address for NAT networking...
==> client: Checking if box 'almalinux/9' version '9.8.20261102' is up to date...
==> client: Setting the name of the VM: split-dns-lab_client_1794339561130_3821
==> client: Fixed port collision for 22 => 2222. Now on port 2201.
==> client: Clearing any previously set network interfaces...
==> client: Preparing network interfaces based on configuration...
    client: Adapter 1: nat
    client: Adapter 2: intnet
==> client: Forwarding ports...
    client: 22 (guest) => 2201 (host) (adapter 1)
==> client: Running 'pre-boot' VM customizations...
==> client: Booting VM...
==> client: Waiting for machine to boot. This may take a few minutes...
    client: SSH address: 127.0.0.1:2201
    client: SSH username: vagrant
    client: SSH auth method: private key
    client: Warning: Connection reset. Retrying...
    client: Warning: Connection reset. Retrying...
    client: Warning: Connection reset. Retrying...
    client: Warning: Connection reset. Retrying...
    client: Warning: Connection reset. Retrying...
    client: Warning: Connection reset. Retrying...
    client: Warning: Connection reset. Retrying...
    client:
    client: Vagrant insecure key detected. Vagrant will automatically replace
    client: this with a newly generated keypair for better security.
    client:
    client: Inserting generated public key within guest...
    client: Removing insecure key from the guest if it's present...
    client: Key inserted! Disconnecting and reconnecting using new SSH key...
==> client: Machine booted and ready!
==> client: Checking for guest additions in VM...
    client: The guest additions on this VM do not match the installed version of
    client: VirtualBox! In most cases this is fine, but in rare cases it can
    client: prevent things such as shared folders from working properly. If you see
    client: shared folder errors, please make sure the guest additions within the
    client: virtual machine match the version of VirtualBox you have installed on
    client: your host and reload your VM.
    client:
    client: Guest Additions Version: 7.2.22
    client: VirtualBox Version: 7.0
==> client: Setting hostname...
==> client: Configuring and enabling network interfaces...
==> client: Running provisioner: ansible...
    client: Running ansible-playbook...

PLAY [Проверить режим SELinux на всех ВМ] **************************************

TASK [Убедиться, что SELinux работает в режиме Enforcing] **********************
ok: [client]

PLAY [Настроить первичный и вторичный серверы BIND] ****************************
skipping: no hosts matched

PLAY [Настроить DNS на клиентах] ***********************************************

TASK [Установить утилиты DNS и локальный DNS-прокси] ***************************
changed: [client]

TASK [Создать каталог дополнительных настроек dnsmasq] *************************
ok: [client]

TASK [Направить запросы к .lab на серверы стенда] ******************************
changed: [client]

TASK [Включить DNS-прокси в NetworkManager] ************************************
changed: [client]

RUNNING HANDLER [Перечитать настройки DNS NetworkManager] **********************
fatal: [client]: FAILED! => {"changed": true, "cmd": ["nmcli", "general", "reload", "conf", "dns-full"], "delta": "0:00:00.022081", "end": "2026-11-10 19:49:30.780756", "msg": "non-zero return code", "rc": 2, "start": "2026-11-10 19:49:30.758675", "stderr": "Error: extra argument 'dns-full'", "stderr_lines": ["Error: extra argument 'dns-full'"], "stdout": "", "stdout_lines": []}

PLAY RECAP *********************************************************************
client                     : ok=5    changed=3    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0

Ansible failed to complete successfully. Any error output should be
visible above. Please fix these errors and try again.
root@nfsc:~/split-dns-lab# cd ~/split-dns-lab &&
  sed -i '/^      ansible\.builtin\.command: nmcli general reload conf dns-full$/c\      ansible.builtin.shell: nmcli general reload conf \&\& nmcli general reload dns-full' provisioning/playbook.yml &&
  vagrant ssh client --no-tty -c 'sudo nmcli general reload conf && sudo nmcli general reload dns-full' &&
  vagrant provision client &&
  vagrant up client2 --provider=virtualbox --provision &&
  bash ./verify.sh
==> client: Running provisioner: ansible...
    client: Running ansible-playbook...

PLAY [Проверить режим SELinux на всех ВМ] **************************************

TASK [Убедиться, что SELinux работает в режиме Enforcing] **********************
ok: [client]

PLAY [Настроить первичный и вторичный серверы BIND] ****************************
skipping: no hosts matched

PLAY [Настроить DNS на клиентах] ***********************************************

TASK [Установить утилиты DNS и локальный DNS-прокси] ***************************
ok: [client]

TASK [Создать каталог дополнительных настроек dnsmasq] *************************
ok: [client]

TASK [Направить запросы к .lab на серверы стенда] ******************************
ok: [client]

TASK [Включить DNS-прокси в NetworkManager] ************************************
ok: [client]

PLAY RECAP *********************************************************************
client                     : ok=5    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

Bringing machine 'client2' up with 'virtualbox' provider...
==> client2: Importing base box 'almalinux/9'...
==> client2: Matching MAC address for NAT networking...
==> client2: Checking if box 'almalinux/9' version '9.8.20261102' is up to date...
==> client2: Setting the name of the VM: split-dns-lab_client2_1794384117214_6258
==> client2: Fixed port collision for 22 => 2222. Now on port 2202.
==> client2: Clearing any previously set network interfaces...
==> client2: Preparing network interfaces based on configuration...
    client2: Adapter 1: nat
    client2: Adapter 2: intnet
==> client2: Forwarding ports...
    client2: 22 (guest) => 2202 (host) (adapter 1)
==> client2: Running 'pre-boot' VM customizations...
==> client2: Booting VM...
==> client2: Waiting for machine to boot. This may take a few minutes...
    client2: SSH address: 127.0.0.1:2202
    client2: SSH username: vagrant
    client2: SSH auth method: private key
    client2: Warning: Connection reset. Retrying...
    client2: Warning: Remote connection disconnect. Retrying...
    client2: Warning: Connection reset. Retrying...
    client2: Warning: Remote connection disconnect. Retrying...
    client2: Warning: Connection reset. Retrying...
    client2: Warning: Connection reset. Retrying...
    client2: Warning: Connection reset. Retrying...
    client2: Warning: Remote connection disconnect. Retrying...
    client2: Warning: Connection reset. Retrying...
    client2: Warning: Connection reset. Retrying...
    client2: Warning: Remote connection disconnect. Retrying...
Vagrantfile validated successfully.
 08:31:00 up 27 min,  1 user,  load average: 0.10, 0.05, 0.14
==> client2: Running provisioner: ansible...
    client2: Running ansible-playbook...

PLAY [Проверить режим SELinux на всех ВМ] **************************************

TASK [Убедиться, что SELinux работает в режиме Enforcing] **********************
ok: [client2]

PLAY [Настроить первичный и вторичный серверы BIND] ****************************
skipping: no hosts matched

PLAY [Настроить DNS на клиентах] ***********************************************

TASK [Установить утилиты DNS и локальный DNS-прокси] ***************************
changed: [client2]

TASK [Создать каталог дополнительных настроек dnsmasq] *************************
ok: [client2]

TASK [Направить запросы к .lab на серверы стенда] ******************************
changed: [client2]

TASK [Включить DNS-прокси в NetworkManager] ************************************
changed: [client2]

RUNNING HANDLER [Перечитать настройки DNS NetworkManager] **********************
changed: [client2]

PLAY RECAP *********************************************************************
client2                    : ok=6    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

Ошибка DNS: client → 192.168.50.10, web1.dns.lab (ожидалось NOERROR 192.168.50.15)
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 11288
;; flags: qr aa; QUERY: 1, ANSWER: 1, AUTHORITY: 2, ADDITIONAL: 3

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: e4a9297c145dd0c5010000006af428c893cd20211d14cd64 (good)
;; ANSWER SECTION:
web1.dns.lab.           300     IN      A       192.168.50.15

root@nfsc:~/split-dns-lab#

   ```


ручная проверка

   ```bash
vagrant ssh client
[vagrant@client ~]$  
   dig @192.168.50.10 web2.dns.lab. A +norecurse
   dig @192.168.50.11 www.newdns.lab. A +short
   getent ahostsv4 www.newdns.lab.
   getenforce

; <<>> DiG 9.16.23-RH <<>> @192.168.50.10 web2.dns.lab. A +norecurse
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 59451
;; flags: qr aa; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: 91f53b25628e029d010000006af4a48a153eb7141cec9804 (good)
;; QUESTION SECTION:
;web2.dns.lab.                  IN      A

;; AUTHORITY SECTION:
dns.lab.                60      IN      SOA     ns01.dns.lab. hostmaster.dns.lab. 2026110901 60 30 86400 60

;; Query time: 11 msec
;; SERVER: 192.168.50.10#53(192.168.50.10)
;; WHEN: Wed Nov 11 17:23:22 UTC 2026
;; MSG SIZE  rcvd: 121

192.168.50.16
192.168.50.15
192.168.50.15   STREAM www.newdns.lab
192.168.50.15   DGRAM
192.168.50.15   RAW
192.168.50.16   STREAM
192.168.50.16   DGRAM
192.168.50.16   RAW
Enforcing
[vagrant@client ~]$

   ```

