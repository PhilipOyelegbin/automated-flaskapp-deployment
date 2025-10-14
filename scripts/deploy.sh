#!/bin/bash
set -e

echo "Starting deployment process..."

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --rollback)
    ROLLBACK=true
    shift
    ;;
    *)
    echo "Unknown parameter: $1"
    exit 1
    ;;
  esac
done

cd /opt/app

if [ "$ROLLBACK" = true ]; then
    echo "Initiating rollback..."
    git checkout HEAD~1
    docker-compose down
    docker-compose up -d
    echo "Rollback completed successfully!"
else
    echo "Deploying latest version..."
    git pull origin main
    docker-compose down
    docker-compose pull
    docker-compose up -d
    echo "Deployment completed successfully!"
fi

# Health check
echo "Performing health check..."
sleep 10
curl -f http://localhost:5000/health || exit 1
echo "Health check passed!"