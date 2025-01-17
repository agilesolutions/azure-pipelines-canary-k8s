terraform {

  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "2f43f536-04ab-459b-aefb-cd160d254c10"

  features {
    
  }
  
}

provider "azuread" {  
}

resource "random_pet" "aksrandom" {
}
