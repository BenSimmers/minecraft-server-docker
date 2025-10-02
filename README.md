# Minecraft Server with Docker

This project runs a Minecraft server using Docker. It includes automated backups and a healthcheck to ensure the server is running smoothly.

## Getting Started

1.  **Clone the repository:**
    ```bash
    git clone <repository-url>
    cd minecraft-server-docker
    ```

2.  **Create a `minecraftData` directory:**
    ```bash
    mkdir minecraftData # when you run the container this directory will be created
    ```
    This directory will store your Minecraft world data.

3.  **Configure ngrok (optional):**
    If you want to expose your server to the internet, you'''ll need to configure ngrok.
    1.  Sign up for an ngrok account at [ngrok.com](https://ngrok.com/).
    2.  Get your authtoken from your ngrok dashboard.
    3.  Create an `ngrok.yml` file with the following content, replacing `<your-authtoken>` with your actual token:
        ```yaml
        authtoken: <your-authtoken>
        tunnels:
          minecraft:
            proto: tcp
            addr: minecraft-server:25565
        ```

4.  **Start the server:**
    ```bash
    docker compose up -d
    ```
    This will start the Minecraft server, the backup service, and the ngrok tunnel (if configured).

## Backups

The server is configured to automatically back up the Minecraft world every 6 hours. Backups are stored in the `backups` directory.

To manually trigger a backup, run the following command:
```bash
docker exec minecraft-backup backup now
```

## Healthcheck

The Minecraft server container has a healthcheck that runs every minute. If the server is unresponsive, Docker will automatically restart it.

## To find your server's ngrok tunnel IP

```bash
curl http://localhost:4040/api/tunnels
```

## Connecting to the Server

*   **Locally:** You can connect to the server at `localhost:25565`.
*   **Via ngrok:** If you configured ngrok, you can find the public address in the ngrok dashboard or by running `docker logs ngrok-tunnel`.

## Running on Kubernetes

This project also includes manifests to run the Minecraft server on a Kubernetes cluster.

### Prerequisites

- A running Kubernetes cluster (like `kind`, `minikube`, or a cloud provider's).
- `kubectl` configured to connect to your cluster.
- An `ngrok` authtoken.

### Setup

1.  **Update `ngrok-configmap.yaml`:**
    Open `k8s/ngrok-configmap.yaml` and paste your ngrok authtoken into the `authtoken` field.

2.  **Apply the manifests:**
    Run the following command to create all the Kubernetes resources:

    ```bash
    kubectl apply -f k8s/
    ```

For more detailed instructions on how to access and manage the server on Kubernetes, see the `k8s/README.md` file.

