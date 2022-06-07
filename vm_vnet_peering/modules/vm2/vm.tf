#----------------------------------------------------------------------------
# Create VM
#----------------------------------------------------------------------------
resource "azurerm_linux_virtual_machine" "vm2" {
  name                = "vm2"
  location              = azurerm_resource_group.rg_vm_2.location
  resource_group_name   = azurerm_resource_group.rg_vm_2.name
  size                = "Standard_F2"
  admin_username      = "vm2user"
  network_interface_ids = [
    azurerm_network_interface.nic_vm_2.id,
  ]

  admin_ssh_key {
    username   = "vm2user"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}


#----------------------------------------------------------------------------
# Create nic (vm-2)
#----------------------------------------------------------------------------
resource "azurerm_network_interface" "nic_vm_2" {
  name                = "nic-vm-1"
  location            = azurerm_resource_group.rg_vm_2.location
  resource_group_name = azurerm_resource_group.rg_vm_2.name

  ip_configuration {
    name                          = "ipconfig-vm-2"
    subnet_id                     = azurerm_subnet.snet_vm_2_01.id
    private_ip_address_allocation = "Dynamic"
  }
}