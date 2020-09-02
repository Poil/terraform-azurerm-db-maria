
terraform {
  required_version = ">= 0.13"
  required_providers {
    azurerm = ">= 2.10"
    mysql = {
      source  = "terraform-providers/mysql"
      version = ">= 1.6"
    }
  }
}
