# Personal Playground

This repository contains Terraform configurations for cloud infrastructure projects using Google Cloud Platform (GCP) and Amazon Web Services (AWS). The repository is organized to support multiple projects and reusable modules for both cloud providers.

## Repository Structure

```
├── README.md
├── .gitignore
├── gcp/
│   ├── projects/
│   │   └── example-project/        # Example GCP project configuration
│   │       ├── main.tf
│   │       ├── variables.tf
│   │       ├── outputs.tf
│   │       └── terraform.tfvars.example
│   └── modules/
│       ├── networking/             # GCP networking resources
│       ├── compute/                # GCP compute resources
│       └── storage/                # GCP storage resources
└── aws/
    ├── projects/
    │   └── example-project/        # Example AWS project configuration
    │       ├── main.tf
    │       ├── variables.tf
    │       ├── outputs.tf
    │       └── terraform.tfvars.example
    └── modules/
        ├── networking/             # AWS networking resources
        ├── compute/                # AWS compute resources
        └── storage/                # AWS storage resources
```

## Getting Started

### Prerequisites

- [Terraform](https://terraform.io/downloads.html) >= 1.0
- Cloud provider CLI tools:
  - [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) for GCP
  - [AWS CLI](https://aws.amazon.com/cli/) for AWS

### Usage

1. Choose your cloud provider (GCP or AWS)
2. Navigate to the desired project directory:
   ```bash
   cd gcp/projects/example-project  # For GCP
   # or
   cd aws/projects/example-project  # For AWS
   ```
3. Copy the example variables file:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```
4. Edit `terraform.tfvars` with your specific values
5. Initialize and apply Terraform:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

### Creating New Projects

To create a new project:

1. Copy the example project directory:
   ```bash
   cp -r gcp/projects/example-project gcp/projects/my-new-project
   ```
2. Update the configuration files as needed
3. Follow the usage steps above

### Using Modules

The repository includes reusable modules for common infrastructure patterns. Reference them in your project configurations:

```hcl
module "networking" {
  source = "../../modules/networking"
  
  project_name = var.project_name
  environment  = var.environment
  # ... other variables
}
```

## Cloud Provider Authentication

### GCP Authentication

Set up authentication using one of these methods:
- Service account key file
- Application Default Credentials (ADC)
- gcloud CLI authentication

### AWS Authentication

Set up authentication using one of these methods:
- AWS credentials file
- Environment variables
- IAM roles (for EC2 instances)
- AWS CLI profiles

## Best Practices

- Always use version constraints for Terraform and providers
- Store sensitive variables in `.tfvars` files (not committed to git)
- Use consistent naming conventions across resources
- Tag/label resources appropriately for cost tracking and organization
- Use remote state backend for production environments

## Contributing

When adding new modules or projects:
1. Follow the existing directory structure
2. Include comprehensive README documentation
3. Use consistent variable naming and output conventions
4. Test configurations before committing