module "network_manager" {
    source                  = "./modules/network-manager"
    rg_id                   = azurerm_resource_group.rg.id
    location                = azurerm_resource_group.rg.location
    name                    = local.avnm_name   
    network_group_name_01   = local.network_group_name_01
    network_group_name_02   = local.network_group_name_02
    subscription_id         = local.subscription_id
}