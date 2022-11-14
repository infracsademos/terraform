resource "azurerm_resource_group" "dns_test" {
    name        = local.rg_name
    location    = local.location
}