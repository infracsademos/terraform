module "vgw_hub_001" {
    source                      = "./modules/vpn_site2site"

    rg_name                     = azurerm_resource_group.dns_test.name
    location                    = azurerm_resource_group.dns_test.location

    vnet_gwy_name               = local.vgw_hub_001
    subnet_id                   = module.snet_hub_001_gateway.id

    peer_vpn_gateway            = local.lgw_hub_001
    peer_subnet_address_spaces  = module.vnet_hub_001.address_space
}

module "vgw_onprem_001" {
    source                      = "./modules/vpn_site2site"

    rg_name                     = azurerm_resource_group.dns_test.name
    location                    = azurerm_resource_group.dns_test.location

    vnet_gwy_name               = local.lgw_onprem_001
    subnet_id                   = module.snet_onprem_gateway.id

    peer_vpn_gateway            = local.lgw_onprem_001
    peer_subnet_address_spaces  = module.vnet_hub_001.address_space
}

resource "azurerm_virtual_network_gateway_connection" "vnet_gwy_con_hub2onprem" {
    name                       = "hub-onprem"
    location                   = azurerm_resource_group.dns_test.location
    resource_group_name        = azurerm_resource_group.dns_test.name
    type                       = "IPsec"
    virtual_network_gateway_id = module.vgw_hub_001.vgw_id
    local_network_gateway_id   = module.vgw_onprem_001.lgw_id
    shared_key                 = var.vpn_psk #-Provided at run time
}

resource "azurerm_virtual_network_gateway_connection" "vnet_gwy_con_onprem2hub" {
    name                       = "onprem-hub"
    location                   = azurerm_resource_group.dns_test.location
    resource_group_name        = azurerm_resource_group.dns_test.name
    type                       = "IPsec"
    virtual_network_gateway_id = module.vgw_onprem_001.vgw_id
    local_network_gateway_id   = module.vgw_hub_001.lgw_id
    shared_key                 = var.vpn_psk #-Provided at run time
}
