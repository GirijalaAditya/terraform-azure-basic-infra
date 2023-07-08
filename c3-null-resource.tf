resource "null_resource" "copy_ssh_key_to_bastion_vm" {
  depends_on = [azurerm_linux_virtual_machine.bastion_host_linuxvm]

  connection {
    type        = "ssh"
    host        = azurerm_linux_virtual_machine.bastion_host_linuxvm.public_ip_address
    user        = azurerm_linux_virtual_machine.bastion_host_linuxvm.admin_username
    private_key = file("${path.module}/ssh-keys/terraform-key")
  }

  provisioner "file" {
    source      = "ssh-keys/terraform-key"
    destination = "/tmp/terraform-key"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/terraform-key"
    ]
  }
}