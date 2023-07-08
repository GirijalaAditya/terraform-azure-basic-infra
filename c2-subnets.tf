resource "azurerm_subnet" "web_subnet" {
  name                 = "${azurerm_virtual_network.az_vnet.name}-${var.web_subnet_name}"
  virtual_network_name = azurerm_virtual_network.az_vnet.name
  resource_group_name  = data.azurerm_resource_group.azure_rg.name
  address_prefixes     = var.web_subnet_address_space
}

resource "azurerm_subnet" "app_subnet" {
  name                 = "${azurerm_virtual_network.az_vnet.name}-${var.app_subnet_name}"
  virtual_network_name = azurerm_virtual_network.az_vnet.name
  resource_group_name  = data.azurerm_resource_group.azure_rg.name
  address_prefixes     = var.app_subnet_address_space
}

resource "azurerm_subnet" "db_subnet" {
  name                 = "${azurerm_virtual_network.az_vnet.name}-${var.db_subnet_name}"
  virtual_network_name = azurerm_virtual_network.az_vnet.name
  resource_group_name  = data.azurerm_resource_group.azure_rg.name
  address_prefixes     = var.db_subnet_address_space
}

resource "azurerm_subnet" "bastion_subnet" {
  name                 = "${azurerm_virtual_network.az_vnet.name}-${var.bastion_subnet_name}"
  virtual_network_name = azurerm_virtual_network.az_vnet.name
  resource_group_name  = data.azurerm_resource_group.azure_rg.name
  address_prefixes     = var.bastion_subnet_address_space
}