help:       
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

## --------- Database --------
db-logs: ## View the Postgres logs
	kubectl logs db-0

db-shell: ## Access the Postgres shell
	kubectl exec -it db-0 -- psql -U postgres -d notedb

## --------- Application --------
install: ## Prepare the environment (install Minikube, build and load images, create secrets)
	@echo " Setting up the environment..."
	chmod +x scripts/install.sh
	scripts/install.sh

deploy: ## Deploy the application to Minikube (using the deployment and service YAML files)
	@echo " Deploying the application..."
	chmod +x scripts/deploy.sh
	scripts/deploy.sh

view: ## Port-forwarding to access services locally (backend:8000, frontend:3000)
	@echo " Port-forwarding to access services locally..."
	kubectl port-forward svc/backend-service 8000:8000 & kubectl port-forward svc/frontend-service 3000:3000

## --------- Clean Up --------
clean: ## Remove all deployments, services and database PVCs
	@echo " Cleaning up the environment..."
	chmod +x scripts/clean.sh
	scripts/clean.sh

## --------- Testing --------
test: ## Run all tests
	@echo "Running tests..."
	chmod +x scripts/testing.sh
	scripts/testing.sh
