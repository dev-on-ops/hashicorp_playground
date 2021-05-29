{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot + '/map.jinja' import consul with context -%}
{% if consul.bootstrap is defined %}
{% if consul.bootstrap_leader == "true" %}

{% endif %}
{% endif %}


{#
consul acl bootstrap -format=json > payload.json
{
    "CreateIndex": 387,
    "ModifyIndex": 387,
    "AccessorID": "273cdc08-f3f7-5dce-a936-1396b1e73f88",
    "SecretID": "101292eb-0abd-4c4e-e764-81087971ad72",
    "Description": "Bootstrap Token (Global Management)",
    "Policies": [
        {
            "ID": "00000000-0000-0000-0000-000000000001",
            "Name": "global-management"
        }
    ],
    "Local": false,
    "CreateTime": "2021-02-21T22:33:53.745732282Z",
    "Hash": "oyrov6+GFLjo/KZAfqgxF/X4J/3LX0435DOBy9V22I0="
}


curl --header "X-Vault-Token: s.3ds3Lai0N0dDMqyq5lNrmJ0w" --request POST --data @payload.json http://192.168.255.151:8200/v1/kv/consul
#}