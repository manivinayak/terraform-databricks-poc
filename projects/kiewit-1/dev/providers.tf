terraform {
  required_providers {
    databricks = { source = "databricks/databricks" }
    azurerm    = { source = "hashicorp/azurerm" }
  }
  backend "azurerm" {
    use_oidc = true # Passwordless
  }
}

provider "databricks" {
  host = var.databricks_url # Passed from Global-Init output
}