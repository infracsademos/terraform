resource "azurerm_virtual_network" "vnet_aks_demo" {
  name                = "vnet-aks-demo"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/8"]

  depends_on = [ 
    azurerm_resource_group.rg-aks-demo
   ]
}

resource "azurerm_subnet" "aks-default" {
  name                 = "subnet-aks-default"
  virtual_network_name = azurerm_virtual_network.vnet_aks_demo.name
  resource_group_name  = var.resource_group_name
  address_prefixes     = ["10.1.0.0/16"]
}

resource "azurerm_subnet" "subnet_bastion_host" {
  name                 = "AzureBastionSubnet"
  virtual_network_name = azurerm_virtual_network.vnet_aks_demo.name
  resource_group_name  = var.resource_group_name
  address_prefixes     = ["10.2.0.0/16"]
}