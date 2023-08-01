# Crear una IP pública para Bastion
resource "azurerm_public_ip" "bastion" {
  provider            = azurerm.LANGE_3
  name                = "${var.prefix}-bastion-public-ip"
  location            = azurerm_resource_group.ieh_rg_l3.location
  resource_group_name = azurerm_resource_group.ieh_rg_l3.name
  allocation_method   = "Static"
  sku                 = "Standard"
}
# Crear Bastion
resource "azurerm_bastion_host" "bastion" {
  provider            = azurerm.LANGE_3
  name                = "${var.prefix}-bastion"
  location            = azurerm_resource_group.ieh_rg_l3.location
  resource_group_name = azurerm_resource_group.ieh_rg_l3.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.ba_subnet.id
    public_ip_address_id = azurerm_public_ip.bastion.id
  }
}