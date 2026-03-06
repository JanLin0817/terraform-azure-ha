resource "null_resource" "display_hostnames" {
  for_each = var.vm_instances

  triggers = {
    vm_id = azurerm_linux_virtual_machine.vm[each.key].id
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Hostname: ' $(hostname)",
      "sudo dnf install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx",
      "sudo firewall-cmd --permanent --add-service=http",
      "sudo firewall-cmd --reload"
    ]

    connection {
      type        = "ssh"
      user        = var.admin_username
      private_key = file(var.private_key_path)
      host        = azurerm_public_ip.pip[each.key].fqdn
    }
  }
}