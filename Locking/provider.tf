terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>6.0"
    }
  }

  # backend "s3" {
  #     bucket = "godrej-app-ubuntu-db-unique"
  #     region = "ap-south-1"
  #     key = "data/state"
  #     encrypt = true
  #     dynamodb_table = "My_DB_Terra"
  # }
}

provider "aws" {
  region = "ap-south-1"
}

