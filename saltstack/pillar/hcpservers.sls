---
vault:
  version: 1.6.2
  platform: linux_amd64
  dev_mode: false
  verify_download: false
  {% if salt.grains.get('nodename') == "hcpserver01"%}
  init_leader: True
  {% else %}
  init_leader: false
  {%endif %}
  config:
    storage:
      raft:
        node_id: {{ salt.grains.get('nodename') }}
        path: "/vault"
        retry_join:
          - leader_api_addr: "http://192.168.255.161:8200"
          - leader_api_addr: "http://192.168.255.162:8200"
          - leader_api_addr: "http://192.168.255.163:8200"
    listener:
      tcp:
        address: "0.0.0.0:8200"
        tls_disable: "true"
    default_lease_ttl: 768h
    max_lease_ttl: 768h
    ui: "true"
    cluster_addr: "http://{{ grains['ip_interfaces']['eth1'][0] }}:8201"
    api_addr: "http://{{ grains['ip_interfaces']['eth1'][0] }}:8200"

consul:
  service: true
  user: consul
  group: consul
  version: 1.9.3
  download_host: releases.hashicorp.com
  {% if salt.grains.get('nodename') == "hcpserver01"%}
  bootstrap_leader: True
  {% else %}
  bootstrap_leader: false
  {%endif %}
  config:
    server: true
    bind_addr: {{ grains['ip_interfaces']['eth1'][0] }}
    client_addr: 0.0.0.0
    enable_debug: false
    datacenter: hcp
    encrypt: "RIxqpNlOXqtr/j4BgvIMEw=="
    bootstrap_expect: 3
    retry_interval: 15s
    retry_join:
      - 192.168.255.161
      - 192.168.255.162
      - 192.168.255.163
    acl:
      enabled: true
      default_policy: "deny"
      enable_token_persistence: true
    ui_config:
      enabled: true
    log_level: info
    data_dir: /consul
  bootstrap:
    test: "test"
# vim: set softtabstop=2 tabstop=2 shiftwidth=2 expandtab autoindent ft=sls syntax=yaml:

nomad:
  service: true
  version: "1.0.3"
  bin_dir: /usr/local/bin
  config_dir: /etc/nomad.d
  use_local_service_file: true
  config:
    datacenter: hcp
    region: hcp
    data_dir: /nomad
    # Nodes not bound to consul must be configured to advertise themselves.
    bind_addr: 0.0.0.0
    advertise:
      http: "{{ grains['ip_interfaces']['eth1'][0] }}"
      rpc: "{{ grains['ip_interfaces']['eth1'][0] }}"
      serf: "{{ grains['ip_interfaces']['eth1'][0] }}"
    server:
      enabled: True
      bootstrap_expect: 3
      encrypt: "AaABbB+CcCdDdEeeFFfggG=="
      server_join:
      - retry_join:
          - 192.168.255.161
          - 192.168.255.162
          - 192.168.255.163

consul_template:
  # Start consul-template daemon and enable it at boot time
  service: true

  config:
    consul: 127.0.0.1:8500
    log_level: info

  tmpl:
    - name: example.com
      source: salt://files/example.com.ctmpl
      config:
        template:
          source: /etc/consul-template/tmpl-source/example.com.ctmpl
          destination: /etc/nginx/sites-enabled/example.com
          command: systemctl restart nginx