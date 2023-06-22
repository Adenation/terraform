output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "data_factory_name" {
  value = azurerm_data_factory.adf.name
}

output "databricks_name" {
  value = azurerm_databricks_workspace.databricks.name
}

output "sql_db_name" {
  value = azurerm_sql_database.sqldb.name
}
