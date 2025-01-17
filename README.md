# Use a canary deployment strategy for Kubernetes

You use the associated workflow to deploy the code and compare the baseline and canary app deployments. Based on the evaluation, you decide whether to promote or reject the canary deployment.

This tutorial uses Docker Registry and Azure Resource Manager service connections to connect to Azure resources. For an Azure Kubernetes Service (AKS) private cluster or a cluster that has local accounts disabled, an Azure Resource Manager service connections is a better way to connect.

# Prerequisites

## Create Azure Storage Account in new Resource Group
- Why should be we create terraform state storage in different resource group? 
  - State storage is key for all terraform resources and it should be deleted at any point of time even accidentally.
- **Create New Resource Group:** terraform-storage-rg
- **Create Storage Account:** terraformstatexlrwdrzs  (Note: Name should be unique across Azure)
- **Create Container Name:** tfstatefiles
- **Add subscription provider_** add provider compute
- Upload the file **terraform.tfstate** to storage account container

## Update main.tf with Terraform State Storage
```
# Configure Terraform State Storage
terraform {
  backend "azurerm" {
    resource_group_name   = "terraform-storage-rg"
    storage_account_name  = "terraformstatexlrwdrzs"
    container_name        = "tfstatefiles"
    key                   = "terraform.tfstate"
  }
}
```

## Migrate terraform backend by re-initializing
- First backup local terraform.tfstate
```
# Backup existing terraform.tfstate present locally
mkdir BACKUP-LOCAL-TFSTATE
mv terraform.tfstate BACKUP-LOCAL-TFSTATE

# Try terraform validate
terraform validate

# Try terraform plan (Should fail telling us to re-initialize backed)
terraform plan

# Re-Initialize Terraform Backend
terraform init 

# SSH Public Key for Linux VMs
variable "ssh_public_key" {
  default = "~/.ssh/aks-prod-sshkeys-terraform/aksprodsshkey.pub"
  description = "This variable defines the SSH Public Key for Linux k8s Worker nodes"  
}

# Call get-versions API via command line
az aks get-versions --location centralus -o table

# Switching on debug level
set TF_LOG=DEBUG

# log on AZ
- az login
- az version -o=json
- az account list

# upgrade CLIs
- choco upgrade azure-cli
- choco upgrade terraform

# find choco install azure cli
- where az


