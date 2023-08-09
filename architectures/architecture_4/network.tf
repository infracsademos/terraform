#----------------------------------------------------------------------------
# Create virtual network
#----------------------------------------------------------------------------
resource "azurerm_virtual_network" "vnet_westeu_01" {
  name                = "vnet-weust-01"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  address_space       = ["10.0.0.0/16"]

  depends_on = [azurerm_resource_group.rg_pe_demo]
}

#----------------------------------------------------------------------------
# Create subnet VMs
#----------------------------------------------------------------------------
resource "azurerm_subnet" "snet_vms" {
  name                 = "snet-vms"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet_westeu_01.name
  address_prefixes     = ["10.0.0.0/24"] //254 IPs 

}

#----------------------------------------------------------------------------
# Create subnet private endpoints
#----------------------------------------------------------------------------
resource "azurerm_subnet" "snet_pe" {
  name                 = "snet-pe"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet_westeu_01.name
  address_prefixes     = ["10.0.1.0/24"] //254 IPs 

}


#----------------------------------------------------------------------------
# Create subnet private endpoints
#----------------------------------------------------------------------------
resource "azurerm_subnet" "snet_bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet_westeu_01.name
  address_prefixes     = ["10.0.2.0/24"]
}