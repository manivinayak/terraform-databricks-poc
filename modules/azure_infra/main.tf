# 1. ADLS Gen2 Storage Account
resource "azurerm_storage_account" "unity" {
  name                     = "st${replace(var.prefix, "-", "")}unity"
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true
}

# 2. Medallion Layer Containers (Bronze, Silver, Gold)
resource "azurerm_storage_data_lake_gen2_filesystem" "layers" {
  for_each           = toset(["bronze", "silver", "gold"])
  name               = each.key
  storage_account_id = azurerm_storage_account.unity.id
}

# 3. Access Connector (Identity for Unity Catalog)
resource "azurerm_databricks_access_connector" "unity" {
  name                = "${var.prefix}-connector"
  resource_group_name = var.rg_name
  location            = var.location
  identity { type = "SystemAssigned" }
}

# 4. Role Assignment (Allows Passwordless Access)
resource "azurerm_role_assignment" "unity_data" {
  scope                = azurerm_storage_account.unity.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_databricks_access_connector.unity.identity[0].principal_id
}

# 5. Databricks Workspace with VNet Injection
resource "azurerm_databricks_workspace" "this" {
  name                = "${var.prefix}-workspace"
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = "premium"

  custom_parameters {
    no_public_ip        = true
    virtual_network_id  = var.vnet_id
    public_subnet_name  = var.public_subnet
    private_subnet_name = var.private_subnet
    
    # REQUIRED BY AZURE: The NSG Association IDs
    public_subnet_network_security_group_association_id  = var.public_subnet_nsg_association_id
    private_subnet_network_security_group_association_id = var.private_subnet_nsg_association_id
  }
}