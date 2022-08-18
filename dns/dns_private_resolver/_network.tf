#######################################################################
#           HUB_001 VNET RESOURCES
#######################################################################

module "vnet_hub_001" {
    source           = "./modules/vnet"
    rg_name          = azurerm_resource_group.dns_test.name
    location         = azurerm_resource_group.dns_test.location
    vnet_name        = local.vnet_hub_001   
    address_space    = local.as_hub_001_vnet
    peering          = true
    remote_vnet_id   = module.vnet_spoke_001.id
    remote_vnet_name = module.vnet_spoke_001.name
}

module "snet_hub_001_default" {
    source          = "./modules/subnet"
    rg_name         = azurerm_resource_group.dns_test.name
    location        = azurerm_resource_group.dns_test.location
    name            = local.snet_default
    vnet_name       = module.vnet_hub_001.name
    address_space   = local.as_hub_001_snet_default
    nsg             = true
}

module "snet_hub_001_pdns_resolver_inbound" {
    source          = "./modules/subnet"
    rg_name         = azurerm_resource_group.dns_test.name
    location        = azurerm_resource_group.dns_test.location
    name            = local.snet_pdre_i
    vnet_name       = module.vnet_hub_001.name
    address_space   = local.as_hub_001_snet_pdre_i
}

module "snet_hub_001_pdns_resolver_outbound" {
    source          = "./modules/subnet"
    rg_name         = azurerm_resource_group.dns_test.name
    location        = azurerm_resource_group.dns_test.location
    name            = local.snet_pdre_o
    vnet_name       = module.vnet_hub_001.name
    address_space   = local.as_hub_001_snet_pdre_o
}

module "snet_hub_001_gateway" {
    source          = "./modules/subnet"
    rg_name         = azurerm_resource_group.dns_test.name
    location        = azurerm_resource_group.dns_test.location
    name            = local.snet_gw
    vnet_name       = module.vnet_hub_001.name
    address_space   = local.as_hub_001_snet_gw
}

module "snet_hub_001_bastion" {
    source          = "./modules/subnet"
    rg_name         = azurerm_resource_group.dns_test.name
    location        = azurerm_resource_group.dns_test.location
    name            = local.snet_bastion
    vnet_name       = module.vnet_hub_001.name
    address_space   = local.as_hub_001_snet_bastion
}

#######################################################################
#           SPOKE_001 VNET RESOURCES
#######################################################################

module "vnet_spoke_001" {
    source           = "./modules/vnet"
    rg_name          = azurerm_resource_group.dns_test.name
    location         = azurerm_resource_group.dns_test.location
    vnet_name        = local.vnet_spoke_001
    address_space    = local.as_spoke_001_vnet
    peering          = true
    remote_vnet_id   = module.vnet_hub_001.id
    remote_vnet_name = module.vnet_hub_001.name
}

module "snet_spoke_001_default" {
    source          = "./modules/subnet"
    rg_name         = azurerm_resource_group.dns_test.name
    location        = azurerm_resource_group.dns_test.location
    name            = local.snet_default
    vnet_name       = module.vnet_spoke_001.name
    address_space   = local.as_spoke_001_snet_default
    nsg             = true
}

module "snet_spoke_001_bastion" {
    source          = "./modules/subnet"
    rg_name         = azurerm_resource_group.dns_test.name
    location        = azurerm_resource_group.dns_test.location
    name            = local.snet_bastion
    vnet_name       = module.vnet_spoke_001.name
    address_space   = local.as_spoke_001_snet_bastion
}

#######################################################################
#           ONPREM_001 VNET RESOURCES
#######################################################################

module "vnet_onprem_001" {
    source          = "./modules/vnet"
    rg_name         = azurerm_resource_group.dns_test.name
    location        = azurerm_resource_group.dns_test.location
    vnet_name       = local.vnet_onprem_001  
    address_space   = local.as_onprem_001_vnet
}

module "snet_onprem_default" {
    source          = "./modules/subnet"
    rg_name         = azurerm_resource_group.dns_test.name
    location        = azurerm_resource_group.dns_test.location
    name            = local.snet_default
    vnet_name       = module.vnet_onprem_001.name
    address_space   = local.as_onprem_001_snet_default
    nsg             = true
}

module "snet_onprem_gateway" {
    source          = "./modules/subnet"
    rg_name         = azurerm_resource_group.dns_test.name
    location        = azurerm_resource_group.dns_test.location
    name            = local.snet_gw
    vnet_name       = module.vnet_onprem_001.name
    address_space   = local.as_onprem_001_snet_gw
}

module "snet_onprem_bastion" {
    source          = "./modules/subnet"
    rg_name         = azurerm_resource_group.dns_test.name
    location        = azurerm_resource_group.dns_test.location
    name            = local.snet_bastion
    vnet_name       = module.vnet_onprem_001.name
    address_space   = local.as_onprem_001_snet_bastion
}
