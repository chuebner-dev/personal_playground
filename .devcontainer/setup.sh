#!/bin/bash

# Post-create setup script for the devcontainer
echo "🚀 Setting up development environment..."

# Update package list and install additional utilities
sudo apt-get update && sudo apt-get install -y \
    curl \
    wget \
    unzip \
    jq \
    tree \
    htop \
    vim \
    nano

# Install additional cloud tools that might not be in the features
echo "📦 Installing additional tools..."

# Install Terraform Docs
echo "Installing terraform-docs..."
curl -sSLo ./terraform-docs.tar.gz https://terraform-docs.io/dl/v0.16.0/terraform-docs-v0.16.0-$(uname)-amd64.tar.gz
tar -xzf terraform-docs.tar.gz
chmod +x terraform-docs
sudo mv terraform-docs /usr/local/bin/terraform-docs
rm terraform-docs.tar.gz

# Install TFLint
echo "Installing tflint..."
curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash

# Install Terragrunt
echo "Installing terragrunt..."
TERRAGRUNT_VERSION=$(curl -s https://api.github.com/repos/gruntwork-io/terragrunt/releases/latest | jq -r '.tag_name')
curl -Lo terragrunt https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/terragrunt_linux_amd64
chmod +x terragrunt
sudo mv terragrunt /usr/local/bin/

# Install AWS Session Manager plugin
echo "Installing AWS Session Manager plugin..."
curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb"
sudo dpkg -i session-manager-plugin.deb
rm session-manager-plugin.deb

# Install Google Cloud SDK additional components
echo "Installing additional gcloud components..."
gcloud components install alpha beta --quiet || echo "gcloud components already installed or not available"

# Configure shell aliases and helpful functions
echo "🔧 Setting up shell configuration..."

# Add helpful aliases to bashrc
cat << 'EOF' >> ~/.bashrc

# Cloud development aliases
alias tf='terraform'
alias tg='terragrunt'
alias k='kubectl'
alias awsprofile='export AWS_PROFILE=$(aws configure list-profiles | fzf)'
alias gcpproject='gcloud config set project $(gcloud projects list --format="value(projectId)" | fzf)'

# Terraform shortcuts
alias tfi='terraform init'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfd='terraform destroy'
alias tfv='terraform validate'
alias tff='terraform fmt'

# AWS shortcuts
alias awswho='aws sts get-caller-identity'
alias awsregion='aws configure get region'

# GCP shortcuts
alias gcpwho='gcloud auth list'
alias gcpproject-current='gcloud config get-value project'

# Kubernetes shortcuts
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'
alias kctx='kubectl config current-context'

# Git shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'

EOF

# Create a welcome message
cat << 'EOF' > ~/.welcome.sh
#!/bin/bash
echo "🌟 Welcome to your Cloud Development Environment!"
echo ""
echo "Available tools:"
echo "  ✅ GitHub Copilot (AI-powered coding assistant)"
echo "  ✅ Terraform $(terraform version | head -1 | cut -d' ' -f2)"
echo "  ✅ AWS CLI $(aws --version | cut -d' ' -f1)"
echo "  ✅ Google Cloud SDK $(gcloud version --format='value(Google Cloud SDK)' 2>/dev/null || echo 'installed')"
echo "  ✅ kubectl $(kubectl version --client --short 2>/dev/null | cut -d' ' -f3 || echo 'installed')"
echo "  ✅ Docker $(docker --version | cut -d' ' -f3 | tr -d ',')"
echo ""
echo "Quick start commands:"
echo "  terraform --help    # Terraform help"
echo "  aws configure       # Configure AWS credentials"
echo "  gcloud auth login   # Login to Google Cloud"
echo "  kubectl cluster-info # Kubernetes cluster info"
echo ""
echo "Happy coding! 🚀"
EOF

chmod +x ~/.welcome.sh

# Run welcome message on terminal startup
echo "~/.welcome.sh" >> ~/.bashrc

# Set up git configuration if not already configured
if [ -z "$(git config --global user.name)" ]; then
    echo "⚙️  Git configuration not found. You may want to run:"
    echo "   git config --global user.name 'Your Name'"
    echo "   git config --global user.email 'your.email@example.com'"
fi

# Create sample directories for development
mkdir -p ~/workspace/{terraform,aws,gcp,kubernetes,scripts}

echo "✅ Setup complete! Restart your terminal to see the welcome message."