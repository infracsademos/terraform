resource "azurerm_subnet" "subnet" {
    name                 = var.name
    resource_group_name  = var.rg_name
    virtual_network_name = var.vnet_name
    address_prefixes     = var.address_space
}

resource "azurerm_subnet_network_security_group_association" "example" {
    count                     = var.nsg_association ? 1 : 0
    subnet_id                 = azurerm_subnet.subnet.id
    network_security_group_id = var.nsg_id
}