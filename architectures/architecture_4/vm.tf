//Create a network interface
resource "azurerm_network_interface" "nic_windows_vm" {
  name                = "windows-vm-nic"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "windows_vm_nic_configuration"
    subnet_id                     = azurerm_subnet.snet_vms.id
    private_ip_address_allocation = "Dynamic"
  }
}


# Create virtual machine
resource "azurerm_windows_virtual_machine" "main" {
  name                  = "windows-vm"
  admin_username        = "azureuser"
  admin_password        = "DasIsteinTest123Passwort!"
  location              = var.resource_group_location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic_windows_vm.id]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "myOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }
}