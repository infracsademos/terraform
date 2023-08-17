resource "azurerm_private_dns_zone" "pdns_zone_storage" {
    name                = "privatelink.blob.core.windows.net"
    resource_group_name = var.resource_group_name
}


// link dns zone to vnet
resource "azurerm_private_dns_zone_virtual_network_link" "pdns_zone_vnet_link" {
    name                  = "privatelink.blob.core.windows.net"
    resource_group_name   = var.resource_group_name
    private_dns_zone_name = azurerm_private_dns_zone.pdns_zone_storage.name
    virtual_network_id    = azurerm_virtual_network.vnet_westeu_01.id
    registration_enabled  = true

    depends_on = [ azurerm_private_dns_zone.pdns_zone_storage ]
}