terraform {
  backend "azurerm" {
    resource_group_name  = "NetworkWatcherRG"
    storage_account_name = "azrstgstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "azr-rg-demo"
  location = "eastus"
}
resource "azurerm_app_configuration" "appconf" {
  name                = "azr-app-config-demo"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}