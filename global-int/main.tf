# Needed to get Tenant ID for Key Vault
data "azurerm_client_config" "current" {}

# 1. CREATE THE RESOURCE GROUP (This was missing!)
resource "azurerm_resource_group" "this" {
  name     = var.resource_group
  location = var.location
}

# 2. Create Networking First
module "network" {
  source              = "../modules/networking"
  prefix              = "kiewit-${var.environment}"
  
  # Using azurerm_resource_group.this.name forces Terraform to wait 
  # until the RG is created before running this module.
  rg_name             = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  
  vnet_cidr           = var.vnet_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

# 3. Create Key Vault
resource "azurerm_key_vault" "this" {
  name                = "kv-kiewit-${var.environment}-001"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
  
  # Suggested for POC to allow easy cleanup
  purge_protection_enabled = false 
}

# 4. Create Storage & Workspace (Passing Network IDs)
module "base_infra" {
  source         = "../modules/azure_infra"
  prefix         = "kiewit-${var.environment}"
  
  rg_name        = azurerm_resource_group.this.name
  location       = azurerm_resource_group.this.location
  
  vnet_id        = module.network.vnet_id
  public_subnet  = module.network.public_subnet_name
  private_subnet = module.network.private_subnet_name
}