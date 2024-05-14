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

resource "azurerm_mysql_server" "mysql" {
  name                = "mysql-server"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "B_Gen5_1"
  storage_mb          = 5120
  version             = "5.7"

  administrator_login          = "adminuser"
  administrator_login_password = "P@ssw0rd1234"

  ssl_enforcement_enabled = false
}