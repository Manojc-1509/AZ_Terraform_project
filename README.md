# Terraform Assessment – Multi-Environment Azure Infrastructure

This project demonstrates a complete **multi-environment Terraform setup** for Azure using:

- Shared infrastructure (ACR, shared RG)
- Environment-specific deployments (dev, staging, prod)
- Azure Storage–based remote state management
- Reusable Terraform modules
- Clean separation of state and configurations

This design follows **enterprise best practices** for Azure migration projects and fits directly into **Azure DevOps Pipelines**.

---

# 📁 Project Structure

Terraform-assessment/
│
├── env/
│ ├── shared/ # Central shared infrastructure
│ ├── dev/ # Development environment
│ ├── staging/ # Staging environment
│ └── prod/ # Production environment
│
├── modules/
│ ├── resource_group/ # Reusable RG module
│ ├── network/ # VNet, Subnets
│ ├── storage/ # Storage accounts & uploads
│ ├── acr/ # ACR (used only in shared)
│ └── app_service/ # App Service + Plan + Docker config
│
└── README.md

yaml
Copy code

---

# 🧱 Architecture Overview

### ✔ Shared Infrastructure
The **shared** folder deploys long-lived shared resources:

- `rg-shared-infra`
- Centralized Azure Container Registry (ACR)
- Shared outputs consumed by all environments

State file is stored at:

Terraform-statefiles/tfstate/shared/terraform.tfstate

markdown
Copy code

### ✔ Dev / Staging / Prod Environments

Each environment:
- Has its own backend (own state file)
- Deploys only its own resources
- Reads ACR info from shared using `terraform_remote_state`

Example state file layout:

tfstate/
├── shared/terraform.tfstate
├── dev/terraform.tfstate
├── staging/terraform.tfstate
└── prod/terraform.tfstate

yaml
Copy code

---

# 🔁 Remote State Consumption

Environments consume shared ACR outputs:

```hcl
data "terraform_remote_state" "shared" {
  backend = "azurerm"
  config = {
    resource_group_name  = "Terraform-statefiles"
    storage_account_name = "tfstatefiles1509"
    container_name       = "shared-tf-files"
    key                  = "shared/terraform.tfstate"
  }
}

acr_login_server = data.terraform_remote_state.shared.outputs.acr_login_server
acr_username     = data.terraform_remote_state.shared.outputs.acr_username
acr_password     = data.terraform_remote_state.shared.outputs.acr_password

<!-- ------------------------------------------------------- -->
🚀 How to Deploy

1️⃣ Deploy Shared Infrastructure First
bash
Copy code
cd env/shared
terraform init
terraform apply -var-file=shared.tfvars
This creates:

Shared RG

Centralized ACR

Outputs consumed by other environments

2️⃣ Deploy Dev Environment
bash
Copy code
cd env/dev
terraform init -reconfigure
terraform plan -var-file=dev.tfvars
terraform apply -var-file=dev.tfvars

3️⃣ Deploy Staging
bash
Copy code
cd env/staging
terraform init -reconfigure
terraform plan -var-file=staging.tfvars
terraform apply -var-file=staging.tfvars

4️⃣ Deploy Production
bash
Copy code
cd env/prod
terraform init -reconfigure
terraform plan -var-file=prod.tfvars
terraform apply -var-file=prod.tfvars

<!-- ----------------------------------------------------- -->
📦 Reusable Modules

resource_group module
Creates environment-specific resource groups.

network module
Deploys VNets, subnets, and networking components.

storage module
Deploys storage accounts + optional file upload via:

hcl
Copy code
source = "${path.module}/uploads/index.html"
acr module (shared-only)
Creates a centralized Azure Container Registry.

app_service module
Deploys App Service Plan + Linux Web App + Docker container configuration.

App Service uses centralized ACR via:

hcl
Copy code
docker_registry_url      = "https://${var.acr_login_server}"
docker_registry_username = var.acr_username
docker_registry_password = var.acr_password

<!-- ---------------------------------------------------------------- -->

🔐 Remote Backend Configuration (in each env)
Each environment has its own backend:

hcl
Copy code
terraform {
  backend "azurerm" {
    resource_group_name  = "Terraform-statefiles"
    storage_account_name = "tfstatefiles1509"
    container_name       = "shared-tf-files"
    key                  = "dev/terraform.tfstate"
  }
}
Only the key changes per environment:

dev/terraform.tfstate

staging/terraform.tfstate

prod/terraform.tfstate

<!-- ------------------------------------------------- -->
