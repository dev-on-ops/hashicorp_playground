# -*- coding: utf-8 -*-
# vim: ft=sls syntax=yaml softtabstop=2 tabstop=2 shiftwidth=2 expandtab autoindent

{% from "vault/map.jinja" import vault with context -%}
{% if vault.config.storage.raft.path is defined %}
vault-raft-storage-path-directory:
  file.directory:
    - user: vault
    - group: vault
    - mode: 700
    - name: {{ vault.config.storage.raft.path }}
    - makedirs: True
    - recurse:
      - user
      - group
      - mode
{% endif %}

vault-config-config-file-serialize:
  file.serialize:
    - name: /etc/vault/conf.d/config.json
    - encoding: utf-8
    - formatter: json
    - dataset: {{ vault.config | json }}
    - user: root
    - group: vault
    - mode: 640
    - makedirs: True
    - watch_in:
      - service: vault-service-init-service-running
