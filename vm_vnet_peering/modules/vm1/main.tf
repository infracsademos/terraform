# -----------------------------------------------
# Create resource group vm-1
# -----------------------------------------------
resource "azurerm_resource_group" "rg_vm_1" {
    name         = var.resource_group_name_vm1
    location     = var.resource_group_location
}
