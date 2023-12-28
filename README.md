# An example Docker setup for Haskell (Cabal)

> [!NOTE]
> I assume needed programs (`docker`, `kubernetes`) are installed and configured properly (`ingress`).
> For local setup of Kubernetes one can use [`minikube`](https://minikube.sigs.k8s.io/docs/) or
> [`microk8s`](https://microk8s.io/)

## Docker:

```shell
# Build an image and run it:
docker build -t abc .
docker run -e PORT=8080 -it abc

# Or pass the PORT argument in build-time:
docker build --build-arg=PORT=8080 -t abc .
docker run -it abc
```

## Docker with Kubernetes

### 1. Build a docker image

```shell
docker build -t abc .
```

### 2. Deploy

```shell
kubectl apply -f deployment.yaml -f service.yaml
```

### 3. Expose the app to the world

1. Set appropriate parameters in:

    1. `ingress.yaml`: set `host` to appropriate domain through which the service will be exposed to the world.

2. Apply:

```shell
kubectl apply -f ingress.yaml
```
