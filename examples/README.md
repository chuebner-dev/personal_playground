# Examples Directory

This directory contains example configurations and scripts to test the Codespaces environment with various cloud tools.

## Files

### `main.tf`
Example Terraform configuration that demonstrates:
- Multi-cloud setup (AWS + Google Cloud)
- S3 and Cloud Storage bucket creation
- Terraform best practices

### `test-tools.sh`
Simple script to verify all cloud tools are installed and working.

## Testing the Environment

1. **Test tool installation:**
   ```bash
   bash examples/test-tools.sh
   ```

2. **Test Terraform:**
   ```bash
   cd examples
   terraform init
   terraform plan
   # Note: Don't run apply without proper credentials!
   ```

3. **Configure AWS credentials:**
   ```bash
   aws configure
   ```

4. **Configure GCP authentication:**
   ```bash
   gcloud auth login
   gcloud config set project YOUR_PROJECT_ID
   ```

## Prerequisites for Real Usage

- AWS credentials configured (`aws configure` or environment variables)
- GCP authentication setup (`gcloud auth login`)
- Appropriate IAM permissions for creating resources
- Valid project IDs and regions

## Safety Note

The example Terraform configuration is for demonstration only. Always review configurations before running `terraform apply` in any environment.