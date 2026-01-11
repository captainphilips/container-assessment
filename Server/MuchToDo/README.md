# MuchToDo Backend API

This is the Go backend API for the MuchToDo application.

## Development

### Prerequisites
- Go 1.25+
- Docker & Docker Compose

### Quick Start
To run the application locally with all dependencies (MongoDB, Redis):

```bash
./scripts/docker-run.sh
```

This will run `docker-compose up` and start the API on port 8080.

## Deployment

### Kubernetes

This project includes Kubernetes manifests for deploying to a cluster.

#### Project Structure
- `kubernetes/`: Contains K8s manifests.
  - `namespace.yaml`: Application namespace.
  - `mongodb/`: MongoDB deployment and persistence configuration.
  - `backend/`: API deployment configuration.
  - `ingress.yaml`: Ingress rules.
- `scripts/`: Helper scripts for deployment.

#### Deploying
Ensure you have `kubectl` configured with access to your cluster.

1. **Build the image** (ensure your cluster can pull this image, e.g., using Minikube's Docker daemon or pushing to a registry):
   ```bash
   ./scripts/docker-build.sh
   # If using a registry, tag and push:
   # docker tag much-to-do-api:latest your-registry/much-to-do-api:latest
   # docker push your-registry/much-to-do-api:latest
   # Note: Update backend-deployment.yaml image if pushing to a registry.
   ```

2. **Deploy to Kubernetes**:
   ```bash
   ./scripts/k8s-deploy.sh
   ```

3. **Cleanup**:
   ```bash
   ./scripts/k8s-cleanup.sh
   ```

## Configuration

- **Environment Variables**: Managed via ConfigMaps and Secrets in `free-kubernetes/`.
- **Secrets**: Sensitive data (Database passwords, API secrets) are stored in `*-secret.yaml` files. **Note**: In a real production environment, use a secure secret management solution (e.g., Vault, Sealed Secrets) instead of committing base64 secrets to git.
