resource "azurerm_subnet_network_security_group_association" "web_sub_nsg_assoc" {
  subnet_id                 = azurerm_subnet.web_subnet.id
  network_security_group_id = azurerm_network_security_group.web_subnet_nsg.id
  depends_on                = [azurerm_network_security_rule.web_nsg_rules]
}

resource "azurerm_subnet_network_security_group_association" "app_sub_nsg_assoc" {
  subnet_id                 = azurerm_subnet.app_subnet.id
  network_security_group_id = azurerm_network_security_group.app_subnet_nsg.id
  depends_on                = [azurerm_network_security_rule.app_nsg_rules]
}

resource "azurerm_subnet_network_security_group_association" "db_sub_nsg_assoc" {
  subnet_id                 = azurerm_subnet.db_subnet.id
  network_security_group_id = azurerm_network_security_group.db_subnet_nsg.id
  depends_on                = [azurerm_network_security_rule.db_nsg_rules]
}

resource "azurerm_subnet_network_security_group_association" "bastion_sub_nsg_assoc" {
  subnet_id                 = azurerm_subnet.bastion_subnet.id
  network_security_group_id = azurerm_network_security_group.bastion_subnet_nsg.id
  depends_on                = [azurerm_network_security_rule.bastion_nsg_rules]
}