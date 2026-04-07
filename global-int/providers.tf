terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  backend "azurerm" {
    # resource_group_name, storage_account_name, and container_name 
    # are usually passed via -backend-config in GitHub Actions
    use_oidc = true
  }
}

# THIS IS THE BLOCK THAT WAS MISSING
provider "azurerm" {
  features {} # Required by the AzureRM provider
  use_oidc = true
}