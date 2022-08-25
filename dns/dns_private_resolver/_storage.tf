module "config_storage" {
    source      = "./modules/storage_account"
    location    = local.location
    rg_name     = local.rg_name
    name        = local.config_storage
}
