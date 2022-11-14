variable "vnet_name" {
    description = "Name of the Virtual Network."
    type        = string
}

variable "rg_name" {
    description = "Name of the Resource Group."
    type        = string
}

variable "location" {
    description = "Location of the Virtual Network."
    type        = string
}

variable "address_space" {
    description = "Address Space of Virtual Network."  
    type        = list(string)
}

variable "tags" {
    description = "Tags to set on the bucket."
    type        = map(string)
    default     = {}
}