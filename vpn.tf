#Crear la puerta de enlace local (On-premises)
# resource "azurerm_local_network_gateway" "onprem_gateway" {
#     provider = azurerm.LANGE_4
#     name                = "${var.prefix}-omprem-gateway"
#     resource_group_name = azurerm_resource_group.ieh_rg.name
#     location            = azurerm_resource_group.ieh_rg.location
#     gateway_address     = "190.140.80.94"  # Ajusta la dirección IP de tu puerta de enlace local
#     address_space       = ["192.168.4.0/23"]
# }

# Crear una IP pública para la puerta de enlace de Azure
resource "azurerm_public_ip" "azure_gateway_ip" {
  provider            = azurerm.LANGE_4
  name                = "${var.prefix}-azure-gateway-ip"
  resource_group_name = azurerm_resource_group.ieh_rg.name
  location            = azurerm_resource_group.ieh_rg.location
  allocation_method   = "Dynamic"
}

resource "azurerm_public_ip" "azure_gateway_ip_l3" {
  provider            = azurerm.LANGE_3
  name                = "${var.prefix}-azure-gateway-ip"
  resource_group_name = azurerm_resource_group.ieh_rg_l3.name
  location            = azurerm_resource_group.ieh_rg_l3.location
  allocation_method   = "Dynamic"
}

# Crear la puerta de enlace de VPN en Azure
resource "azurerm_virtual_network_gateway" "azure_gateway" {
  provider            = azurerm.LANGE_4
  name                = "${var.prefix}-azure-gateway"
  resource_group_name = azurerm_resource_group.ieh_rg.name
  location            = azurerm_resource_group.ieh_rg.location
  sku                 = "Basic" # Ajusta el SKU según tus necesidades
  type                = "Vpn"
  vpn_type            = "RouteBased"
  ip_configuration {
    name                          = "${var.prefix}-gateway-ip-config"
    public_ip_address_id          = azurerm_public_ip.azure_gateway_ip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.vpn_subnet.id
  }
}

resource "azurerm_virtual_network_gateway" "azure_gateway_l3" {
  provider            = azurerm.LANGE_3
  name                = "${var.prefix}-azure-gateway"
  resource_group_name = azurerm_resource_group.ieh_rg_l3.name
  location            = azurerm_resource_group.ieh_rg_l3.location
  sku                 = "Basic" # Ajusta el SKU según tus necesidades
  type                = "Vpn"
  vpn_type            = "RouteBased"
  ip_configuration {
    name                          = "${var.prefix}-gateway-ip-config"
    public_ip_address_id          = azurerm_public_ip.azure_gateway_ip_l3.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.vpn_subnet_l3.id
  }
}

# Crear la conexión VPN Site-to-Site
resource "azurerm_virtual_network_gateway_connection" "l4_to_l3" {
  provider                        = azurerm.LANGE_4
  name                            = "${var.prefix}-l4-to-l3"
  location                        = azurerm_resource_group.ieh_rg.location
  resource_group_name             = azurerm_resource_group.ieh_rg.name
  type                            = "Vnet2Vnet"
  virtual_network_gateway_id      = azurerm_virtual_network_gateway.azure_gateway.id
  peer_virtual_network_gateway_id = azurerm_virtual_network_gateway.azure_gateway_l3.id
  shared_key                      = "4-v3ry-53cr37-1p53c-5h4r3d-k3y" # Ajusta la clave compartida para la conexión VPN
}

resource "azurerm_virtual_network_gateway_connection" "l3_to_l4" {
  provider                        = azurerm.LANGE_3
  name                            = "${var.prefix}-l3-to-l4"
  location                        = azurerm_resource_group.ieh_rg_l3.location
  resource_group_name             = azurerm_resource_group.ieh_rg_l3.name
  type                            = "Vnet2Vnet"
  virtual_network_gateway_id      = azurerm_virtual_network_gateway.azure_gateway_l3.id
  peer_virtual_network_gateway_id = azurerm_virtual_network_gateway.azure_gateway.id
  shared_key                      = "4-v3ry-53cr37-1p53c-5h4r3d-k3y" # Ajusta la clave compartida para la conexión VPN
}
