output "web_lb_public_ip_address" {
  description = "Web Load Balancer Public Address"
  value       = azurerm_public_ip.weblb_pip.ip_address
}

output "web_lb_id" {
  description = "Web Load Balancer ID."
  value       = azurerm_lb.azure_web_lb.id
}

output "web_lb_frontend_ip_configuration" {
  description = "Web LB frontend_ip_configuration Block"
  value       = [azurerm_lb.azure_web_lb.frontend_ip_configuration]
}