locals {
  project_id   = "kiewit-1"
  
  # Dynamic names based on project ID and environment
  catalog_name = "${replace(local.project_id, "-", "_")}_${var.environment}_catalog"
  de_group     = "${local.project_id}-de-team"
  
  # Matches the storage naming logic in your azure_infra module
  # Result: "stkiewitdevunity"
  storage_account_name = "stkiewit${var.environment}unity"
}