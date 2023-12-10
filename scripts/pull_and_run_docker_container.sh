
echo "$GHCR_PRIVATE_TOKEN" | docker login -u "$GHCR_USERNAME" --password-stdin ghcr.io

# Pull the Docker image from GitHub Container Registry
docker pull $DOCKER_IMAGE

# Stop and remove the existing container (if any)
docker stop smunoz-santiago-frontend-app || true
docker rm -f smunoz-santiago-frontend-app || true

docker rmi ghcr.io/munoz-santiago/munoz-santiago-repo/munoz-santiago-frontend-app || true
docker pull ghcr.io/munoz-santiago/munoz-santiago-repo/munoz-santiago-frontend-app

# Run the Docker container on the droplet
docker run -d --name smunoz-santiago-frontend-app -p 9001:80 \
    --network traefik_proxy \
    --label "traefik.http.routers.smunoz-santiago-frontend-app.rule=PathPrefix(\`/\`)" \
    ghcr.io/munoz-santiago/munoz-santiago-repo/munoz-santiago-frontend-app
