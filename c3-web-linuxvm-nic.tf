resource "azurerm_network_interface" "web_linuxvm_nic" {
  name                = "${local.prefix}-web-linuxvm-nic"
  location            = data.azurerm_resource_group.azure_rg.location
  resource_group_name = data.azurerm_resource_group.azure_rg.name

  ip_configuration {
    name                          = "weblinux-nic-ipconf"
    subnet_id                     = azurerm_subnet.web_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.web_linuxvm_pip.id
  }
  tags = local.common_tags
}