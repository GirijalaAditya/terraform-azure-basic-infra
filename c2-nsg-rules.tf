locals {
  web_nsg_ports = {
    "100" : "80",
    "110" : "443",
    "120" : "22"
  }
}

resource "azurerm_network_security_rule" "web_nsg_rules" {
  for_each                    = local.web_nsg_ports
  name                        = "Rule-Port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.azure_rg.name
  network_security_group_name = azurerm_network_security_group.web_subnet_nsg.name
}

locals {
  app_nsg_ports = {
    "100" : "80",
    "110" : "443",
    "120" : "22",
    "130" : "8080"
  }
}

resource "azurerm_network_security_rule" "app_nsg_rules" {
  for_each                    = local.app_nsg_ports
  name                        = "Rule-Port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.azure_rg.name
  network_security_group_name = azurerm_network_security_group.app_subnet_nsg.name
}

locals {
  db_nsg_ports = {
    "100" : "3306",
    "110" : "1433",
    "120" : "5432"
  }
}

resource "azurerm_network_security_rule" "db_nsg_rules" {
  for_each                    = local.db_nsg_ports
  name                        = "Rule-Port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.azure_rg.name
  network_security_group_name = azurerm_network_security_group.db_subnet_nsg.name
}

locals {
  bastion_nsg_ports = {
    "100" : "22",
    "110" : "3389"
  }
}

resource "azurerm_network_security_rule" "bastion_nsg_rules" {
  for_each                    = local.bastion_nsg_ports
  name                        = "Rule-Port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.azure_rg.name
  network_security_group_name = azurerm_network_security_group.bastion_subnet_nsg.name
}
