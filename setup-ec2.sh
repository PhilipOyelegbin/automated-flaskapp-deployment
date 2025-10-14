#!/bin/bash

# Update system
sudo apt-get update
sudo apt-get upgrade -y

# Install Docker
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Add ubuntu user to docker group
sudo usermod -aG docker ubuntu

# Create application directory
sudo mkdir -p /opt/app
sudo chown ubuntu:ubuntu /opt/app

# Configure SSH for GitHub Actions
echo "Creating SSH key for GitHub Actions..."
sudo -u ubuntu ssh-keygen -t rsa -b 4096 -f /home/ubuntu/.ssh/github_actions -N ""

echo "Public key for GitHub Actions:"
sudo cat /home/ubuntu/.ssh/github_actions.pub

# Create deployment script
cat > /opt/app/deploy.sh << 'EOF'
#!/bin/bash
set -e

cd /opt/app

# Pull latest changes
git pull origin main

# Build and deploy
docker-compose down
docker-compose pull
docker-compose up -d

echo "Deployment completed successfully!"
EOF

chmod +x /opt/app/deploy.sh