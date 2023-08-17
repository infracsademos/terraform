output "backend_address_pool_ids" {
    value = azurerm_application_gateway.apgw.backend_address_pool[*].id
}