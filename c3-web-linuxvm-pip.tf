resource "azurerm_public_ip" "web_linuxvm_pip" {
  name                = "${local.prefix}-web-linuxvm-pip"
  resource_group_name = data.azurerm_resource_group.azure_rg.name
  location            = data.azurerm_resource_group.azure_rg.location
  allocation_method   = "Static"
  domain_name_label   = "web-linuxvm-${random_string.random_data.id}"
  sku                 = "Standard"
  tags                = local.common_tags
}