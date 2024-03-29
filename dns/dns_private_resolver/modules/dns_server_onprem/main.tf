# data "azurerm_subscription" "current" {}

/* data "azurerm_role_definition" "contributor" {
  name = "Contributor"
} */
data "azurerm_shared_image" "image_gallery" {
  name                = "DNS-BIND-Server"
  gallery_name        = "csasharedimages"
  resource_group_name = "rg-shares-services" 
}

data "azurerm_shared_image_version" "bind_image" {
  name                = "0.0.2" # "recent" is also a tag to use the most recent image version
  image_name          = data.azurerm_shared_image.image_gallery.name
  gallery_name        = data.azurerm_shared_image.image_gallery.gallery_name
  resource_group_name = data.azurerm_shared_image.image_gallery.resource_group_name
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  size                  = "Standard_F2"
  admin_username        = var.vm_user
  network_interface_ids = [
    azurerm_network_interface.nic_vm.id,
  ]

  admin_password                    = var.admin_password
  disable_password_authentication   = false

  identity {
    type = "SystemAssigned"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_id = data.azurerm_shared_image_version.bind_image.id


}


resource "azurerm_network_interface" "nic_vm" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = var.ip_configuration_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

# resource "azurerm_virtual_machine_extension" "dns_config" {
#   name                 = "dnsconfig"
#   virtual_machine_id   = azurerm_linux_virtual_machine.vm.id
#   publisher            = "Microsoft.Azure.Extensions"
#   type                 = "CustomScript"
#   type_handler_version = "2.0"

#   settings = <<SETTINGS
#     {
#       "commandToExecute": "sudo rm /etc/bind/named.conf.options && sudo wget -P /etc/bind  -o named.conf.options"
#     }
# SETTINGS
# }

 
/* resource "azurerm_role_assignment" "role_assignment_vm" {
  scope              = data.azurerm_subscription.current.id
  role_definition_id = "${data.azurerm_subscription.current.id}${data.azurerm_role_definition.contributor.id}"
  principal_id       = azurerm_linux_virtual_machine.vm.identity[0].principal_id
} */