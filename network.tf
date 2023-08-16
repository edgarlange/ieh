# Crear redes virtuales
resource "azurerm_virtual_network" "vnet" {
  provider            = azurerm.LANGE_4
  name                = "${var.prefix}-network"
  location            = azurerm_resource_group.ieh_rg.location
  resource_group_name = azurerm_resource_group.ieh_rg.name
  address_space       = var.vnet
}
resource "azurerm_virtual_network" "vnet_l3" {
  provider            = azurerm.LANGE_3
  name                = "${var.prefix}-network"
  location            = azurerm_resource_group.ieh_rg_l3.location
  resource_group_name = azurerm_resource_group.ieh_rg_l3.name
  address_space       = var.vnet_l3
}
# Crear sub-redes
resource "azurerm_subnet" "db_subnet" {
  provider             = azurerm.LANGE_4
  name                 = "AzureDataBaseSubnet"
  resource_group_name  = azurerm_resource_group.ieh_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.db_subnet
}
resource "azurerm_subnet" "vm_l3_subnet" {
  provider             = azurerm.LANGE_3
  name                 = "AzureVMSubnet"
  resource_group_name  = azurerm_resource_group.ieh_rg_l3.name
  virtual_network_name = azurerm_virtual_network.vnet_l3.name
  address_prefixes     = var.vm_l3_subnet
}
resource "azurerm_subnet" "web_subnet" {
  provider             = azurerm.LANGE_4
  name                 = "WEBAppSubnet"
  resource_group_name  = azurerm_resource_group.ieh_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.web_subnet
  delegation {
    name = "delegation"
    service_delegation {
      name = "Microsoft.Web/serverFarms"
    }
  }
}
resource "azurerm_subnet" "powerbi_subnet" {
  provider             = azurerm.LANGE_4
  name                 = "PowerBISubnet"
  resource_group_name  = azurerm_resource_group.ieh_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.powerbi_subnet
  delegation {
    name = "delegation"
    service_delegation {
      name = "Microsoft.PowerPlatform/vnetaccesslinks"
    }
  }
}
# resource "azurerm_subnet" "fw_subnet" {
#   provider             = azurerm.LANGE_4
#   name                 = "AzureFirewallSubnet"
#   resource_group_name  = azurerm_resource_group.ieh_rg.name
#   virtual_network_name = azurerm_virtual_network.vnet.name
#   address_prefixes     = var.fw_subnet
# }
resource "azurerm_subnet" "ba_subnet" {
  provider             = azurerm.LANGE_3
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.ieh_rg_l3.name
  virtual_network_name = azurerm_virtual_network.vnet_l3.name
  address_prefixes     = var.ba_subnet

}
resource "azurerm_subnet" "vpn_subnet" {
  provider             = azurerm.LANGE_4
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.ieh_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.vpn_subnet
}
resource "azurerm_subnet" "vpn_subnet_l3" {
  provider             = azurerm.LANGE_3
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.ieh_rg_l3.name
  virtual_network_name = azurerm_virtual_network.vnet_l3.name
  address_prefixes     = var.vpn_subnet_l3
}
# Crear grupos de seguridad
resource "azurerm_network_security_group" "db" {
  provider            = azurerm.LANGE_4
  name                = "${var.prefix}-db-sg"
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.ieh_rg.name
  security_rule {
    name                       = "AllowAll"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
resource "azurerm_network_security_group" "vm_l3" {
  provider            = azurerm.LANGE_3
  name                = "${var.prefix}-vm-l3-sg"
  location            = azurerm_resource_group.ieh_rg_l3.location
  resource_group_name = azurerm_resource_group.ieh_rg_l3.name
  security_rule {
    name                       = "RDP"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "190.140.80.94"
    destination_address_prefix = "*"
  }
}
resource "azurerm_network_security_group" "web" {
  provider            = azurerm.LANGE_4
  name                = "${var.prefix}-web-sg"
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.ieh_rg.name
  security_rule {
    name                       = "AllowAll"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}