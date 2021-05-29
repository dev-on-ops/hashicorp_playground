# -*- coding: utf-8 -*-
# vim: ft=sls syntax=yaml softtabstop=2 tabstop=2 shiftwidth=2 expandtab autoindent

{% from "vault/map.jinja" import vault with context %}
{% if vault.vault_keys is defined %}
{% set keys = vault.vault_keys.unseal %}
  {% for key in keys %}
unseal_vault_key_number_{{ loop.index }}:
  cmd.run:
    - name: 'VAULT_ADDR="{{ vault.config.api_addr }}" vault operator unseal {{ key }}'

  {% endfor %}
{% endif %}