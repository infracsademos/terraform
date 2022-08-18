resource "azurerm_private_dns_zone" "azure_io" {
  name                = var.private_dns_zone_azure
  resource_group_name = azurerm_resource_group.dns_test.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_hub_001" {
  name                  = "link_vnet-hub-001"
  resource_group_name   = azurerm_resource_group.dns_test.name
  private_dns_zone_name = azurerm_private_dns_zone.azure_io.name
  virtual_network_id    = module.vnet_hub_001.id

  depends_on = [
    module.vnet_hub_001
  ]
}

resource "azurerm_private_dns_zone" "onprem_io" {
  name                = var.private_dns_zone_onprem
  resource_group_name = azurerm_resource_group.dns_test.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_onprem_001" {
  name                  = "link_vnet-onprem-001"
  resource_group_name   = azurerm_resource_group.dns_test.name
  private_dns_zone_name = azurerm_private_dns_zone.onprem_io.name
  virtual_network_id    = module.vnet_onprem_001.id

  depends_on = [
    module.vnet_onprem_001
  ]
}