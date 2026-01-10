#!/bin/bash
echo "A iniciar o ambiente..."

minikube start

echo " A ativar o Ingress..."
minikube addons enable ingress

echo " A ativar o Registry..."
minikube addons enable registry

echo " A construir imagens..."
docker build -t notes-backend -f ./backend/Dockerfile ./backend
docker build -t notes-frontend -f ./frontend/Dockerfile ./frontend

echo " A carregar imagens no Minikube..."
minikube image load notes-backend notes-frontend

echo " A criar segredo para a base de dados..."
kubectl create secret generic db-secret --from-env-file=.env

echo "✅ Instalação concluída!"