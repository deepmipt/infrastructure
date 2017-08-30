- hosts: all
  tasks:
    - name: installing zsh
      apt: pkg=zsh
      sudo: yes
    - name: installing tree
      apt: pkg=tree
      sudo: yes
    - name: installing pip3
      apt: pkg=python3-pip
      sudo: yes
