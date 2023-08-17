#----------------------------------------------------------------------------
# Bastion Host public IP
#----------------------------------------------------------------------------
resource "azurerm_public_ip" "pip_bastion" {
  name                = "pip-bastion"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  depends_on = [ azurerm_resource_group.rg_pe_demo ]
}

#----------------------------------------------------------------------------
# Bastion Host
#----------------------------------------------------------------------------
resource "azurerm_bastion_host" "bastion_host" {
  name                = "bh-apgw"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.snet_bastion.id
    public_ip_address_id = azurerm_public_ip.pip_bastion.id
  }
}