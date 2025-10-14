#!/bin/bash
HEALTH_CHECK_URL="http://localhost:5000/health"
MAX_RETRIES=3
RETRY_COUNT=0

while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
    response=$(curl -s -o /dev/null -w "%{http_code}" $HEALTH_CHECK_URL)
    
    if [ $response -eq 200 ]; then
        echo "Application is healthy"
        exit 0
    fi
    
    echo "Health check failed (Attempt $((RETRY_COUNT + 1))/$MAX_RETRIES)"
    RETRY_COUNT=$((RETRY_COUNT + 1))
    sleep 5
done

echo "Health check failed after $MAX_RETRIES attempts"
exit 1