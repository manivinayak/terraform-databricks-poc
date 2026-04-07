variable "resource_group" {
  type        = string
  description = "The name of the resource group created in global-int"
}

variable "location" {
  type        = string
}

variable "environment" {
  type        = string
}

# Networking CIDRs (Required if your Data Sources use them for lookup)
variable "vnet_cidr" {
  type = string
}

variable "public_subnet_cidr" {
  type = string
}

variable "private_subnet_cidr" {
  type = string
}