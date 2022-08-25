resource "random_string" "random" {
  length           = 4
  special          = true
  override_special = "/@£$"
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "${var.name}-${random_string.random}"
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "content" {  
    name                  = "content"  
    storage_account_name  = azurerm_storage_account.storage_account.name
    container_access_type = "private"
}

resource "azurerm_storage_blob" "bind" {  
    name                   = "name.conf.options"  
    storage_account_name   = azurerm_storage_account.storage_account.name
    storage_container_name = azurerm_storage_container.content.name
    type                   = "Block"  
    source                 = "../../utils/bind/named.config.options"
}