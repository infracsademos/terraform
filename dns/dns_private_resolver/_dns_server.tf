# module "dns_server_001" {
#     source = "./modules/dns_server_onprem"
    
#     location                = local.location
#     resource_group_name     = local.rg_name

#     vm_name                 = "vm-dns-server-${local.location}-001"
#     nic_name                = "nic-dns-server-${local.location}-001"
#     ip_configuration_name   = "ip-config-dns-server-${local.location}-001"
#     subnet_id               = module.snet_onprem_default.id

#     // file_endpoint           = "${module.config_storage.blob_endpoint}/content/named.conf.options${module.config_storage.sas_url_query_string}"
# }

# module "dns_server_002" {
#     source = "./modules/dns_server_onprem"
    
#     location                = local.location
#     resource_group_name     = local.rg_name

#     vm_name                 = "vm-dns-server-${local.location}-002"
#     nic_name                = "nic-dns-server-${local.location}-002"
#     ip_configuration_name   = "ip-config-dns-server-${local.location}-002"
#     subnet_id               = module.snet_onprem_default.id

#     // file_endpoint           = "${module.config_storage.blob_endpoint}/content/named.conf.options${module.config_storage.sas_url_query_string}"
# }