# -----------------------------------------------
# Create resource group
# -----------------------------------------------
resource "azurerm_resource_group" "rg-aks-demo" {
    name         = var.resource_group_name
    location     = var.resource_group_location
}


# -----------------------------------------------
# Create Log Anaytics Workspace
# -----------------------------------------------
resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
    name                = "la-aks-demo"
    location            = var.resource_group_location
    resource_group_name = var.resource_group_name
    sku                 = "PerGB2018"
    retention_in_days   = 30

    depends_on = [
      azurerm_resource_group.rg-aks-demo
    ]
}