# How to run Minecraft on Kubernetes

This directory contains the Kubernetes manifests to run a Minecraft server, backup job, and ngrok tunnel, similar to the provided `docker-compose.yaml`.

## Prerequisites

- A running Kubernetes cluster (like `kind`, `minikube`, or a cloud provider's).
- `kubectl` configured to connect to your cluster.
- An `ngrok` authtoken.

## Setup

1.  **Update `ngrok-configmap.yaml`:**
    Open `k8s/ngrok-configmap.yaml` and paste your ngrok authtoken into the `authtoken` field.

2.  **Apply the manifests:**
    Run the following command to create all the Kubernetes resources:

    ```bash
    kubectl apply -f k8s/
    ```

## Accessing your Minecraft Server

### From inside the cluster

Other pods in the cluster can access the Minecraft server using the service name `minecraft-service`.

### From outside the cluster

The `minecraft-service.yaml` uses a `NodePort`. This means the Minecraft server will be accessible on port `30000` on any of your cluster's nodes.

If you are using `kind`, you can find the IP address of your control-plane node with:
```bash
docker ps
```
Find the container with `role: control-plane` and get its IP address with:
```bash
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <container_id>
```
Your Minecraft server will be available at `<node_ip>:30000`.

### Via ngrok

The ngrok tunnel will expose your Minecraft server to the internet. You can see the public address in the ngrok dashboard or by checking the logs of the ngrok pod:

```bash
kubectl logs -l app=ngrok
```

## Managing the server

-   **Check status:** `kubectl get pods -l app=minecraft`
-   **View logs:** `kubectl logs -l app=minecraft`
-   **Access the server console (RCON):** You can `exec` into the pod to run `rcon-cli` commands.
    ```bash
    kubectl exec -it <minecraft-pod-name> -- rcon-cli
    ```

## Backups

Backups are handled by a `CronJob` that runs every 6 hours. The backups are stored in a PersistentVolume. You can check the status of backup jobs with:

```bash
kubectl get cronjobs
kubectl get jobs
```
