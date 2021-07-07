
module "az_virtual_machine" {
  source                 = "../../modules/az/compute"
  
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
