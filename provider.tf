terraform {
  required_providers {
    aviatrix = {
      source = "aviatrixsystems/aviatrix"
      version = "2.20.3"
    }
    aws = {
      source  = "hashicorp/aws"
        version = "3.67.0"
    }
  }
}

# Configure Aviatrix provider
provider "aviatrix" {
  controller_ip = var.avx_controller_ip
  username      = var.avx_admin_username
  password      = var.avx_admin_password
}

provider "aws" {
  region  = var.region
  secret_key = var.secret_access_key
  access_key = var.access_key
}