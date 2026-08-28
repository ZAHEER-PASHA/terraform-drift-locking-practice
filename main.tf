terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket = "terraform-state-floci"
    key    = "terraform/terraform.tfstate"
    region = "us-east-1"

    endpoints = {
      s3 = "http://localhost:4566"
    }

    access_key = "test"
    secret_key = "test"

    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_region_validation      = true
    skip_metadata_api_check     = true

    use_path_style = true

    use_lockfile = true
  }
}

provider "aws" {
  region = "us-east-1"

  endpoints {
    s3 = "http://localhost:4566"
  }

  access_key = "test"
  secret_key = "test"

  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_region_validation      = true
  skip_metadata_api_check     = true
}

resource "aws_s3_bucket" "drift_test" {
  bucket = "terraform-drift-test-bucket"
  tags = {
    Environment = "locking-test"
    Project     = "production-demo"
  }
}

resource "aws_s3_bucket_versioning" "drift_test" {
  bucket = aws_s3_bucket.drift_test.id

  versioning_configuration {
    status = "Suspended"
  }
}

