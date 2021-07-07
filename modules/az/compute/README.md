# Example Terraform Module

Terraform modules as an example for Azure VMs


#### Parameters to pass
| Parameters | Need | Description
| ------ | ------ | ------ |
source |(Required)|source of this module
name|(Required)|name of the Virtual Machine
resource_group_name|(Required)|name of the Resorce Group
vnet_name|(Reqiured)|The name of the virtual network
network_interface_name|(Required)|The name of NIC
size_vm|(Required)|The size of the VM
os_profile_username|(Reqiured)|The username of the VM
os_profile_password|(Required)|The password of the VM
env|(Optional)|name of the environment
team_tag|(Optional)|tag a team
creator|(Optional)|tag a creator

#### Usage:
}

module "az_virtual_machine" {
  source                 = ""
  name                   = "test-vm"
  resource_group_name    = module.az_resource_group.az_rg_name
  network_interface_name = module.az_network_interface.az_network_interface_name
  size_vm                = "Standard_D2_v2"
  os_disk_name           = "test-vm-disk"
  os_profile_name        = "test-vm-host"
  os_profile_username    = "devops"
  os_profile_password    = "**********"
  env                    = "dev"
  team_tag               = "DevOps"
  creator                = "test"
}
```

#### Terraform Execution:
###### To initialize Terraform:
```sh
terraform init
```

###### To execute Terraform Plan:
```sh
terraform plan
```

###### To apply Terraform changes:
```sh
terraform apply
```
