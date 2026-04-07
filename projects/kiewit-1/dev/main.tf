# 1. DISCOVERY: Find the workspace created by the global-int team
data "azurerm_databricks_workspace" "this" {
  # Dynamically built: "kiewit-dev-workspace"
  name                = "kiewit-${var.environment}-workspace"
  resource_group_name = var.resource_group
}

# 2. DISCOVERY: Find the Access Connector (Managed Identity)
data "azurerm_databricks_access_connector" "this" {
  # Dynamically built: "kiewit-dev-connector"
  name                = "kiewit-${var.environment}-connector"
  resource_group_name = var.resource_group
}

# 3. PROVIDER: Authenticate to the specific workspace found above
provider "databricks" {
  host = data.azurerm_databricks_workspace.this.workspace_url
}

# 4. MODULE CALL: Configure Unity Catalog and Medallion Layers
module "unity_setup" {
  source               = "../../../modules/unity_catalog"
  
  # Using local variables for clean, non-hardcoded management
  project_id           = local.project_id
  catalog_name         = local.catalog_name
  de_group             = local.de_group
  
  # Passing discovered IDs and dynamic storage names
  access_connector_id  = data.azurerm_databricks_access_connector.this.id
  storage_account_name = local.storage_account_name
}