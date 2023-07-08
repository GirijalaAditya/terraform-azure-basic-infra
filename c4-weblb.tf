resource "azurerm_public_ip" "weblb_pip" {
  name                = "${local.prefix}-weblb-pip"
  resource_group_name = data.azurerm_resource_group.azure_rg.name
  location            = data.azurerm_resource_group.azure_rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.common_tags
}

resource "azurerm_lb" "azure_web_lb" {
  name                = "${local.prefix}-weblb"
  resource_group_name = data.azurerm_resource_group.azure_rg.name
  location            = data.azurerm_resource_group.azure_rg.location
  sku                 = "Standard"
  sku_tier            = "Regional"

  frontend_ip_configuration {
    name                 = "weblb-frontend-ip-config"
    public_ip_address_id = azurerm_public_ip.weblb_pip.id
  }

  tags = local.common_tags
}

resource "azurerm_lb_backend_address_pool" "weblb_backend_pool" {
  name            = "weblb-backend-pool"
  loadbalancer_id = azurerm_lb.azure_web_lb.id
}

resource "azurerm_lb_probe" "weblb_probe" {
  name            = "tcp-probe-80"
  loadbalancer_id = azurerm_lb.azure_web_lb.id
  protocol        = "Tcp"
  port            = 80
}

resource "azurerm_lb_rule" "weblb_rule" {
  name                           = "weblb-rule"
  loadbalancer_id                = azurerm_lb.azure_web_lb.id
  probe_id                       = azurerm_lb_probe.weblb_probe.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.azure_web_lb.frontend_ip_configuration[0].name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.weblb_backend_pool.id]
  disable_outbound_snat = true
}

resource "azurerm_network_interface_backend_address_pool_association" "azure_nic_backend_pool" {
  network_interface_id    = azurerm_network_interface.web_linuxvm_nic.id
  ip_configuration_name   = azurerm_network_interface.web_linuxvm_nic.ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.weblb_backend_pool.id
}

resource "azurerm_lb_nat_rule" "weblb_inbound_nat" {
  name                           = "weblb-inbound-nat-22"
  resource_group_name            = data.azurerm_resource_group.azure_rg.name
  loadbalancer_id                = azurerm_lb.azure_web_lb.id
  protocol                       = "Tcp"
  frontend_port                  = 1022
  backend_port                   = 22
  frontend_ip_configuration_name = azurerm_lb.azure_web_lb.frontend_ip_configuration[0].name
  depends_on                     = [azurerm_linux_virtual_machine.web_linuxvm]
}

resource "azurerm_network_interface_nat_rule_association" "weblb_nat_rule_assoc" {
  network_interface_id  = azurerm_network_interface.web_linuxvm_nic.id
  ip_configuration_name = azurerm_network_interface.web_linuxvm_nic.ip_configuration[0].name
  nat_rule_id           = azurerm_lb_nat_rule.weblb_inbound_nat.id
}