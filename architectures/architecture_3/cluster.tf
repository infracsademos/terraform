resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "aks-cluster"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  dns_prefix          = "mkutscher"

  enable_auto_scaling = true
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Demo"
  }

  depends_on = [
    azurerm_log_analytics_workspace.log_analytics_workspace,
    azurerm_resource_group.rg-aks-demo
  ]
}
