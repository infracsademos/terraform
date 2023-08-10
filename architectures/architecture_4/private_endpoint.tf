resource "azurerm_private_endpoint" "sa_pe" {
    name                = "pe-${azurerm_storage_account.storage.name}"
    location            = var.resource_group_location
    resource_group_name = var.resource_group_name
    subnet_id           = azurerm_subnet.snet_pe.id

    private_dns_zone_group {
        name                = "privatelink.blob.core.windows.net"
        private_dns_zone_ids = [azurerm_private_dns_zone.pdns_zone_storage.id]
    }
    
    private_service_connection {
        name                           = "sa-pe-connection"
        private_connection_resource_id = azurerm_storage_account.storage.id
        subresource_names              = ["blob"]
        is_manual_connection           = false
    
    }
    
    tags = {
        environment = "demo"
    }
  
}
