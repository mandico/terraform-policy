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

resource "azurerm_postgresql_server" "postgresql" {
  name                = "my-postgresql-server"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "B_Gen5_1"
  storage_mb          = 5120
  version             = "11"
  administrator_login = "mandico"
  administrator_login_password = "P@ssw0rd123!"
  ssl_enforcement_enabled = true
}

resource "azurerm_postgresql_database" "database" {
  name                = "my-postgresql-database"
  server_name         = azurerm_postgresql_server.postgresql.name
  resource_group_name = azurerm_resource_group.rg.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}