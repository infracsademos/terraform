# -----------------------------------------------
# Create resource group
# -----------------------------------------------
resource "azurerm_resource_group" "rg_pe_demo" {
    name         = var.resource_group_name
    location     = var.resource_group_location
}