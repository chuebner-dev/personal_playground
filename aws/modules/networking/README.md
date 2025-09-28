# AWS Networking Module

This module creates basic networking infrastructure on Amazon Web Services including:

- VPC
- Public Subnet
- Internet Gateway
- Route Table

## Usage

```hcl
module "networking" {
  source = "../../modules/networking"
  
  project_name       = "my-project"
  environment        = "dev"
  vpc_cidr          = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project_name | Name of the project | `string` | n/a | yes |
| environment | Environment name | `string` | n/a | yes |
| vpc_cidr | CIDR block for VPC | `string` | `"10.0.0.0/16"` | no |
| public_subnet_cidr | CIDR block for the public subnet | `string` | `"10.0.1.0/24"` | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | ID of the VPC |
| vpc_cidr_block | CIDR block of the VPC |
| public_subnet_id | ID of the public subnet |
| internet_gateway_id | ID of the Internet Gateway |