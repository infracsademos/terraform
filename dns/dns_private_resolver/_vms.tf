#######################################################################
#           VM SPOKE
#######################################################################
module "vm_spoke" {
    source                  = "./modules/linux_vm"

    location                = local.location
    resource_group_name     = local.rg_name

    vm_name                 = "vm-spoke-${local.location}-001"
    nic_name                = "nic-spoke-${local.location}-001"
    ip_configuration_name   = "ip-config-spoke-${local.location}-001"
    subnet_id               = module.snet_spoke_001_default.id
}


#######################################################################
#           VM HUB
#######################################################################
module "vm_hub" {
    source                  = "./modules/linux_vm"

    location                = local.location
    resource_group_name     = local.rg_name

    vm_name                 = "vm-hub-${local.location}-001"
    nic_name                = "nic-hub-${local.location}-001"
    ip_configuration_name   = "ip-config-hub-${local.location}-001"
    subnet_id               = module.snet_hub_001_default.id
}


#######################################################################
#           VM ONPREM
#######################################################################
module "vm_onprem" {
    source                  = "./modules/linux_vm"

    location                = local.location
    resource_group_name     = local.rg_name

    vm_name                 = "vm-onprem-${local.location}-001"
    nic_name                = "nic-onprem-${local.location}-001"
    ip_configuration_name   = "ip-config-onprem-${local.location}-001"
    subnet_id               = module.snet_onprem_default.id
}
