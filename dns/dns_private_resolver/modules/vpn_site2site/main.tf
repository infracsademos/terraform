resource "azurerm_public_ip" "pip" {
    name                = "pip-${var.vnet_gwy_name}"
    location            = var.location
    resource_group_name = var.rg_name

    allocation_method   = "Dynamic"
}

resource "azurerm_local_network_gateway" "local_gwy" {
    name                = var.peer_vpn_gateway
    location            = var.location
    resource_group_name = var.rg_name
    gateway_address     = azurerm_public_ip.pip.ip_address
    address_space       = var.peer_subnet_address_spaces

    depends_on = [
      azurerm_public_ip.pip
    ]
}

resource "azurerm_virtual_network_gateway" "vnet_gwy" {
    name                            = var.vnet_gwy_name
    location                        = var.location
    resource_group_name             = var.rg_name

    type                            = "Vpn"
    vpn_type                        = "RouteBased"

    active_active                   = false
    enable_bgp                      = false
    sku                             = "VpnGw2"

    ip_configuration {
        name                          = "pip-${var.vnet_gwy_name}"
        public_ip_address_id          = azurerm_public_ip.pip.id
        private_ip_address_allocation = "Dynamic"
        subnet_id                     = var.subnet_id
    }
}
