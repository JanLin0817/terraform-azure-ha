terraform {
  backend "azurerm" {
    resource_group_name  = "tfstaten01742406RG"
    storage_account_name = "tfstaten01742406sa"
    container_name       = "tfstatefiles"
    key                  = "terraform01742406.tfstate"
  }
}