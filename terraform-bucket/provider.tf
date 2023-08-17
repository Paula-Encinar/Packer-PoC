terraform {
  backend "s3" {
    bucket = "terraformstate-poc"
    key    = "state-bucket/terraform.tfstate"
    region = "eu-west-2"
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