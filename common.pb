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
  roles:
    - role: ansible-oracle-java
      become: yes
