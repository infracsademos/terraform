output "pip_address" {
    description = "IP address of VPN Gateway."
    value       = azurerm_public_ip.pip.ip_address
}

output "lgw_id" {
    description = "ID of VPN Gateway."
    value       = azurerm_local_network_gateway.local_gwy.id
}

output "vgw_id" {
    description = "ID of Local Network Gateway."
    value       = azurerm_virtual_network_gateway.vnet_gwy.id
}