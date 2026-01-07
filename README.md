# cloud_computing

1 - minikube addons enable registry

2 - docker build -t frontend:1.0 -f frontend/Dockerfile ./frontend

3 - minikube cache add frontend:1.0

4 - kubectl create deployment frontend --image frontend:1.0 -r 2 --dry-run=client -o yaml >> frontend/deployment.yaml