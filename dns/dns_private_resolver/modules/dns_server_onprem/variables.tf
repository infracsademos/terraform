variable "vm_user" {
  description = "Username for the Virtual Machine."
  default     = "azueruser"
}

variable "vm_name" {
  description = "Name of the Virtual Machine."
}

variable "admin_password" {
  description = "Password for the Virtual Machine."
  default = "AzureRMpwd12345"
}

variable "location" {
  description = "Location of the Virtual Machine."
}

variable "resource_group_name" {
  description = "Name of the Resource Group."
}

variable "nic_name" {
  description = "Name of the Network Interface."
}

variable "ip_configuration_name" {
  description = "Name of the IP Configuration."
}

variable "subnet_id" {
  description = "Subnet ID of the Virtual Machine."
}