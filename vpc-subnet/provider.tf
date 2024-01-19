# Configure AWS provider
terraform {
  required_version = ">= 1.0.0"
  backend "s3" {
    # Replace this with your bucket name!
    bucket = "sloth-solutions-terraform-states"
    key    = "networking/terraform.tfstate"
    region = "us-east-1"
    # Replace this with your DynamoDB table name!
    #dynamodb_table = "YOUR_DYNAMODB_TABLE_NAME_HERE"
    #encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}