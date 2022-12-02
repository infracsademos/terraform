module "vnet_hub_001" {
    source          = "./modules/virtual-network"
    rg_name         = azurerm_resource_group.rg.name
    location        = azurerm_resource_group.rg.location
    name            = local.vnet_hub_001_name   
    address_space   = local.vnet_hub_001_range
}

module "snet_hub_001_01" {
    source          = "./modules/subnet"
    rg_name         = azurerm_resource_group.rg.name
    location        = azurerm_resource_group.rg.location
    name            = local.snet_hub_001_name
    vnet_name       = module.vnet_hub_001.name
    address_space   = local.snet_hub_001_range
}


module "vnet_spoke" {
    source          = "./modules/virtual-network"  
    count           = length(local.vnet_spoke_list)
    rg_name         = azurerm_resource_group.rg.name
    location        = local.vnet_spoke_list[count.index].location
    name            = local.vnet_spoke_list[count.index].vnet_name
    address_space   = local.vnet_spoke_list[count.index].vnet_range
}

module "snet_spoke_001" {
    source          = "./modules/subnet"
    count           = length(local.vnet_spoke_list)
    rg_name         = azurerm_resource_group.rg.name
    location        = local.vnet_spoke_list[count.index].location
    name            = local.vnet_spoke_list[count.index].snet_name
    vnet_name       = local.vnet_spoke_list[count.index].vnet_name
    address_space   = local.vnet_spoke_list[count.index].snet_range

    depends_on = [
        module.vnet_spoke
    ]
}

