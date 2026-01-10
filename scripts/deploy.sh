#!/bin/bash

echo "Iniciando deploy por camadas..."

# 1. database needs to be ready before backend
echo "A criar a Database..."
kubectl apply -f infra/database/
kubectl wait --for=condition=ready pod -l app=database --timeout=60s

# 2. Backend needs the database to be up
echo "A criar o Backend..."
kubectl apply -f infra/backend/

# 3. Frontend needs the backend to be up
echo "A criar o Frontend..."
kubectl apply -f infra/frontend/

# 4. Ingress to route traffic
echo "A configurar o Ingress..."
kubectl apply -f infra/ingress/

echo "✅ Tudo aplicado!"