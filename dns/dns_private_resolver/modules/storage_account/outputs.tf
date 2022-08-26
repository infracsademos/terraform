output "blob_endpoint" {
    value = azurerm_storage_account.storage_account.primary_blob_endpoint
}

output "sas_url_query_string" {
  value = data.azurerm_storage_account_sas.sas_token.sas
}