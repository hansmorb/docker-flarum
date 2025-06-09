# Upgrading Your Flarum Instance

- [Official Flarum Update Docs](https://docs.flarum.org/update/)

This project gives you full control over your Flarum version by allowing you to rebuild the Docker image with new dependencies.

---

## Applying an Upgrade

Here is the general workflow for upgrading your Flarum instance.

### 1. Edit Your `Dockerfile`

1.  **Update the Flarum Version:** Change the `FLARUM_VERSION` build argument in your `docker-compose.yml`.

    ```yaml
    args:
      - FLARUM_VERSION=^2.0
    ```

2.  **Add PHP Extensions (if required):** Add it to the `apk add` list in your `Dockerfile`.

    ```dockerfile
    RUN apk add --no-progress --no-cache \
        # ...
        php82-some-new-extension \
        # ...
    ```

### 2. Rebuild the Docker Image

Backup your database before rebuilding.

```bash
docker-compose down -v
docker-compose up --build -d
```

### 3. Run Post-Upgrade Commands

```bash
# Run Flarum database migrations
docker compose exec flarum php flarum migrate

# Clear the Flarum cache
docker compose exec flarum php flarum cache:clear
```

Your forum is now upgraded.