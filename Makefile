start:
	minikube start
	minikube addons enable registry
	kubectl create secret generic db-secret --from-env-file=.env
	kubectl apply -f database/database.yaml
	
pods:
	kubectl get pods

## build images and deploy to minikube
build:
	docker build -t notedb-backend -f ./backend/Dockerfile ./backend
	docker build -t notedb-frontend -f ./frontend/Dockerfile ./frontend
	minikube image load notedb-backend notedb-frontend

db-logs: # view the Postgres logs
	kubectl logs db-0

db-shell: # access the Postgres shell
	kubectl exec -it db-0 -- psql -U postgres -d notedb


