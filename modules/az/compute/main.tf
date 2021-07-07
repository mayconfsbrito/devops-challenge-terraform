ata "azurerm_resource_group" "azure_rg" {
  name = var.resource_group_name
}

data "azurerm_network_interface" "azure_network_interface" {
  name                = var.network_interface_name
  resource_group_name = data.azurerm_resource_group.azure_rg.name
}

resource "azurerm_virtual_machine" "az_virtual_machine" {
  name                          = var.name
  location                      = data.azurerm_resource_group.azure_rg.location
  resource_group_name           = data.azurerm_resource_group.azure_rg.name
  network_interface_ids         = [data.azurerm_network_interface.azure_network_interface.id]
  vm_size                       = var.size_vm
  delete_os_disk_on_termination = var.delete_os_disk

  storage_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  storage_os_disk {
    name              = var.os_disk_name
    caching           = var.os_disk_caching
    create_option     = var.os_disk_create
    managed_disk_type = var.os_disk_type
  }

  os_profile {
    computer_name  = var.os_profile_name
    admin_username = var.os_profile_username
    admin_password = var.os_profile_password
  }

  os_profile_linux_config {
    disable_password_authentication = var.os_profile_password_auth
  }

  tags = {
    Region      = data.azurerm_resource_group.azure_rg.location
    Team        = var.team_tag
    Environment = var.env
    Creator     = var.creator
  }
}
