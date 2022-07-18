resource "azurerm_virtual_network" "vnet" {
    name                = var.vnet_name
    location            = var.location
    resource_group_name = var.rg_name
    address_space       = var.address_space

    tags                = var.tags
}

resource "azurerm_virtual_network_peering" "peering" {
    count                     = var.peering ? 1 : 0
    name                      = "peering-${azurerm_virtual_network.vnet.name}-${var.remote_vnet_name}"
    resource_group_name       = var.rg_name
    virtual_network_name      = azurerm_virtual_network.vnet.name
    remote_virtual_network_id = var.remote_vnet_id
}
