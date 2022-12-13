# -----------------------------------------------
# Create resource group vm-2
# -----------------------------------------------
resource "azurerm_resource_group" "rg_vm_2" {
  name       =    var.resource_group_name_vm2
  location   =    var.resource_group_location
}
