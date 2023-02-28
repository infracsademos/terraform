resource "azurerm_linux_virtual_machine_scale_set" "nginx_vmss" {
  name                = "nginx-vmss"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  sku                 = "Standard_F2"
  instances           = 2
  admin_username      = "adminuser"

  custom_data = base64encode(file("web.conf"))

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }


  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "example"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.snet_backend.id
      application_gateway_backend_address_pool_ids = azurerm_application_gateway.apgw.backend_address_pool[*].id
    }
  }
}


