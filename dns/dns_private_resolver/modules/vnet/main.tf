resource "azurerm_virtual_network" "vnet" {
    name                = var.vnet_name
    location            = var.location
    resource_group_name = var.rg_name
    address_space       = var.address_space

    tags                = var.tags
}

resource "azurerm_network_security_group" "vnet_nsg" {
    name                = var.nsg_name
    location            = var.location
    resource_group_name = var.rg_name
}