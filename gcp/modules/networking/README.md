# GCP Networking Module

This module creates basic networking infrastructure on Google Cloud Platform including:

- VPC Network
- Subnet

## Usage

```hcl
module "networking" {
  source = "../../modules/networking"
  
  project_name = "my-project"
  environment  = "dev"
  region       = "us-central1"
  subnet_cidr  = "10.0.1.0/24"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project_name | Name of the project | `string` | n/a | yes |
| environment | Environment name | `string` | n/a | yes |
| region | GCP region | `string` | n/a | yes |
| subnet_cidr | CIDR block for the subnet | `string` | `"10.0.1.0/24"` | no |

## Outputs

| Name | Description |
|------|-------------|
| network_id | ID of the VPC network |
| network_name | Name of the VPC network |
| subnet_id | ID of the subnet |
| subnet_name | Name of the subnet |