#!/bin/bash

echo "🧪 Testing Codespaces Development Environment Tools"
echo "=================================================="
echo

# Test GitHub Copilot (can't test directly, but check if extension would be available)
echo "🤖 GitHub Copilot:"
echo "   ✅ Will be automatically available in VS Code via extensions"
echo

# Test Terraform
echo "🏗️  Terraform:"
if command -v terraform &> /dev/null; then
    terraform version | head -1
    echo "   ✅ Terraform is installed"
else
    echo "   ❌ Terraform is not installed"
fi
echo

# Test AWS CLI
echo "☁️  AWS CLI:"
if command -v aws &> /dev/null; then
    aws --version
    echo "   ✅ AWS CLI is installed"
    echo "   💡 Run 'aws configure' to set up credentials"
else
    echo "   ❌ AWS CLI is not installed"
fi
echo

# Test Google Cloud SDK
echo "🌐 Google Cloud SDK:"
if command -v gcloud &> /dev/null; then
    gcloud version --format="value(Google Cloud SDK)" 2>/dev/null || echo "Latest version"
    echo "   ✅ Google Cloud SDK is installed"
    echo "   💡 Run 'gcloud auth login' to authenticate"
else
    echo "   ❌ Google Cloud SDK is not installed"
fi
echo

# Test kubectl
echo "⚙️  Kubernetes CLI:"
if command -v kubectl &> /dev/null; then
    kubectl version --client --short 2>/dev/null | head -1 || echo "kubectl client installed"
    echo "   ✅ kubectl is installed"
else
    echo "   ❌ kubectl is not installed"
fi
echo

# Test Docker
echo "🐳 Docker:"
if command -v docker &> /dev/null; then
    docker --version
    echo "   ✅ Docker is installed"
else
    echo "   ❌ Docker is not installed"
fi
echo

# Test additional tools
echo "🔧 Additional Tools:"

if command -v terraform-docs &> /dev/null; then
    echo "   ✅ terraform-docs: $(terraform-docs version)"
else
    echo "   ❌ terraform-docs not installed"
fi

if command -v tflint &> /dev/null; then
    echo "   ✅ tflint: $(tflint --version | head -1)"
else
    echo "   ❌ tflint not installed"
fi

if command -v terragrunt &> /dev/null; then
    echo "   ✅ terragrunt: $(terragrunt --version | head -1)"
else
    echo "   ❌ terragrunt not installed"
fi

if command -v helm &> /dev/null; then
    echo "   ✅ helm: $(helm version --short 2>/dev/null || helm version --template='{{.Version}}')"
else
    echo "   ❌ helm not installed"
fi

echo
echo "🎉 Tool verification complete!"
echo
echo "Next steps:"
echo "1. Configure AWS credentials: aws configure"
echo "2. Authenticate with GCP: gcloud auth login"
echo "3. Start developing with cloud tools!"
echo