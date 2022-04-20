resource "azurerm_virtual_network" "vnet-hub01" {
  address_space       = ["10.2.0.0/24"]
  location            = "eastus"
  name                = "vnet-hub01"
  resource_group_name = "rg-vwan"
  depends_on = [
    azurerm_virtual_network.vnet-hub01-spoke01,
    azurerm_virtual_network.vnet-hub01-spoke02,
  ]
}

resource "azurerm_virtual_network" "vnet-hub01-spoke01" {
  address_space       = ["10.2.2.0/24"]
  location            = "eastus"
  name                = "vnet-hub01-spoke"
  resource_group_name = "rg-vwan"
  depends_on = [
    azurerm_route_table.res-11,
    azurerm_virtual_network.vnet-hub01,
  ]
}

resource "azurerm_virtual_network" "vnet-hub01-spoke02" {
  address_space       = ["10.6.0.0/24"]
  location            = "eastus"
  name                = "vnet-hub01-spoke-new"
  resource_group_name = "rg-vwan"
  depends_on = [
    azurerm_route_table.res-11,
    azurerm_virtual_network.vnet-hub01,
  ]
}


resource "azurerm_subnet" "subnet-azurefirewall" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = "rg-vwan"
  virtual_network_name = "vnet-hub01"
  depends_on = [
    azurerm_virtual_network.vnet-hub01,
  ]
}

resource "azurerm_subnet" "subnet-hub01-default" {
  name                 = "subnet-hub01-default"
  resource_group_name  = "rg-vwan"
  virtual_network_name = "vnet-hub01"
  depends_on = [
    azurerm_virtual_network.vnet-hub01,
  ]
}







resource "azurerm_virtual_network_peering" "vnet-hub01-spoke02_to_vnet-hub01" {
  name                      = "vnet-hub01-spoke-new_vnet-hub01"
  remote_virtual_network_id = "/subscriptions/9f0a032d-81dc-4295-810f-21eb0327b0a1/resourceGroups/rg-vwan/providers/Microsoft.Network/virtualNetworks/vnet-hub01"
  resource_group_name       = "rg-vwan"
  virtual_network_name      = "vnet-hub01-spoke-new"
  depends_on = [
    azurerm_virtual_network.vnet-hub01-spoke02,
    azurerm_virtual_network.vnet-hub01,
  ]
}
resource "azurerm_virtual_network_peering" "vnet-hub01_to_vnet-hub01-spoke02" {
  name                      = "vnet-hub01_vnet-hub01-spoke-new"
  remote_virtual_network_id = "/subscriptions/9f0a032d-81dc-4295-810f-21eb0327b0a1/resourceGroups/rg-vwan/providers/Microsoft.Network/virtualNetworks/vnet-hub01-spoke-new"
  resource_group_name       = "rg-vwan"
  virtual_network_name      = "vnet-hub01"
  depends_on = [
    azurerm_virtual_network.vnet-hub01,
    azurerm_virtual_network.vnet-hub01-spoke02,
  ]
}



resource "azurerm_virtual_network_peering" "vnet-hub01-spoke01_to_vnet-hub01" {
  name                      = "vnet-hub01-spoke_vnet-hub01"
  remote_virtual_network_id = "/subscriptions/9f0a032d-81dc-4295-810f-21eb0327b0a1/resourceGroups/rg-vwan/providers/Microsoft.Network/virtualNetworks/vnet-hub01"
  resource_group_name       = "rg-vwan"
  virtual_network_name      = "vnet-hub01-spoke"
  depends_on = [
    azurerm_virtual_network.vnet-hub01-spoke01,
    azurerm_virtual_network.vnet-hub01,
  ]
}
resource "azurerm_virtual_network_peering" "vnet-hub01_to_vnet-hub01-spoke01" {
  name                      = "vnet-hub01_vnet-hub01-spoke"
  remote_virtual_network_id = "/subscriptions/9f0a032d-81dc-4295-810f-21eb0327b0a1/resourceGroups/rg-vwan/providers/Microsoft.Network/virtualNetworks/vnet-hub01-spoke"
  resource_group_name       = "rg-vwan"
  virtual_network_name      = "vnet-hub01"
  depends_on = [
    azurerm_virtual_network.vnet-hub01,
    azurerm_virtual_network.vnet-hub01-spoke01,
  ]
}