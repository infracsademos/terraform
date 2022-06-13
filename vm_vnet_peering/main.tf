module "vm1" {
    source = "./modules/vm1"

    remote_vnet_id = module.vm2.vnet_id

}


module "vm2" {
    source = "./modules/vm2"

    remote_vnet_id = module.vm1.vnet_id
}

