terraform {
  backend "s3" {
    bucket = "terraformstate-poc"
    key    = "state/terraform.tfstate"
    region = "eu-west-2"
    access_key = var.AWS_ACCESS_KEY_ID
    secret_key = var.AWS_SECRET_ACCESS_KEY
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.27.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}