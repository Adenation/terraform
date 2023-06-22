terraform {
  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "tf-lab"
    storage_account_name = "adentfstorageaccount"
    container_name = "landing"
    key = "devpipeline.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}
