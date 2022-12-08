#----------------------------------------------------------------------------
# Create virtual network
#----------------------------------------------------------------------------
resource "azurerm_virtual_network" "vnet_westeu_01" {
  name                = "vnet-weust-01"
  resource_group_name = azurerm_resource_group.rg_apgw.name
  location            = azurerm_resource_group.rg_apgw.location
  address_space       = ["10.0.0.0/16"]

  depends_on = [azurerm_resource_group.rg_apgw]
}

#----------------------------------------------------------------------------
# Create subnet backend
#----------------------------------------------------------------------------
resource "azurerm_subnet" "snet_backend" {
  name                 = "snet-backend"
  resource_group_name  = azurerm_resource_group.rg_apgw.name
  virtual_network_name = azurerm_virtual_network.vnet_westeu_01.name
  address_prefixes     = ["10.0.0.0/24"] //254 IPs 

}


#----------------------------------------------------------------------------
# Create subnet application gateway
#----------------------------------------------------------------------------
resource "azurerm_subnet" "snet_apgw" {
  name                 = "snet-apgw"
  resource_group_name  = azurerm_resource_group.rg_apgw.name
  virtual_network_name = azurerm_virtual_network.vnet_westeu_01.name
  address_prefixes     = ["10.0.1.0/24"] //254 IPs 
}


#----------------------------------------------------------------------------
# Create NSG subnet backend
#----------------------------------------------------------------------------
resource "azurerm_network_security_group" "nsg_backend" {
  name                = "nsg-backend"
  location            = azurerm_resource_group.rg_apgw.location
  resource_group_name = azurerm_resource_group.rg_apgw.name

  security_rule {
    name                       = "healthProbe"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "snet_backend_nsg_association" {
  subnet_id                 = azurerm_subnet.snet_backend.id
  network_security_group_id = azurerm_network_security_group.nsg_backend.id
}
