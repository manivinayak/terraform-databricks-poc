data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "this" {
  name     = var.resource_group
  location = var.location
}

module "network" {
  source              = "../modules/networking"
  prefix              = "kiewit-${var.environment}"
  rg_name             = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  vnet_cidr           = var.vnet_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

resource "azurerm_key_vault" "this" {
  name                = "kv-kiewit-${var.environment}-001"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
  purge_protection_enabled = false 
}

module "base_infra" {
  source         = "../modules/azure_infra"
  prefix         = "kiewit-${var.environment}"
  rg_name        = azurerm_resource_group.this.name
  location       = azurerm_resource_group.this.location
  vnet_id        = module.network.vnet_id
  public_subnet  = module.network.public_subnet_name
  private_subnet = module.network.private_subnet_name
  
  # ADDED THESE TWO LINES
  public_subnet_nsg_association_id  = module.network.public_subnet_nsg_association_id
  private_subnet_nsg_association_id = module.network.private_subnet_nsg_association_id
}