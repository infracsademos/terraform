#----------------------------------------------------------------------------
# Create a virtual network within the resource group (vm-02)
#----------------------------------------------------------------------------
resource "azurerm_virtual_network" "vnet_vm_2_eastus_01" {
  name                = "vnet-vm-2-eastus-01"
  resource_group_name = azurerm_resource_group.rg_vm_2.name
  location            = azurerm_resource_group.rg_vm_2.location
  address_space       = ["10.0.0.0/24"]

  depends_on = [azurerm_resource_group.rg_vm_2]
}


#----------------------------------------------------------------------------
# Create subnet within the resource group (vm-2)
#----------------------------------------------------------------------------
resource "azurerm_subnet" "snet_vm_2_01" {
  name                 = "snet-vm-2-01"
  resource_group_name  = azurerm_resource_group.rg_vm_2.name
  virtual_network_name = azurerm_virtual_network.vnet_vm_2_eastus_01.name
  address_prefixes     = ["10.0.0.0/25"]

}


#----------------------------------------------------------------------------
# Create NSG (vm-2)
#----------------------------------------------------------------------------
resource "azurerm_network_security_group" "nsg_vm_2" {
  name                = "nsg-vm-2"
  location            = azurerm_resource_group.rg_vm_2.location
  resource_group_name = azurerm_resource_group.rg_vm_2.name

  security_rule {
    name                       = "ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

#----------------------------------------------------------------------------
# Assigne NSG to subnet (vm-2)
#----------------------------------------------------------------------------
resource "azurerm_subnet_network_security_group_association" "nsga_vm_2" {
  subnet_id                 =  azurerm_subnet.snet_vm_2_01.id
  network_security_group_id =  azurerm_network_security_group.nsg_vm_2.id
}

#----------------------------------------------------------------------------
# VNET Peering vnet-vm2 - vnet-vm-1
#----------------------------------------------------------------------------
resource "azurerm_virtual_network_peering" "vnet1_to_vnet2" {
  name                      = "peer2to1"
  resource_group_name       = azurerm_resource_group.rg_vm_2.name
  virtual_network_name      = azurerm_virtual_network.vnet_vm_2_eastus_01.name
  remote_virtual_network_id = var.remote_vnet_id
}