output "subnet_name" {
    description = "Name of the Virtual Network Subnet"
    value       = azurerm_subnet.subnet.name
}