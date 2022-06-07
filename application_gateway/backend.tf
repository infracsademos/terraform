#----------------------------------------------------------------------------
# Create Backend VM
#----------------------------------------------------------------------------
resource "azurerm_linux_virtual_machine" "vm-backend" {
  name                = "vm-backend"
  location              = azurerm_resource_group.rg_apgw.location
  resource_group_name   = azurerm_resource_group.rg_apgw.name
  size                = "Standard_F2"
  admin_username      = "vm1user"
  network_interface_ids = [
    azurerm_network_interface.nic_vm_backend.id,
  ]

  admin_ssh_key {
    username   = "vm1user"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}


#----------------------------------------------------------------------------
# Create nic
#----------------------------------------------------------------------------
resource "azurerm_network_interface" "nic_vm_backend" {
  name                = "nic-vm-backend"
  location            = azurerm_resource_group.rg_apgw.location
  resource_group_name = azurerm_resource_group.rg_apgw.name

  ip_configuration {
    name                          = "ipconfig-vm-backend"
    subnet_id                     = azurerm_subnet.snet_backend.id
    private_ip_address_allocation = "Dynamic"
  }
}