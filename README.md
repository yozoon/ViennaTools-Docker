# Pre-Configured Docker Image for Creating Applications that use ViennaTools

```bash
# Build the image
docker compose build --progress=plain

# Run the image
docker compose up

# Image Backup and Restore
docker save docker-viennaps:latest > viennaps.tar
docker load < viennaps.tar
```