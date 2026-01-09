deploy:
	minikube start
	minikube addons enable registry
	kubectl create secret generic db-secret --from-env-file=.env
	kubectl apply -f database/database.yaml
	kubectl apply -f backend/backend.yaml
	kubectl apply -f frontend/frontend.yaml

pods:
	kubectl get pods

delete:
	minikube delete

db-logs: # view the Postgres logs
	kubectl logs db-0

db-shell: # access the Postgres shell
	kubectl exec -it db-0 -- psql -U postgres -d notedb


