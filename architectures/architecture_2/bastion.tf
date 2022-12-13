#----------------------------------------------------------------------------
# Bastion Host Subnet
#----------------------------------------------------------------------------
resource "azurerm_subnet" "snet_bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.rg_apgw.name
  virtual_network_name = azurerm_virtual_network.vnet_westeu_01.name
  address_prefixes     = ["10.0.2.0/27"]
}

#----------------------------------------------------------------------------
# Bastion Host public IP
#----------------------------------------------------------------------------
resource "azurerm_public_ip" "pip_bastion" {
  name                = "pip-bastion"
  location            = azurerm_resource_group.rg_apgw.location
  resource_group_name = azurerm_resource_group.rg_apgw.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

#----------------------------------------------------------------------------
# Bastion Host
#----------------------------------------------------------------------------
resource "azurerm_bastion_host" "bastion_host" {
  name                = "bh-apgw"
  location            = azurerm_resource_group.rg_apgw.location
  resource_group_name = azurerm_resource_group.rg_apgw.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.snet_bastion.id
    public_ip_address_id = azurerm_public_ip.pip_bastion.id
  }
}