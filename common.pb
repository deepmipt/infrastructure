- hosts: all
  tasks:
    - name: installing tree
      apt: pkg=tree
      become: true
    - name: installing pip3
      apt: pkg=python3-pip
      become: true
    - name: installing git
      apt: pkg=git
      become: true
    - name: installing screen
      apt: pkg=screen
      become: true
    - name: installing zsh
      apt: pkg=zsh
      become: true
    - name: installing tmux
      apt: pkg=tmux
      become: true
    - name: installing htop
      apt: pkg=htop
      become: true
    - name: install russian support
      apt: pkg=language-pack-ru
      become: true

- name: Set the locale and the time zone
  hosts: all
  become: true
  tasks:
    - name: set locale
      command: /usr/sbin/update-locale LANG=ru_RU.utf8 LC_ALL=ru_RU.utf8

- hosts: storage
  roles:
    - role: ansible-role-samba
      become: yes
      samba_shares_root: /home/shared
      samba_interfaces: eth1 lo tun0
      samba_security: user
      samba_guest_account: root
      samba_shares:
        - name: share
          read_only: no
          guest_ok: yes
          public: yes
          writable: yes

- hosts: build_server
  tasks:
    - name: installing java
      apt: pkg=default-jdk
      become: true
    - name: installing kibana
      apt:
        deb: https://artifacts.elastic.co/downloads/kibana/kibana-5.5.2-amd64.deb
      become: true
  roles:
    - role: ansible-elasticsearch 
      become: true
      es_instance_name: "node1"
      es_config:
        node.name: "node1" 
        http.port: 9200
        transport.tcp.port: 9300
        network.host: _global_
