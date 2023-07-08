resource "azurerm_linux_virtual_machine" "web_linuxvm" {
  name                  = "${local.prefix}-web-linuxvm"
  resource_group_name   = data.azurerm_resource_group.azure_rg.name
  location              = data.azurerm_resource_group.azure_rg.location
  size                  = "Standard_D2s_v3"
  network_interface_ids = [azurerm_network_interface.web_linuxvm_nic.id]
  admin_username        = "azureuser"

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
  user_data = filebase64("${path.module}/scripts/script.sh")
}