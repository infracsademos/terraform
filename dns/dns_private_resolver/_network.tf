#######################################################################
#           HUB VNET RESOURCES
#######################################################################

module "vnet_hub" {
    source          = "./modules/vnet"

    rg_name         = azurerm_resource_group.dns_test.name
    location        = azurerm_resource_group.dns_test.location

    vnet_name       = "vnet-hub"
    nsg_name        = "nsg-hub"
    
    address_space   = ["10.1.0.0/16"]
}

module "snet_hub_default" {
    source          = "./modules/subnet"
    rg_name         = azurerm_resource_group.dns_test.name
    name            = "default"
    vnet_name       = module.vnet_hub.vnet_name
    address_space   = ["10.1.0.0/24"]
}

module "snet_hub_dns_resolver_inbound" {
    source          = "./modules/subnet"
    rg_name         = azurerm_resource_group.dns_test.name
    name            = "snet-hub-dns-resolver-inbound"
    vnet_name       = module.vnet_hub.vnet_name
    address_space   = ["10.1.1.0/28"]
}

module "snet_hub_dns_resolver_outbound" {
    source          = "./modules/subnet"
    rg_name         = azurerm_resource_group.dns_test.name
    name            = "snet-hub-dns-resolver-outbound"
    vnet_name       = module.vnet_hub.vnet_name
    address_space   = ["10.1.2.0/28"]
}

module "snet_hub_gateway" {
    source          = "./modules/subnet"
    rg_name         = azurerm_resource_group.dns_test.name
    name            = "GatewaySubnet"
    vnet_name       = module.vnet_hub.vnet_name
    address_space   = ["10.1.3.0/24"]
}