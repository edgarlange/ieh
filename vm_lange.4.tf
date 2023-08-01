# resource "azurerm_network_interface" "main" {
#   provider = azurerm.LANGE_4
#   name                = "${var.prefix}-nic"
#   location            = azurerm_resource_group.ieh_rg.location
#   resource_group_name = azurerm_resource_group.ieh_rg.name

#   ip_configuration {
#     name                          = "iehconfiguration0"
#     subnet_id                     = azurerm_subnet.db_subnet.id
#     private_ip_address_allocation = "Dynamic"
#   }
# }

# resource "azurerm_virtual_machine" "main" {
#   provider = azurerm.LANGE_4
#   name                  = "${var.prefix}-vm"
#   location              = azurerm_resource_group.ieh_rg.location
#   resource_group_name   = azurerm_resource_group.ieh_rg.name
#   network_interface_ids = [azurerm_network_interface.main.id]
#   vm_size               = "Standard_DS2_v2"

#   # Uncomment this line to delete the OS disk automatically when deleting the VM
#   delete_os_disk_on_termination = true

#   # Uncomment this line to delete the data disks automatically when deleting the VM
#   delete_data_disks_on_termination = true

#   storage_image_reference {
#     publisher = "MicrosoftWindowsServer"
#     offer     = "WindowsServer"
#     sku       = "2022-datacenter"
#     version   = "latest"
#   }
#   storage_os_disk {
#     name              = "${var.prefix}-osdisk"
#     caching           = "ReadWrite"
#     create_option     = "FromImage"
#     managed_disk_type = "Standard_LRS"
#   }
#   os_profile {
#     computer_name  = "${var.prefix}-test"
#     admin_username = "testadmin"
#     admin_password = "Password1234!"
#   }
#   os_profile_windows_config {
#     timezone = "SA Pacific Standard Time"
#   }
# }

# resource "azurerm_network_interface_security_group_association" "asoc_sg_ni" {
#   provider = azurerm.LANGE_4
#   network_interface_id      = azurerm_network_interface.main.id
#   network_security_group_id = azurerm_network_security_group.vm.id
# }

# # resource "tls_private_key" "example_ssh" {
# #   provider = azurerm.LANGE_4
# #   algorithm = "RSA"
# #   rsa_bits  = 4096
# # }