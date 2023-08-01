output "database_id" {
  value = azurerm_mssql_database.ieh_db.id
}

# output "tls_private_key" {
#   value     = tls_private_key.example_ssh.private_key_pem
#   sensitive = true
# }