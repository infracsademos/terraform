resource "azurerm_linux_virtual_machine_scale_set" "nginx_vmss" {
  name                = "nginx-vmss"
  resource_group_name = var.rg_name
  location            = var.rg_location
  sku                 = "Standard_F2"
  instances           = 2
  admin_username      = "adminuser"

  custom_data = base64encode(file("./modules/apgw_vmss_backend/web.conf"))

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
      subnet_id = var.subnet_id
      application_gateway_backend_address_pool_ids = var.backend_address_pool_ids
      # application_gateway_backend_address_pool_ids = azurerm_application_gateway.apgw.backend_address_pool[*].id
    }
  }
}