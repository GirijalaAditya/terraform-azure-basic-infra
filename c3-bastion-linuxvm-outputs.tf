output "bastion_linuxvm_public_ip_address" {
  description = "Web Linux Virtual Machine Public IP"
  value       = azurerm_linux_virtual_machine.bastion_host_linuxvm.public_ip_address
}

output "bastion_linuxvm_private_ip_address" {
  description = "Web Linux Virtual Machine Private IP"
  value       = azurerm_linux_virtual_machine.bastion_host_linuxvm.private_ip_address
}