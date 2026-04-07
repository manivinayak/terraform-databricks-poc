# 1. Managed Identity Credential
resource "databricks_storage_credential" "external" {
  name = "unity-storage-credential"
  azure_managed_identity {
    access_connector_id = var.access_connector_id
  }
}

# 2. Create External Locations for Bronze, Silver, and Gold
resource "databricks_external_location" "layers" {
  for_each        = toset(["bronze", "silver", "gold"])
  name            = "${var.project_id}-${each.key}-location"
  url             = "abfss://${each.key}@${var.storage_account_name}.dfs.core.windows.net/"
  credential_name = databricks_storage_credential.external.id
  comment         = "${each.key} layer for ${var.project_id}"
}

# 3. Create the Project Catalog
resource "databricks_catalog" "this" {
  name    = var.catalog_name
  comment = "Medallion architecture catalog for ${var.project_id}"
}

# 4. Create Schemas inside the Catalog that map to the layers
resource "databricks_schema" "medallion" {
  for_each     = toset(["bronze", "silver", "gold"])
  catalog_name = databricks_catalog.this.id
  name         = each.key
  # This logically links the Schema to the External Location
  storage_root = databricks_external_location.layers[each.key].url
}

# 5. Grant Permissions to DE Team
resource "databricks_grant" "de_team" {
  catalog    = databricks_catalog.this.name
  principal  = var.de_group
  privileges = ["ALL_PRIVILEGES"]
}