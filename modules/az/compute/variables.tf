variable "resource_group_name" {
  description = "(Required) The name of an existing resource group to be imported."
  type        = string
}

variable "name" {
  description = "(Required) The name of the Virtual Machine"
  default     = "cloud-vm"
}

variable "vnet_name" {
  description = "(Required) The name of the virtual network"
  default     = "cloud-vnet"
}

variable "network_interface_name" {
  description = "(Required) The name of Network Interface Controller"
  default     = "ankesh-network-interface"
}

variable "size_vm" {
  description = "(Required) The size of Virtual Machine"
  default     = "Standard_D2_v2"
}

variable "delete_os_disk" {
  description = "(Optional) If you want the disk to be deleted while termination. Possible values are true and false"
  default     = "true"
}

variable "image_publisher" {
  description = "(Required) Publisher of the image"
  default     = "Canonical"
}

variable "image_offer" {
  description = "(Required) Offer of the image"
  default     = "UbuntuServer"
}

variable "image_version" {
  description = "(Required) Version of the image"
  default     = "latest"
}

variable "image_sku" {
  description = "(Required) SKU of the image"
  default     = "18.04-LTS"
}

variable "os_disk_name" {
  description = "(Required) Name of OS Disk"
  default     = "cloud-vm-disk"
}

variable "os_disk_caching" {
  description = "(Required) caching requirement of OS Disk"
  default     = "ReadWrite"
}

variable "os_disk_create" {
  description = "(Required) How to create OS Disk"
  default     = "FromImage"
}

variable "os_disk_type" {
  description = "(Required) Type of managed OS Disk"
  default     = "Standard_LRS"
}

variable "os_profile_name" {
  description = "(Required) Name of the computer"
  default     = "cloud-vm-host"
}

variable "os_profile_username" {
  description = "(Required) Username of the vm"
  default     = "devops"
}

variable "os_profile_password" {
  description = "(Required) Passoword of the vm"
  default     = "Devops123456789"
}

variable "os_profile_password_auth" {
  description = "(Required) Disable password authentication. Possible vales are true or false"
  default     = "false"
}

variable "env" {
  description = "(Optional) name of the resource group"
  default     = "dev"
}

variable "team_tag" {
  description = "(Optional) tag a team"
  default     = "DevOps"
}

variable "creator" {
  description = "(Optional) tag a creator"
  default     = "iankesh"
}
