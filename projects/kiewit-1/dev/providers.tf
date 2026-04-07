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

provider "azurerm" {
  features {} 
  use_oidc = true
}

# The Databricks provider uses the URL discovered in main.tf
provider "databricks" {}