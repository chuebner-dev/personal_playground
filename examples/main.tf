# Example Terraform configuration for testing the Codespaces environment

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

# AWS Provider configuration
provider "aws" {
  region = var.aws_region
}

# Google Cloud Provider configuration
provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

# Variables
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "gcp_project_id" {
  description = "Google Cloud Project ID"
  type        = string
  default     = "my-project"
}

variable "gcp_region" {
  description = "Google Cloud region"
  type        = string
  default     = "us-central1"
}

# Random ID for unique bucket names
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# Example AWS resource - S3 bucket
resource "aws_s3_bucket" "example" {
  bucket = "my-codespace-test-bucket-${random_id.bucket_suffix.hex}"
}

resource "aws_s3_bucket_versioning" "example" {
  bucket = aws_s3_bucket.example.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Example GCP resource - Storage bucket
resource "google_storage_bucket" "example" {
  name          = "my-codespace-test-bucket-gcp-${random_id.bucket_suffix.hex}"
  location      = var.gcp_region
  force_destroy = true

  versioning {
    enabled = true
  }
}

# Outputs
output "aws_bucket_name" {
  description = "Name of the AWS S3 bucket"
  value       = aws_s3_bucket.example.bucket
}

output "gcp_bucket_name" {
  description = "Name of the GCP Storage bucket"
  value       = google_storage_bucket.example.name
}