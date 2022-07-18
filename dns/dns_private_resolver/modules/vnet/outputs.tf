output "vnet_name" {
    description = "Name of the Virtual Network"
    value       = azurerm_virtual_network.vnet.name
}

output "vnet_id" {
    description = "Id of the Virtual Network"
    value       = azurerm_virtual_network.vnet.id
}
