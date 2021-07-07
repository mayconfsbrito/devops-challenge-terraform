output "az_virtual_machine_id" {
  description = "The id of the newly created Virtual Machine"
  value       = azurerm_virtual_machine.az_virtual_machine.id
}
