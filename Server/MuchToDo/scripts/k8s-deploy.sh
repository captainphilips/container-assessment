#!/bin/bash
set -e

echo "Deploying to Kubernetes..."

# Apply Namespace
kubectl apply -f kubernetes/namespace.yaml

# Apply MongoDB Resources
kubectl apply -f kubernetes/mongodb/mongodb-secret.yaml
kubectl apply -f kubernetes/mongodb/mongodb-configmap.yaml
kubectl apply -f kubernetes/mongodb/mongodb-pvc.yaml
kubectl apply -f kubernetes/mongodb/mongodb-deployment.yaml
kubectl apply -f kubernetes/mongodb/mongodb-service.yaml

# Apply Backend Resources
kubectl apply -f kubernetes/backend/backend-secret.yaml
kubectl apply -f kubernetes/backend/backend-configmap.yaml
kubectl apply -f kubernetes/backend/backend-deployment.yaml
kubectl apply -f kubernetes/backend/backend-service.yaml

# Apply Ingress
kubectl apply -f kubernetes/ingress.yaml

echo "Deployment complete."
echo "Waiting for pods to be ready..."
kubectl wait --namespace much-to-do --for=condition=ready pod --selector=app=mongodb --timeout=90s
kubectl wait --namespace much-to-do --for=condition=ready pod --selector=app=backend --timeout=90s
