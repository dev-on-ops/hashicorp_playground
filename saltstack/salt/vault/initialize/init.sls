vault operator init -format=json -key-shares=1 -key-threshold=1 > payload.json

curl --header "X-Vault-Token: s.3ds3Lai0N0dDMqyq5lNrmJ0w" --request POST --data @payload.json http://192.168.255.151:8200/v1/kv/test
curl     --header "X-Vault-Token: s.3ds3Lai0N0dDMqyq5lNrmJ0w" --request GET http://192.168.255.151:8200/v1/kv/test


jq .data.root_token
jq .data.unseal_keys_b64
jq .data.unseal_keys_b64[0]

# Chain of trust
# bootstrap control plane per site
# salt, salt-vault, vault, consul, nomad, jenkins, packer