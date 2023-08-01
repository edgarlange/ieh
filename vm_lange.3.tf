resource "azurerm_network_interface" "main" {
  provider            = azurerm.LANGE_3
  name                = "${var.prefix}-nic"
  location            = azurerm_resource_group.ieh_rg_l3.location
  resource_group_name = azurerm_resource_group.ieh_rg_l3.name

  ip_configuration {
    name                          = "iehconfiguration0"
    subnet_id                     = azurerm_subnet.vm_l3_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "temp" {
  provider                         = azurerm.LANGE_3
  name                             = "${var.prefix}-vm"
  location                         = azurerm_resource_group.ieh_rg_l3.location
  resource_group_name              = azurerm_resource_group.ieh_rg_l3.name
  network_interface_ids            = [azurerm_network_interface.main.id]
  vm_size                          = "Standard_DS2_v2"
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true


  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter"
    version   = "latest"
  }
  storage_os_disk {
    name              = "${var.prefix}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "${var.prefix}-test"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_windows_config {
    timezone = "SA Pacific Standard Time"
    provision_vm_agent = true
  }
}

resource "azurerm_virtual_machine_extension" "userdata" {
  provider                  = azurerm.LANGE_3
  name                 = "${var.prefix}-vm"
  virtual_machine_id   = azurerm_virtual_machine.temp.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
        "fileUris": ["https://raw.githubusercontent.com/edgarlange/scripts/main/userdata.ps1"],
        "commandToExecute": "powershell.exe -ExecutionPolicy unrestricted -NoProfile -NonInteractive -File userdata.ps1"
    }
    SETTINGS
}

resource "azurerm_network_interface_security_group_association" "main" {
  provider                  = azurerm.LANGE_3
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.vm_l3.id
}