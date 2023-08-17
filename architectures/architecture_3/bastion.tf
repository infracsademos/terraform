# Public IP Address
resource "azurerm_public_ip" "bastion" {
  name                = "pip-bastion"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}


# Azure Bastion Host
resource "azurerm_bastion_host" "bastion" {
  name                = "bastion-host"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.subnet_bastion_host.id
    public_ip_address_id = azurerm_public_ip.bastion.id
  }
}