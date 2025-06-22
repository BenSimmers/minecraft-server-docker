# minecraft-server-docker

This is a simple Minecraft docker compose setup.

## Usage
- Update the `docker-compose.yaml` file with your desired settings.
    - add your volume mounts for your world data
        - `./path/to/your/world/data:/data` where `/data` is the server folder in the container - so we mount our own empty directory to maintain state if the container dies.
    - add your environment variables for your server settings
        - `EULA=true`
        - `PORT:25565` ngrok tcp 25565
    - Paste in your ngrok authtoken from the ngrok dashboard at https://dashboard.ngrok.com/get-started/your-authtoken. Ensure a payment method is added to your ngrok account, as ngrok requires it for TCP tunnels

## Run
```bash
docker compose up
```

## Stop
```bash
docker compose down
```
## To find your server's ngrok tunnel IP

```bash
curl http://localhost:4040/api/tunnels
```

## Accessing Server commands
The server has RCON by default so we can access the cli by running:
```bash
docker exec -i [CONTAINER-NAME] rcon-cli
```
From here we can use other commands
```bash
/say hello server world
```
