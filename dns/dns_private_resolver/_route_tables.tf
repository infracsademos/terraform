module "rt_spoke" {
  source = "./modules/route_tables"
    rt_name = "rt-001"
    route_name = "route-001"
    rg_name = azurerm_resource_group.dns_test.name
    location = azurerm_resource_group.dns_test.location
    address_prefix = "0.0.0.0/0"
    next_hop_type = "VirtualAppliance"
    next_hop_in_ip_address = module.firewall.firewall_private_ip
    subnet_id = module.snet_spoke_001_default.id
    route_table_id = module.rt_spoke.rt_id
}