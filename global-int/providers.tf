terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  backend "azurerm" {
    # Values for resource_group_name, storage_account_name, container_name, and key 
    # must be passed via the '-backend-config' flag in the GitHub Action.
    use_oidc = true
  }
}

provider "azurerm" {
  features {} # Required by AzureRM
  use_oidc = true
}