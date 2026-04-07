variable "project_id" {
  type        = string
  description = "The ID of the project (e.g., kiewit-1)"
}

variable "catalog_name" {
  type        = string
  description = "The name of the Unity Catalog to create"
}

variable "de_group" {
  type        = string
  description = "The name of the Data Engineering group to grant access to"
}

variable "access_connector_id" {
  type        = string
  description = "The Azure Resource ID of the Databricks Access Connector"
}

variable "storage_account_name" {
  type        = string
  description = "The name of the ADLS Gen2 Storage Account for the external locations"
}