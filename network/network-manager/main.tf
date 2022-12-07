resource "azurerm_resource_group" "rg" {
    name        = local.rg_name
    location    = local.location_westeurope
}
