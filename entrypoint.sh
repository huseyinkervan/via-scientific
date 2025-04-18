#!/usr/bin/env bash
set -eux


echo "Waiting for Docker daemon to be ready..."
until docker info >/dev/null 2>&1; do
  sleep 1
done
echo "Docker daemon is ready."

minikube delete --all --purge || true

minikube start \
  --driver=docker \
  --kubernetes-version=v1.25.9 \
  --addons=metrics-server,ingress,dashboard \
  --cpus=8 \
  --memory=16384mb \
  --force





echo "Applying kustomize manifests with server-side apply, errors will be ignored..."
set +e
kustomize build /manifests/shinyproxy/shinyproxy-operator/docs/deployment/overlays/1-namespaced | kubectl apply -f - --server-side
kustomize build /manifests/shinyproxy/ | kubectl apply -f - --server-side
sleep 2
## rety edilmesi documanda tavsiye edilmiş https://github.com/openanalytics/shinyproxy-operator/tree/master/docs/deployment
kustomize build /manifests/shinyproxy/shinyproxy-operator/docs/deployment/overlays/1-namespaced | kubectl apply -f - --server-side
set -e

echo "Kustomize apply step finished."

# 5) Sonsuz döngü, container ayakta kalsın
tail -f /dev/null
