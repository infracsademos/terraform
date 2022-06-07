# -----------------------------------------------
# Create resource group
# -----------------------------------------------
resource "azurerm_resource_group" "rg_apgw" {
    name         = var.resource_group_name
    location     = var.resource_group_location
}