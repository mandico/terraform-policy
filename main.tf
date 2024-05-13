provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "azr-rg-demo"
  location = "eastus"
}

