resource "azurerm_storage_account" "ieh_00" {
  provider                      = azurerm.LANGE_4
  name                          = "${var.prefix}sa"
  location                      = var.resource_group_location
  resource_group_name           = azurerm_resource_group.ieh_rg.name
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  public_network_access_enabled = true
  # network_rules {
  #   default_action = "Deny"

  #   # Permitir acceso a servicios de Azure por IP
  #   bypass          = ["AzureServices"]
  #   #virtual_network_subnet_ids = ["${azurerm_subnet.web_subnet.id}, ${azurerm_subnet.db_subnet.id}, ${azurerm_subnet.vpn_subnet.id}"]
  #   }
}

resource "azurerm_storage_container" "container" {
  provider              = azurerm.LANGE_4
  name                  = "data"
  storage_account_name  = azurerm_storage_account.ieh_00.name
  container_access_type = "private"
}
