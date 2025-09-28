# GitHub Codespaces Development Container

This repository includes a comprehensive GitHub Codespaces configuration optimized for cloud development with AWS, GCP, and Terraform.

## 🚀 Features

### Core Tools
- **GitHub Copilot**: AI-powered coding assistant with chat support
- **Terraform**: Infrastructure as Code with HashiCorp extensions
- **AWS CLI v2**: Complete AWS command-line interface
- **Google Cloud SDK**: Full gcloud CLI with alpha/beta components
- **kubectl & Helm**: Kubernetes management tools
- **Docker**: Container development with Docker-in-Docker support

### VS Code Extensions
- GitHub Copilot & Copilot Chat
- HashiCorp Terraform
- AWS Toolkit
- Google Cloud Code
- Docker, Kubernetes tools
- Python, JSON, YAML support
- Git integration (GitLens, GitHub PR)
- And many more productivity extensions

### Additional Utilities
- **terraform-docs**: Generate documentation from Terraform modules
- **tflint**: Terraform linter
- **terragrunt**: Terraform wrapper for DRY configurations
- **AWS Session Manager**: Secure shell access to EC2 instances
- Helpful shell aliases and functions

## 🔧 Usage

### Starting a Codespace
1. Click the "Code" button on the GitHub repository
2. Select "Codespaces" tab
3. Click "Create codespace on main"
4. Wait for the environment to build (first time takes ~5-10 minutes)

### First-time Setup
After the Codespace launches, you'll need to configure your cloud credentials:

#### AWS Configuration
```bash
aws configure
# Enter your AWS Access Key ID, Secret Access Key, Region, and output format
```

#### Google Cloud Authentication
```bash
gcloud auth login
gcloud config set project YOUR_PROJECT_ID
```

#### Git Configuration (if not already set)
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### Quick Commands
The environment includes helpful aliases:

#### Terraform
- `tf` - terraform
- `tfi` - terraform init
- `tfp` - terraform plan
- `tfa` - terraform apply
- `tfd` - terraform destroy
- `tfv` - terraform validate
- `tff` - terraform fmt

#### AWS
- `awswho` - Show current AWS identity
- `awsregion` - Show current AWS region

#### Google Cloud
- `gcpwho` - Show current GCP identity
- `gcpproject-current` - Show current GCP project

#### Kubernetes
- `k` - kubectl
- `kgp` - kubectl get pods
- `kgs` - kubectl get services
- `kctx` - kubectl config current-context

## 📁 Directory Structure

The setup script creates the following workspace directories:
```
~/workspace/
├── terraform/    # Terraform configurations
├── aws/         # AWS-specific projects
├── gcp/         # Google Cloud projects
├── kubernetes/  # Kubernetes manifests
└── scripts/     # Utility scripts
```

## 🔒 Security Notes

- Never commit cloud credentials to your repository
- Use environment variables or credential files for sensitive information
- The devcontainer runs with appropriate permissions for development
- Docker-in-Docker is enabled for containerized workflows

## 🛠️ Customization

You can customize the environment by modifying:
- `.devcontainer/devcontainer.json` - VS Code extensions and settings
- `.devcontainer/setup.sh` - Additional tools and configuration

## 📚 Resources

- [GitHub Codespaces Documentation](https://docs.github.com/en/codespaces)
- [Dev Container Specification](https://containers.dev/)
- [Terraform Documentation](https://terraform.io/docs)
- [AWS CLI Documentation](https://docs.aws.amazon.com/cli/)
- [Google Cloud SDK Documentation](https://cloud.google.com/sdk/docs)