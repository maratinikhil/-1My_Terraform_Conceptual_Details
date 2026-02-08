terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~>6.0"
            
        }
    }
    backend "s3" {
        bucket = "mybucket-storage-ec2-git-terraform-with-ubuntu"
        key = "data/storage/statefile"
        encrypt = true
        region = "ap-south-1"
    }
}


provider "aws" {
    region = "ap-south-1"
}

