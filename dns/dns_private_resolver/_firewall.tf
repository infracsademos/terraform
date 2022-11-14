module "firewall" {
    source       = "./modules/firewall"
    rg_name      = azurerm_resource_group.dns_test.name
    location     = azurerm_resource_group.dns_test.location
    subnet_id    = module.snet_hub_001_firewall.id
}