module "apgw_vmss_backend" {
  source = "./modules/apgw_vmss_backend"
  rg_name = local.rg_name
  rg_location = local.location
  subnet_id = module.snet_spoke_001_default.id
  backend_address_pool_ids = module.app_gateway.backend_address_pool_ids
}
