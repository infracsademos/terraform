resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "aks-cluster"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  dns_prefix          = "mkutscher"
  node_resource_group = "rg-aks-cluster-nodes"

  default_node_pool {
    name                  = "default"
    enable_node_public_ip = false
    node_count            = 2
    vm_size               = "Standard_D2_v2"
    vnet_subnet_id        = azurerm_subnet.aks-default.id
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id
  }

  azure_policy_enabled = true

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin     = "azure"
    load_balancer_sku  = "standard"
  }

  tags = {
    Environment = "Demo"
  }

  depends_on = [
    azurerm_log_analytics_workspace.log_analytics_workspace,
    azurerm_resource_group.rg-aks-demo,
    azurerm_virtual_network.vnet_aks_demo
  ]
}
