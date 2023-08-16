output "database_id" {
  value = azurerm_mssql_database.ieh_db.id
}

output "database_name" {
  value = azurerm_mssql_database.ieh_db.server_id
}

output "storage_name" {
  value = azurerm_storage_account.ieh_00.primary_blob_host
}

output "webapp_name" {
  value = azurerm_private_endpoint.web.network_interface
}

# output "tls_private_key" {
#   value     = tls_private_key.example_ssh.private_key_pem
#   sensitive = true
# }