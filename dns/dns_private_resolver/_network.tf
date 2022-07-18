#######################################################################
#           HUB VNET RESOURCES
#######################################################################

module "vnet_hub" {
    source           = "./modules/vnet"

    rg_name          = azurerm_resource_group.dns_test.name
    location         = azurerm_resource_group.dns_test.location

    vnet_name        = "vnet-hub"
    
    address_space    = ["10.1.0.0/16"]

    peering          = true
    remote_vnet_id   = module.vnet_spoke_1.vnet_id
    remote_vnet_name = module.vnet_spoke_1.vnet_name
}

module "snet_hub_default" {
    source          = "./modules/subnet"
    rg_name         = azurerm_resource_group.dns_test.name
    location        = azurerm_resource_group.dns_test.location
    name            = "default"
    vnet_name       = module.vnet_hub.vnet_name
    address_space   = ["10.1.0.0/24"]
    nsg             = true
}

module "snet_hub_dns_resolver_inbound" {
    source          = "./modules/subnet"
    rg_name         = azurerm_resource_group.dns_test.name
    location        = azurerm_resource_group.dns_test.location
    name            = "snet-hub-dns-resolver-inbound"
    vnet_name       = module.vnet_hub.vnet_name
    address_space   = ["10.1.1.0/28"]
}

module "snet_hub_dns_resolver_outbound" {
    source          = "./modules/subnet"
    rg_name         = azurerm_resource_group.dns_test.name
    location        = azurerm_resource_group.dns_test.location
    name            = "snet-hub-dns-resolver-outbound"
    vnet_name       = module.vnet_hub.vnet_name
    address_space   = ["10.1.2.0/28"]
}

module "snet_hub_gateway" {
    source          = "./modules/subnet"
    rg_name         = azurerm_resource_group.dns_test.name
    location        = azurerm_resource_group.dns_test.location
    name            = "GatewaySubnet"
    vnet_name       = module.vnet_hub.vnet_name
    address_space   = ["10.1.3.0/24"]
}

#######################################################################
#           SPOKE-1 VNET RESOURCES
#######################################################################

module "vnet_spoke_1" {
    source          = "./modules/vnet"

    rg_name         = azurerm_resource_group.dns_test.name
    location        = azurerm_resource_group.dns_test.location

    vnet_name       = "vnet-spoke-1"
    
    address_space   = ["10.3.0.0/16"]

    peering          = true
    remote_vnet_id   = module.vnet_hub.vnet_id
    remote_vnet_name = module.vnet_hub.vnet_name
}

module "snet_spoke_1_default" {
    source          = "./modules/subnet"
    rg_name         = azurerm_resource_group.dns_test.name
    location        = azurerm_resource_group.dns_test.location
    name            = "default"
    vnet_name       = module.vnet_spoke_1.vnet_name
    address_space   = ["10.3.0.0/24"]
    nsg             = true
}

#######################################################################
#           ON_PREM VNET RESOURCES
#######################################################################

module "vnet_onprem" {
    source          = "./modules/vnet"

    rg_name         = azurerm_resource_group.dns_test.name
    location        = azurerm_resource_group.dns_test.location

    vnet_name       = "vnet-onprem"
    
    address_space   = ["10.5.0.0/16"]
}

module "snet_onprem_default" {
    source          = "./modules/subnet"
    rg_name         = azurerm_resource_group.dns_test.name
    location        = azurerm_resource_group.dns_test.location
    name            = "default"
    vnet_name       = module.vnet_onprem.vnet_name
    address_space   = ["10.5.0.0/24"]
    nsg             = true
}

module "snet_onprem_gatewaysubnet" {
    source          = "./modules/subnet"
    rg_name         = azurerm_resource_group.dns_test.name
    location        = azurerm_resource_group.dns_test.location
    name            = "GatewaySubnet"
    vnet_name       = module.vnet_onprem.vnet_name
    address_space   = ["10.5.1.0/24"]
}

module "snet_onprem_bastion" {
    source          = "./modules/subnet"
    rg_name         = azurerm_resource_group.dns_test.name
    location        = azurerm_resource_group.dns_test.location
    name            = "AzureBastionSubnet"
    vnet_name       = module.vnet_onprem.vnet_name
    address_space   = ["10.5.2.0/26"]
}
