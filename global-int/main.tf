data "azurerm_client_config" "current" {}

# 1. Network Module Call
module "network" {
  source              = "../modules/networking"
  prefix              = "kiewit-${var.environment}"
  rg_name             = var.resource_group
  location            = var.location
  vnet_cidr           = var.vnet_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

# 2. Key Vault
resource "azurerm_key_vault" "this" {
  name                = "kv-kiewit-${var.environment}-001"
  location            = var.location
  resource_group_name = var.resource_group
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
  purge_protection_enabled = false 
}

# 3. Base Infrastructure Module Call
module "base_infra" {
  source         = "../modules/azure_infra"
  prefix         = "kiewit-${var.environment}"
  rg_name        = var.resource_group
  location       = var.location
  vnet_id        = module.network.vnet_id
  public_subnet  = module.network.public_subnet_name
  private_subnet = module.network.private_subnet_name
}