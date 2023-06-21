resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = random_pet.rg_name.id
}

resource "azurerm_storage_account" "storage" {
  name                     = "adentfstorageaccount"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.resource_group_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  // Add other configuration seadentfings for the storage account
}

resource "azurerm_data_factory" "adf" {
  name                = "adentfdatafactory"
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_databricks_workspace" "databricks" {
  name                = "adentfdatabricks"
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "standard"
}

resource "azurerm_sql_database" "sqldb" {
  name                = "adentfsqldb"
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mssql_server.sqlserver.name
}

resource "azurerm_mssql_server" "sqlserver" {
  name                         = "adentfsqlserver"
  location                     = var.resource_group_location
  resource_group_name          = azurerm_resource_group.rg.name
  version                      = "12.0"
  administrator_login          = "adminuser"
  administrator_login_password = "Password1234!"
  minimum_tls_version = "1.2"
}
