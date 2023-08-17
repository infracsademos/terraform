// Storage account
resource "random_integer" "sa_random_id" {
  min = 1000
  max = 9999
}

resource "azurerm_storage_account" "storage" {
  name                     = "sa${random_integer.sa_random_id.result}"
  resource_group_name      = var.resource_group_name
  location                 = var.resource_group_location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  depends_on = [ azurerm_resource_group.rg_pe_demo ]
}

// Create a container
resource "azurerm_storage_container" "container" {
  name                  = "images"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "blob"

#   provisioner "local-exec" {
#     command = <<EOT
#        az storage blob upload -f ./test.txt -n ${azurerm.storage_account.storage.name} -c ${azurerm_storage_container.container.name}
#   EOT
#   }

    depends_on = [ azurerm_storage_account.storage ]
}

