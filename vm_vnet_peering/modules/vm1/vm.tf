#----------------------------------------------------------------------------
# Create VM
#----------------------------------------------------------------------------
resource "azurerm_linux_virtual_machine" "vm1" {
  name                = "vm1"
  location              = azurerm_resource_group.rg_vm_1.location
  resource_group_name   = azurerm_resource_group.rg_vm_1.name
  size                = "Standard_F2"
  admin_username      = "vm1user"
  network_interface_ids = [
    azurerm_network_interface.nic_vm_1.id,
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
    sku       = "16.04-LTS"
    version   = "latest"
  }
}


#----------------------------------------------------------------------------
# Create public ip (vm-1)
#----------------------------------------------------------------------------
resource "azurerm_public_ip" "pip_vm_1" {
    name                         = "pip-vm-1"
    location                     = "eastus"
    resource_group_name          = azurerm_resource_group.rg_vm_1.name
    allocation_method            = "Dynamic"
}


#----------------------------------------------------------------------------
# Create nic (vm-1)
#----------------------------------------------------------------------------
resource "azurerm_network_interface" "nic_vm_1" {
  name                = "nic-vm-1"
  location            = azurerm_resource_group.rg_vm_1.location
  resource_group_name = azurerm_resource_group.rg_vm_1.name

  ip_configuration {
    name                          = "ipconfig-vm-1"
    subnet_id                     = azurerm_subnet.snet_vm_1_01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip_vm_1.id
  }
}