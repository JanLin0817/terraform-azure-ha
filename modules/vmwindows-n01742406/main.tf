resource "azurerm_availability_set" "avs" {
  name                         = "n01742406-windows-avs"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  tags                         = var.common_tags
}

resource "azurerm_public_ip" "pip" {
  count               = var.nb_count
  name                = "${var.windows_name}-pip-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  domain_name_label   = "${var.windows_name}-${count.index + 1}"
  tags                = var.common_tags
}

resource "azurerm_network_interface" "nic" {
  count               = var.nb_count
  name                = "${var.windows_name}-nic-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip[count.index].id
  }
  tags = var.common_tags
}

resource "azurerm_windows_virtual_machine" "vm" {
  count                 = var.nb_count
  name                  = "${var.windows_name}-${count.index + 1}"
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = "Standard_D2s_v3"
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]
  availability_set_id   = azurerm_availability_set.avs.id

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = var.storage_account_uri
  }

  tags = var.common_tags
}

resource "azurerm_virtual_machine_extension" "antimalware" {
  count                = var.nb_count
  name                 = "IaaSAntimalware"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm[count.index].id
  publisher            = "Microsoft.Azure.Security"
  type                 = "IaaSAntimalware"
  type_handler_version = "1.3"

  settings = <<SETTINGS
    {
        "AntimalwareEnabled": true,
        "RealtimeProtectionEnabled": "true",
        "ScheduledScanSettings": {
            "isEnabled": "true",
            "day": "1",
            "time": "120",
            "scanType": "Quick"
        },
        "Exclusions": {
            "Extensions": "",
            "Paths": "",
            "Processes": ""
        }
    }
SETTINGS
  tags = var.common_tags
}