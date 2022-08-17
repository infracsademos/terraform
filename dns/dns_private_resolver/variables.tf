variable "private_dns_zone_azure" {
    description = "Name of Azure Private DNS Zone."
    type        = string
    default     = "azure.mydns.io" 
}

variable "private_dns_zone_onprem" {
    description = "Name of Azure Private DNS Zone."
    type        = string
    default     = "onprem.mydns.io" 
}

variable "vpn_psk" {
    description = "Shared key for encryption."
    type        = string
    default     = "AnneLieseBraun"
    sensitive   = true
}
