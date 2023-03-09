module "app_gateway" {
    source       = "./modules/app_gateway"
    rg_name      = local.rg_name
    rg_location  = local.location
    subnet_id    = module.snet_spoke_001_apgw.id

    depends_on = [
      module.vnet_spoke_001,
      module.snet_spoke_001_apgw
    ]
}
