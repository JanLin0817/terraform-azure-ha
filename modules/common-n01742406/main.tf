resource "azurerm_log_analytics_workspace" "law" {
  name                = "n01742406-law"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.common_tags
}

resource "azurerm_recovery_services_vault" "rsv" {
  count               = 0
  name                = "n01742406-rsv"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  tags                = var.common_tags
}

resource "azurerm_storage_account" "sa" {
  name                     = "n01742406commonsa"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.common_tags
}