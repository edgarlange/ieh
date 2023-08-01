# resource "azurerm_public_ip" "example" {
#   name                = "${var.prefix}-public-ip"
#   location            = var.resource_group_location
#   resource_group_name = azurerm_resource_group.ieh_rg.name
#   allocation_method   = "Static"
#   sku                 = "Standard"
# }

# resource "azurerm_firewall" "example" {
#   name                = "${var.prefix}-firewall"
#   location            = var.resource_group_location
#   resource_group_name = azurerm_resource_group.ieh_rg.name
#   sku_name            = "AZFW_VNet"
#   sku_tier            = "Basic"

#   ip_configuration {
#     name                 = "configuration"
#     subnet_id            = azurerm_subnet.fw_subnet.id
#     public_ip_address_id = azurerm_public_ip.example.id
#   }
# }
