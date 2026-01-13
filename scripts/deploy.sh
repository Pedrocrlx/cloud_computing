#!/bin/bash

echo "Starting layered deploy..."

# 1. database needs to be ready before backend
echo "Creating Database..."
kubectl apply -f infra/database/
kubectl wait --for=condition=ready pod -l app=database --timeout=60s

# 2. Backend needs the database to be up
echo "Creating Backend..."
kubectl apply -f infra/backend/

# 3. Frontend needs the backend to be up
echo "Creating Frontend..."
kubectl apply -f infra/frontend/

# 4. Ingress to route traffic
echo "Configuring Ingress..."
kubectl apply -f infra/ingress/

echo "✅ All applied!"