output "database_id" {
  value = azurerm_mssql_database.ieh_db.id
}

output "database_name" {
  value = azurerm_mssql_database.ieh_db.public_dns
}

output "storage_name" {
  value = azurerm_storage_account.ieh_00.id.public_dns
}

output "webapp_name" {
  value = azurerm_windows_web_app.ieh_webapp.public_dns
}

# output "tls_private_key" {
#   value     = tls_private_key.example_ssh.private_key_pem
#   sensitive = true
# }