# 📝 Notes App - Kubernetes Deployment

A full-stack web application for managing notes, orchestrated with Kubernetes.
The project consists of a pure HTML/JS Frontend, a Python (FastAPI) Backend, and a persistent PostgreSQL Database.

## Architecture

The application follows a microservices architecture:

```ascii
USER (Browser)
      │
      ▼
┌──────────────┐       ┌──────────────┐       ┌──────────────┐
│  Service:    │       │  Service:    │       │  Service:    │
│  Frontend    │       │  Backend     │       │  Database    │
│ (LoadBalancer)       │ (LoadBalancer)       │ (ClusterIP)  │
└──────┬───────┘       └──────┬───────┘       └──────┬───────┘
       │                      │                      │
       ▼                      ▼                      ▼
┌──────────────┐       ┌──────────────┐       ┌──────────────┐
│     POD      │       │     POD      │       │     POD      │
│   Nginx +    │◄────► │   FastAPI    │◄────► │  PostgreSQL  │
│  Static JS   │       │   Python     │       │              │
└──────────────┘       └──────────────┘       └──────────────┘
```

- Frontend: Serves static files via Nginx.

- Backend: REST API developed in Python. Uses an InitContainer to wait for DB readiness.

- Database: PostgreSQL with data persistence (PVC).


## How to Run the Project

This project uses a Makefile to simplify the build, deployment, and testing processes.

Prerequisites

- Kubernetes Cluster (Minikube)

- Docker or Docker Desktop

- Devcontainers Extension for Vscode

- make utility

## Step 1: Installation & Build

You can use **make help** to see all the commands

Prepares the environment (and builds Docker images if applicable).

```bash
make install
```

## Step 2: Deploy to Kubernetes

Applies all manifests (Services, Deployments, Secrets, PVCs) to the cluster.

```bash
make deploy
```

**Note: The backend deployment includes an init-container that waits for the database to be ready before starting the application.**

## Step 3: Automated Testing

Verifies if all pods are running and if the API/Frontend are reachable inside the cluster.

```bash
make test
```

## Step 4: Access the Application (View)

Opens the connection to the application.

```bash
make view
```

ℹ️ **Architectural Note**: Although the services are configured as LoadBalancer (production-standard), this command establishes a local port-forward tunnel to map the services directly to localhost.

We use this approach for development to ensure consistency across different environments (Minikube, Docker Desktop, Linux, Mac), guaranteeing that the app is always accessible at:

- Frontend: http://localhost:3000

- Backend API: http://localhost:8000


## Step 5: Cleanup

Removes all resources (Pods, Services, Deployments) from the cluster.

```bash
make clean
```