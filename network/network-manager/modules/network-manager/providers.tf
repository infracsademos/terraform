terraform {
    required_providers {
        azapi = {
            source  = "Azure/azapi"
            version = "=0.4.0"
        }
    }
}

provider "azapi" {
}
