module "bastion_hub_001" {
    source           = "./modules/bastion"
    rg_name          = azurerm_resource_group.dns_test.name
    location         = azurerm_resource_group.dns_test.location
    name             = local.bas_hub_001
    pip_name         = local.pip_bas_hub_001
    subnet_id        = module.snet_hub_001_bastion.id
}

module "bastion_spoke_001" {
    source           = "./modules/bastion"
    rg_name          = azurerm_resource_group.dns_test.name
    location         = azurerm_resource_group.dns_test.location
    name             = local.bas_spoke_001
    pip_name         = local.pip_bas_spoke_001
    subnet_id        = module.snet_spoke_001_bastion.id
}

module "bastion_onprem_001" {
    source           = "./modules/bastion"
    rg_name          = azurerm_resource_group.dns_test.name
    location         = azurerm_resource_group.dns_test.location
    name             = local.bas_onprem_001
    pip_name         = local.pip_bas_onprem_001
    subnet_id        = module.snet_onprem_001_bastion.id
}