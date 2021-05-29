---
vault:
  version: 1.6.2
  platform: linux_amd64
  dev_mode: false
  verify_download: false
  {% if salt.grains.get('nodename') == "hcpmgmt01"%}
  init_leader: True
  {% else %}
  init_leader: false
  {%endif %}
  config:
    storage:
      raft:
        node_id: {{ salt.grains.get('nodename') }}
        path: "/vault"
    listener:
      tcp:
        address: "0.0.0.0:8200"
        tls_disable: "true"
    default_lease_ttl: 768h
    max_lease_ttl: 768h
    ui: "true"
    cluster_addr: "http://127.0.0.1:8201"
    api_addr: "http://127.0.0.1:8200"
  vault_keys:
    Initial_Root_Token: s.3ds3Lai0N0dDMqyq5lNrmJ0w
    unseal:
      - nezogJDefsYBJ7WJUCkzdx/sKQjatwopr9nJU8y5pQ6c
      - NFnCotj2BxOUMYtuGLwnwnjDtjAeLurXlta5N6ER9wnk
      - R18JHJwzvAsZQyGqK6GVfmzdsjEUkrKaWkKyXeaasrvS
      - aqSpDQbsUM6+ir5A7h+8CJ6u1+8CZhesRVbtPTgdhoy9
      - oDJ0bgdKZpr+YVMg/Tg1MfAsQ4SjQ++j5ZdqimpFQr46
