locals {
  org      = "kiewit"
  env      = var.environment
  prefix   = "${local.org}-${local.env}"
  # Storage names must be globally unique and alphanumeric only
  st_name  = "st${local.org}${local.env}platform" 
}