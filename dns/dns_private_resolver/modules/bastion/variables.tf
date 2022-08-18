variable "name" {
    description = "Name of the Virtual Network Subnet."
    type        = string
}

variable "pip_name" {
    description = "Name of the Public IP Address."
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

variable "subnet_id" {
    description = "Subnet Identifier."  
    type        = string
}

variable "tags" {
    description = "Tags to set on the bucket."
    type        = map(string)
    default     = {}
}
