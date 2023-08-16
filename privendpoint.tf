# Crear private endpoints
resource "azurerm_private_endpoint" "sa" {
  provider            = azurerm.LANGE_4
  name                = "${var.prefix}sa-endpoint"
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.ieh_rg.name
  subnet_id           = azurerm_subnet.db_subnet.id

  private_service_connection {
    name                           = "${var.prefix}sa-privateserviceconnection"
    private_connection_resource_id = azurerm_storage_account.ieh_00.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }
  private_dns_zone_group {
    name                 = "sa-dns-zg"
    private_dns_zone_ids = [azurerm_private_dns_zone.dns_zone_sa.id]
  }
}

resource "azurerm_private_endpoint" "db" {
  provider            = azurerm.LANGE_4
  name                = "${var.prefix}db-endpoint"
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.ieh_rg.name
  subnet_id           = azurerm_subnet.db_subnet.id

  private_service_connection {
    name                           = "${var.prefix}db-privateserviceconnection"
    private_connection_resource_id = azurerm_mssql_server.ieh_000.id
    subresource_names              = ["sqlserver"]
    is_manual_connection           = false
  }
  private_dns_zone_group {
    name                 = "db-dns-zg"
    private_dns_zone_ids = [azurerm_private_dns_zone.dns_zone_db.id]
  }
}

resource "azurerm_private_endpoint" "web" {
  provider            = azurerm.LANGE_4
  name                = "${var.prefix}web-endpoint"
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.ieh_rg.name
  subnet_id           = azurerm_subnet.db_subnet.id

  private_service_connection {
    name                           = "${var.prefix}web-privateserviceconnection"
    private_connection_resource_id = azurerm_windows_web_app.ieh_webapp.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }
  private_dns_zone_group {
    name                 = "web-dns-zg"
    private_dns_zone_ids = [azurerm_private_dns_zone.dns_zone_web.id]
  }
}