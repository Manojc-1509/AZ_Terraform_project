Terraform Assessment – Multi-Environment Azure Setup
This project demonstrates a clean and scalable Terraform structure for deploying Azure resources across multiple environments. The main goal of the project is to separate shared infrastructure from environment-specific deployments, while keeping everything modular and easy to maintain.

Overview
The setup includes:

A shared environment that contains long-lived resources such as a central Resource Group and a centralized Azure Container Registry (ACR).
Separate dev, staging, and prod environments that deploy their own Azure resources (Resource Groups, App Services, Networks, Storage, etc.).
A set of reusable Terraform modules used by all environments to maintain consistency.
How It Works
Shared Environment
The shared environment is applied first.
It creates resources that all other environments rely on—for example:

A centralized Azure Container Registry
A shared Resource Group
Outputs that other environments can read using remote state
These shared resources are deployed only once and reused everywhere.

Environment Folders (dev, staging, prod)
Each environment:

Has its own folder
Has its own backend state
Deploys only the resources required for that environment
Reads values from the shared environment (such as ACR details)
Does not recreate or override shared resources
This ensures full isolation between environments while still sharing necessary infrastructure components.

Modules
The project uses modules for:

Resource Groups
Networking
Storage
App Service
Azure Container Registry (used only in the shared environment)
Modules make the configuration cleaner, reusable, and easier to manage.

Project Highlights
Clear separation between shared and environment-specific deployments
Centralized ACR consumed by dev, staging, and prod
Proper remote state setup for all environments
Consistent and organized folder structure
Easy to extend or modify for future Azure resources
Ideal for learning real-world Terraform + Azure architecture
Purpose
This project was created as part of a Terraform assessment and serves as a demonstration of:

Infrastructure-as-Code best practices
Multi-environment design
Reusable Terraform modules
Proper remote state management on Azure