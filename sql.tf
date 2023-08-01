resource "azurerm_mssql_server" "ieh_000" {
  provider                      = azurerm.LANGE_4
  name                          = "${var.prefix}-mssql-000"
  location                      = azurerm_resource_group.ieh_rg.location
  resource_group_name           = azurerm_resource_group.ieh_rg.name
  version                       = "12.0"          # Ajusta la versión del servidor según tus necesidades
  administrator_login           = "adminuser"     # Ajusta el nombre de usuario del administrador según tus preferencias
  administrator_login_password  = "AdminPass123!" # Ajusta la contraseña del administrador según tus preferencias
  public_network_access_enabled = false
}

resource "azurerm_mssql_database" "ieh_db" {
  provider       = azurerm.LANGE_4
  name           = "${var.prefix}-sdb-001"
  server_id      = azurerm_mssql_server.ieh_000.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 250
  read_scale     = false
  sku_name       = "S0"
  zone_redundant = false
}