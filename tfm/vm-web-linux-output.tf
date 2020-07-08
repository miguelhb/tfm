#############################################
## Azure Linux VM with Web Module - Output ##
#############################################

output "web_vm_name" {
  description = "Virtual Machine name"
  value       = azurerm_virtual_machine.vm1.name
}



output "web_vm_admin_username" {
  description = "Username password for the Virtual Machine"
  value       = azurerm_virtual_machine.vm1.os_profile.*
  #sensitive   = true
}

output "web_vm_admin_password" {
  description = "Administrator password for the Virtual Machine"
  value       = random_password.web-vm-password.result
  #sensitive   = true
}
