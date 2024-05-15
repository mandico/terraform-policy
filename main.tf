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

resource "azurerm_mysql_flexible_server" "mysql_server" {
  name                = "my-flexible-server"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku_name            = "Standard_D2s_v3"
  storage_profile {
    storage_mb = 5120
  }
  administrator_login          = "adminuser"
  administrator_login_password = "P@ssw0rd123!"
  version                      = "8.0"
  backup_retention_days        = 7
  auto_grow_enabled            = true
  ssl_enforcement_enabled      = true
}