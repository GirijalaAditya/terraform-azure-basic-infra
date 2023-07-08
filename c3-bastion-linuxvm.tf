resource "azurerm_public_ip" "bastion_host_pip" {
  name                = "${local.prefix}-bastion-host-publicip"
  resource_group_name = data.azurerm_resource_group.azure_rg.name
  location            = data.azurerm_resource_group.azure_rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "bastion_host_linuxvm_nic" {
  name                = "${local.prefix}-bastion-host-linuxvm-nic"
  location            = data.azurerm_resource_group.azure_rg.location
  resource_group_name = data.azurerm_resource_group.azure_rg.name

  ip_configuration {
    name                          = "bastion-host-ipconf"
    subnet_id                     = azurerm_subnet.bastion_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.bastion_host_pip.id
  }
}

resource "azurerm_linux_virtual_machine" "bastion_host_linuxvm" {
  name                  = "${local.prefix}-bastion-linuxvm"
  resource_group_name   = data.azurerm_resource_group.azure_rg.name
  location              = data.azurerm_resource_group.azure_rg.location
  size                  = "Standard_D2s_v3"
  admin_username        = "azureuser"
  network_interface_ids = [azurerm_network_interface.bastion_host_linuxvm_nic.id]
  admin_ssh_key {
    username   = "azureuser"
    public_key = file("${path.module}/ssh-keys/terraform-key.pub")
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "92-gen2"
    version   = "latest"
  }
  boot_diagnostics {

  }
}
