# 1. DISCOVERY
data "azurerm_databricks_workspace" "this" {
  name                = "kiewit-${var.environment}-workspace"
  resource_group_name = var.resource_group
}

data "azurerm_databricks_access_connector" "this" {
  # This must match the name in azure_infra module: "${var.prefix}-connector"
  name                = "kiewit-${var.environment}-connector"
  resource_group_name = var.resource_group
}

# 2. CONTEXTUAL PROVIDER LOGIN
provider "databricks" {
  alias = "workspace"
  host  = data.azurerm_databricks_workspace.this.workspace_url
}

# 3. UNITY CATALOG SETUP
module "unity_setup" {
  source               = "../../../modules/unity_catalog"
  project_id           = local.project_id
  catalog_name         = local.catalog_name
  de_group             = local.de_group
  access_connector_id  = data.azurerm_databricks_access_connector.this.id
  storage_account_name = local.storage_account_name
  
  providers = {
    databricks = databricks.workspace
  }
}