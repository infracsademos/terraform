resource "random_integer" "random_integer" {
  min = 100
  max = 1000
}
  
resource "azurerm_storage_account" "storage_account" {
  name                     = "${var.name}${random_integer.random_integer.result}"
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
    source                 = "../../utils/bind/named.conf.options"

}


data "azurerm_storage_account_sas" "sas_token" {
  connection_string = azurerm_storage_account.storage_account.primary_connection_string
  https_only        = true
  signed_version    = "2017-07-29"

  resource_types {
    service   = false
    container = true
    object    = false
  }

  services {
    blob  = true
    queue = false
    table = false
    file  = false
  }

  start  = var.start
  expiry = var.expiry

  permissions {
    read    = true
    write   = true
    delete  = false
    list    = false
    add     = true
    create  = true
    update  = false
    process = false
    tag     = false
    filter  = false
  }

depends_on = [
  azurerm_storage_account.storage_account
]

}