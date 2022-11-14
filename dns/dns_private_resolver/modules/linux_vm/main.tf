
resource "azurerm_linux_virtual_machine" "vm-backend" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  size                  = "Standard_F2"
  admin_username        = var.vm_user
  network_interface_ids = [
    azurerm_network_interface.nic_vm_backend.id,
  ]

  admin_password                    = var.admin_password
  disable_password_authentication   = false

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


resource "azurerm_network_interface" "nic_vm_backend" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = var.ip_configuration_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}