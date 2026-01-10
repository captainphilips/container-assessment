# Container Assessment - setup and deployment guide
This project showcases Docker for application containerization and Kubernetes for orchestrating, managing, and scaling containers in a distributed environment. The backend is a Golang API connected to MongoDB. The task is to set up local development with Docker Compose and deploy the application to a local Kubernetes cluster using Kind.
## The project Structure
This repository contains a containerized backend application with support for both **local development (Docker / Docker Compose)** and **production deployment (Kubernetes)**.
Below is the full directory structure followed by a detailed explanation of each file and folder.

---

## Directory Tree
├── MuchToDo/  
├── Dockerfile  
├── docker-compose.yml  
├── .dockerignore  
├── kubernetes/  
│   ├── namespace.yaml  
│   ├── mongodb/  
│   │   ├── mongodb-secret.yaml  
│   │   ├── mongodb-configmap.yaml  
│   │   ├── mongodb-pvc.yaml  
│   │   ├── mongodb-deployment.yaml  
│   │   └── mongodb-service.yaml  
│   ├── backend/  
│   │   ├── backend-secret.yaml  
│   │   ├── backend-configmap.yaml  
│   │   ├── backend-deployment.yaml  
│   │   └── backend-service.yaml  
│   └── ingress.yaml  
├── scripts/  
│   ├── docker-build.sh  
│   ├── docker-run.sh  
│   ├── k8s-deploy.sh  
│   └── k8s-cleanup.sh  
└── README.md  

---
## Tech Stacks
* Containerization: Docker
* Orchestration: Kubernetes (KIND)
* Ingress: NGINX Ingress Controller
* Database: MongoDB 8.0
* Backend: Go (Golang)
## Requirements Checklist
* Docker and Docker Compose
* Kubernetes cluster and kubectl CLI tool.
* Go 1.25(+)
# Getting Started
## Build Docker Image, Dockerfile and Docker Compose
You may use an existing Docker image or build your own. Choose an image name (e.g., your-username/your-app:tag) and update it in the following files:
* scripts/docker-build.sh
* kubernetes/backend/backend-deployment.yaml
* docker-compose.yaml
___
Proceed to create a Dockerfile and a docker-compose.yaml. A Dockerfile is the recipe Docker uses to package your application into a runnable container. It sets up a base environment, copies app code into the image, installs dependencies, defines startup commands, and builds the application. While Docker-compose 
simplifies local development by managing multiple containers, such as the Go application and MongoDB. It defines networking, health checks, and service dependencies in a single configuration file. The .env file contains environment-specific configuration values and is usually excluded from version control because it holds sensitive data.
### Running and Health Check
#### Run the Application

```bash
# Start all services
docker-compose up -d

# Verify application health
curl http://localhost:8080/health
```
Expected output: {"database":"ok","cache":"disabled"}



##  Kubernetes
Kubernetes is used because Docker Compose works well for development, but production environments need high availability, automatic restarts, rolling updates, built-in scaling, CPU and memory management, service discovery via DNS, and secure secrets management. These are the Kubernetes building blocks:
Namespace: Logical isolation for cluster resources such as dev, staging, and prod. All resources run in the muchtodo namespace.
* **ConfigMap**: Holds non-sensitive configuration such as database names or feature flags.
* **Deployment**: Defines how containers run (image, replicas, health checks, updates) and ensures self-healing.
* **PersistentVolumeClaim (PVC)**: Requests persistent storage that survives pod restarts.
* **Namespace**: Logical isolation for cluster resources such as dev, staging, and prod. All resources run in the muchtodo namespace.
* **Service**: Provides stable networking and load-balancing for pods via a fixed DNS name.
* **Ingress**: Routes external HTTP/HTTPS traffic into the cluster, mapping domains and paths to Services.
* **Secret**: Stores sensitive data like passwords and API keys. Base64-encoded; use external secret managers in production.







  
  
