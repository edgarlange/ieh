resource "azurerm_service_plan" "ieh_sp" {
  provider            = azurerm.LANGE_4
  name                = "${var.prefix}sp"
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.ieh_rg.name
  os_type             = "Windows"
  sku_name            = "P1v2"
}

resource "azurerm_windows_web_app" "ieh_webapp" {
  provider                      = azurerm.LANGE_4
  name                          = "${var.prefix}web"
  resource_group_name           = azurerm_resource_group.ieh_rg.name
  location                      = var.resource_group_location
  service_plan_id               = azurerm_service_plan.ieh_sp.id
  public_network_access_enabled = false
  virtual_network_subnet_id     = azurerm_subnet.web_subnet.id

  site_config {}
}
