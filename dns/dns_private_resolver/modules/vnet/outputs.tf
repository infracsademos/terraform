output "name" {
    description = "Name of the Virtual Network"
    value       = azurerm_virtual_network.vnet.name
}

output "id" {
    description = "Id of the Virtual Network"
    value       = azurerm_virtual_network.vnet.id
}

output "address_space" {
    description = "Address space of the Virtual Network"
    value       = azurerm_virtual_network.vnet.address_space
}