resource "azurerm_subnet" "subnet" {
    name                 = var.name
    resource_group_name  = var.rg_name
    virtual_network_name = var.vnet_name
    address_prefixes     = var.address_space
}


resource "azurerm_network_security_group" "snet_nsg" {
    count               = var.nsg ? 1 : 0
    name                = "nsg-${var.vnet_name}-${azurerm_subnet.subnet.name}"
    location            = var.location
    resource_group_name = var.rg_name
}


resource "azurerm_subnet_network_security_group_association" "nsg_association" {
    count                     = var.nsg ? 1 : 0
    subnet_id                 = azurerm_subnet.subnet.id
    network_security_group_id = azurerm_network_security_group.snet_nsg[count.index].id
}