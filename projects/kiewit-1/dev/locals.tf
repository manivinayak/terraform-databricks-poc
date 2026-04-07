locals {
  project_id     = "kiewit-1"
  env            = var.environment
  
  # This MUST match the naming logic used in your global-init/main.tf
  workspace_name = "kiewit-${local.env}-workspace"
  
  catalog_name   = "${local.project_id}_${local.env}_catalog"
  de_group       = "${local.project_id}-de-team"
}