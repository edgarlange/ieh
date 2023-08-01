# Crear zona DNS privada
resource "azurerm_private_dns_zone" "dns_zone_web" {
  provider            = azurerm.LANGE_4
  name                = "privatelink.azurewebsites.net"
  resource_group_name = azurerm_resource_group.ieh_rg.name
}
resource "azurerm_private_dns_zone" "dns_zone_db" {
  provider            = azurerm.LANGE_4
  name                = "privatelink.database.windows.net"
  resource_group_name = azurerm_resource_group.ieh_rg.name
}
resource "azurerm_private_dns_zone" "dns_zone_sa" {
  provider            = azurerm.LANGE_4
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.ieh_rg.name
}
# Vínculo entre la zona DNS privada y la red virtual
resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_web_link" {
  provider              = azurerm.LANGE_4
  name                  = "vnet-dns-web-link"
  resource_group_name   = azurerm_resource_group.ieh_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.dns_zone_web.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}
resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_db_link" {
  provider              = azurerm.LANGE_4
  name                  = "vnet-dns-db-link"
  resource_group_name   = azurerm_resource_group.ieh_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.dns_zone_db.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}
resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_sa_link" {
  provider              = azurerm.LANGE_4
  name                  = "vnet-dns-sa-link"
  resource_group_name   = azurerm_resource_group.ieh_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.dns_zone_sa.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}
resource "azurerm_private_dns_zone_virtual_network_link" "private_l3_dns_web_link" {
  provider              = azurerm.LANGE_4
  name                  = "vnet-l3-dns-web-link"
  resource_group_name   = azurerm_resource_group.ieh_rg_l3.name
  private_dns_zone_name = azurerm_private_dns_zone.dns_zone_web.name
  virtual_network_id    = azurerm_virtual_network.vnet_l3.id
}
resource "azurerm_private_dns_zone_virtual_network_link" "private_l3_dns_db_link" {
  provider              = azurerm.LANGE_4
  name                  = "vnet-l3-dns-db-link"
  resource_group_name   = azurerm_resource_group.ieh_rg_l3.name
  private_dns_zone_name = azurerm_private_dns_zone.dns_zone_db.name
  virtual_network_id    = azurerm_virtual_network.vnet_l3.id
}
resource "azurerm_private_dns_zone_virtual_network_link" "private_l3_dns_sa_link" {
  provider              = azurerm.LANGE_4
  name                  = "vnet-l3-dns-sa-link"
  resource_group_name   = azurerm_resource_group.ieh_rg_l3.name
  private_dns_zone_name = azurerm_private_dns_zone.dns_zone_sa.name
  virtual_network_id    = azurerm_virtual_network.vnet_l3.id
}