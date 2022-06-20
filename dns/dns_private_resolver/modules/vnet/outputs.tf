output "vnet_name" {
    description = "Name of the Virtual Network"
    value       = azurerm_virtual_network.vnet.name
}

output "nsg_id" {
    description = "Identifier of the Network Security Group"
    value       = azurerm_network_security_group.vnet_nsg.id
}