variable "prefix" { type = string }
variable "rg_name" { type = string }
variable "location" { type = string }
variable "vnet_id" { type = string }
variable "public_subnet" { type = string }
variable "private_subnet" { type = string }

# New Variables to accept the NSG Association IDs
variable "public_subnet_nsg_association_id" { type = string }
variable "private_subnet_nsg_association_id" { type = string }