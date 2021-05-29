vagrant_nodes = [
  {
    :node       => "hcpmgmt01",
    :ip         => "192.168.255.151",
    :os         => "hashicorp/bionic64",
    :cpu        => "2",
    :memory_mb  => "4096",
    :salt_type  => "master"
  },
  {
    :node       => "hcpserver01",
    :ip         => "192.168.255.161",
    :os         => "hashicorp/bionic64",
    :cpu        => "2",
    :memory_mb  => "4096",
    :salt_type  => "minion"
  },
  {
    :node       => "hcpserver02",
    :ip         => "192.168.255.162",
    :os         => "hashicorp/bionic64",
    :cpu        => "2",
    :memory_mb  => "4096",
    :salt_type  => "minion"
  },
  {
    :node       => "hcpserver03",
    :ip         => "192.168.255.163",
    :os         => "hashicorp/bionic64",
    :cpu        => "2",
    :memory_mb  => "4096",
    :salt_type  => "minion"
  },
  {
    :node       => "hcpworker01",
    :ip         => "192.168.255.171",
    :os         => "hashicorp/bionic64",
    :cpu        => "2",
    :memory_mb  => "8192",
    :salt_type  => "minion"
  },
  {
    :node       => "hcpworker02",
    :ip         => "192.168.255.172",
    :os         => "hashicorp/bionic64",
    :cpu        => "2",
    :memory_mb  => "8192",
    :salt_type  => "minion"
  },
  {
    :node       => "hcpworker03",
    :ip         => "192.168.255.173",
    :os         => "hashicorp/bionic64",
    :cpu        => "2",
    :memory_mb  => "8192",
    :salt_type  => "minion"
  }
]

minion_keys_list = {
  "hcpmgmt01" => "saltstack/keys/hcpmgmt01.pub",
  "hcpserver01" => "saltstack/keys/hcpserver01.pub",
  "hcpserver02" => "saltstack/keys/hcpserver02.pub",
  "hcpserver03" => "saltstack/keys/hcpserver03.pub",
  "hcpworker01" => "saltstack/keys/hcpworker01.pub",
  "hcpworker02" => "saltstack/keys/hcpworker02.pub",
  "hcpworker03" => "saltstack/keys/hcpworker03.pub"
 }

Vagrant.configure("2") do |config|
  vagrant_nodes.each do |vagrant_node|
    if vagrant_node[:salt_type] == "master"
      config.vm.define vagrant_node[:node] do |instance|
        # VM Configs
        instance.ssh.insert_key = false
        instance.vm.box = vagrant_node[:os]
        instance.vm.hostname = vagrant_node[:node]
        instance.vm.network "private_network", ip: vagrant_node[:ip]
        instance.vm.provider :virtualbox do |v|
          v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
          v.customize ["modifyvm", :id, "--cpus", vagrant_node[:cpu]]
          v.customize ["modifyvm", :id, "--memory", vagrant_node[:memory_mb]]
          v.customize ["modifyvm", :id, "--name", vagrant_node[:node]]
        end
        # Salt Configs
        instance.vm.synced_folder "saltstack/salt/", "/srv/salt"
        instance.vm.synced_folder "saltstack/pillar/", "/srv/pillar"
        instance.vm.provision :salt do |salt|
          salt.master_config = "saltstack/etc/master"
          salt.master_key = "saltstack/keys/master_minion.pem"
          salt.master_pub = "saltstack/keys/master_minion.pub"
          salt.minion_key = "saltstack/keys/hcpmgmt01.pem"
          salt.minion_pub = "saltstack/keys/hcpmgmt01.pub"
          salt.minion_config = "saltstack/etc/minion"
          salt.seed_master = minion_keys_list
          salt.install_type = "stable"
          salt.install_master = true
          salt.no_minion = false
          salt.verbose = true
          salt.colorize = true
          salt.bootstrap_options = "-P -c /tmp -x python3"
        end
      end
    end
    if vagrant_node[:salt_type] == "minion"
      config.vm.define vagrant_node[:node] do |instance|
        instance.ssh.insert_key = false
        instance.vm.box = vagrant_node[:os]
        instance.vm.hostname = vagrant_node[:node]
        instance.vm.network "private_network", ip: vagrant_node[:ip]
        instance.vm.provider :virtualbox do |v|
          v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
          v.customize ["modifyvm", :id, "--cpus", vagrant_node[:cpu]]
          v.customize ["modifyvm", :id, "--memory", vagrant_node[:memory_mb]]
          v.customize ["modifyvm", :id, "--name", vagrant_node[:node]]
        end
        instance.vm.provision :salt do |salt|
          salt.minion_config = "saltstack/etc/minion"
          salt.minion_key = "saltstack/keys/#{ vagrant_node[:node]}.pem"
          salt.minion_pub = "saltstack/keys/#{ vagrant_node[:node]}.pub"
          salt.install_type = "stable"
          salt.verbose = true
          salt.colorize = true
          salt.bootstrap_options = "-P -c /tmp -x python3"
        end
      end
    end
  end
end