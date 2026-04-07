
data "azurerm_databricks_workspace" "this" {
  name                = "kiewit-${var.environment}-workspace"
  resource_group_name = var.resource_group
}

data "azurerm_databricks_access_connector" "this" {
  name                = "ext-access-connector"
  resource_group_name = var.resource_group
}

provider "databricks" {
  host = data.azurerm_databricks_workspace.this.workspace_url
}

module "unity_setup" {
  source               = "../../../modules/unity_catalog"
  project_id           = "kiewit-1"
  catalog_name         = "kiewit_1_dev_catalog"
  de_group             = "kiewit-1-de-team"
  access_connector_id  = data.azurerm_databricks_access_connector.this.id
  storage_account_name = "stkiewit${var.environment}unity"
}