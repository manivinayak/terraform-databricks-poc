terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    databricks = {
      source = "databricks/databricks"
    }
  }
  backend "azurerm" {
    use_oidc = true
  }
}

# Required for the 'data' lookups to work
provider "azurerm" {
  features {} 
  use_oidc = true
}

# The Databricks provider configuration (host is passed in main.tf)
# No need to put 'host' here if you defined it in main.tf inside the provider "databricks" block
provider "databricks" {
  # host = data.azurerm_databricks_workspace.this.workspace_url
}