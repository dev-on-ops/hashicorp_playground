Thoughts:
* salt master
* deploy vault on salt master
* init vault and unseal
* deploy vault on control plane servers
* init vault and unseal control plane servers
* configure pki engine, configure kv engine
* create policy for consul kv access to vault
* deploy consul to control plane servers
* bootstrap consul acl and store managment token in vault
* vault configure consul secret engine and policies for servers and clients
* consul template deployed, retrieve server token, retrieve ca certificates