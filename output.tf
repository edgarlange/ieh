output "database_name" {
  value = azurerm_mssql_database.ieh_db.default_hostname
}

output "storage_name" {
  value = azurerm_storage_account.ieh_00.primary_blob_host
}

output "webapp_name" {
  value = azurerm_windows_web_app.ieh_webapp.default_hostname
}

# output "tls_private_key" {
#   value     = tls_private_key.example_ssh.private_key_pem
#   sensitive = true
# }