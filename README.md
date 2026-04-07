.
├── modules/                          # Shared reusable logic
│   ├── databricks_workspace/          # For shared workspace config
│   └── unity_catalog/                 # For Catalogs/Schemas
├── projects/
│   ├── kiewit-1/                      # Project 1
│   │   ├── dev/
│   │   │   ├── main.tf               # Root for Kiewit-1 Dev
│   │   │   ├── locals.tf             # Kiewit-1 specific logic
│   │   │   ├── providers.tf          # Databricks provider config
│   │   │   └── terraform.tfvars      # Environment values
│   │   └── prod/
│   └── kiewit-2/                      # Project 2
│       ├── dev/
│       │   ├── main.tf               
│       │   ├── locals.tf             
│       │   ├── providers.tf          
│       │   └── terraform.tfvars      
└── global-init/                       # Global/Base infrastructure
    ├── main.tf                        # Root for global shared resources
    ├── locals.tf                      # Global naming conventions
    ├── providers.tf                   
    └── terraform.tfvars