resource "random_pet" "rg_name" {
  prefix = "rg"
}

resource "azurerm_storage_account" "storage" {
  name                     = "adentfstorageaccount"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  
  identity {
	type = "SystemAssigned"
  }
}

resource "azurerm_storage_container" "gen_storage_container" {
  name                  = "adentfcontainer"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_data_factory" "adf" {
  name                = "adentfdatafactory"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_databricks_workspace" "databricks" {
  name                = "adentfdatabricks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "standard"
}

resource "azurerm_sql_database" "sqldb" {
  name                = "adentfsqldb"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mssql_server.sqlserver.name
}

resource "azurerm_mssql_server" "sqlserver" {
  name                         = "adentfsqlserver"
  location                     = azurerm_resource_group.rg.location
  resource_group_name          = azurerm_resource_group.rg.name
  version                      = "12.0"
  administrator_login          = "adminuser"
  administrator_login_password = "Password1234!"
  minimum_tls_version = "1.2"
}
