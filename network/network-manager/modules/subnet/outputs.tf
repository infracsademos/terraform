output "name" {
    description = "Name of the Virtual Network Subnet"
    value       = azurerm_subnet.subnet.name
}

output "id" {
    description = "Id of the Virtual Network Subnet"
    value       = azurerm_subnet.subnet.id
}