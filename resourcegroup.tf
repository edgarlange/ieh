resource "azurerm_resource_group" "ieh_rg" {
  provider = azurerm.LANGE_4
  name     = "${var.prefix}-resource-group-000"
  location = var.resource_group_location
}

resource "azurerm_resource_group" "ieh_rg_l3" {
  provider = azurerm.LANGE_3
  name     = "${var.prefix}-resource-group-000"
  location = var.resource_group_location
}