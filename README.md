# Docker Flarum

![logo](https://i.imgur.com/Bjrtbsc.png)

This repository provides a stable and working `docker-compose` setup for Flarum, based on the popular `mondedie/flarum` configuration, updated and fixed for a modern Flarum environment in `kitbur/flarum` and forked by myself to have more control over the image.

This image was originally using Alpine 3.18 and PHP 8.2. Currently we are using PHP 8.4 and Alpine 3.22. Some documentation might still mention the old versions by accident.

## Tagged Releases

This repository fixes the Flarum version to use a stable version (currently v.1.8.1)

## Features

-   Multi-platform image: `linux/amd64`, `linux/arm64`
-   Lightweight & secure image based on **Alpine Linux 3.18**
-   **Nginx** and **PHP 8.2**
-   Configurable Flarum version
-   MariaDB driver
-   OPCache extension configured

### Ports

-   The container exposes port **8888** for Flarum. You can map this to any port on your host.

### Volumes

-   `/flarum/app/public/assets`: Flarum assets directory.
-   `/flarum/app/storage/logs`: Flarum logs directory.
-   `/flarum/app/extensions`: A control directory for managing extensions.
-   `/flarum/app/packages`: An optional volume for local [extender](https://docs.flarum.org/extend) development.

### Environment Variables

| Variable | Description | Type | Default value |
| -------- | ----------- | ---- | ------------- |
| **UID** | Flarum user id | *optional* | 991
| **GID** | Flarum group id | *optional* | 991
| **DEBUG** | Flarum debug mode | *optional* | false
| **FORUM\_URL** | **Your forum's public URL** | **required** | `http://localhost:8080`
| **DB\_HOST** | MariaDB instance ip/hostname | *optional* | `mariadb`
| **DB\_USER** | MariaDB database username | *optional* | `flarum`
| **DB\_NAME** | MariaDB database name | *optional* | `flarum`
| **DB\_PASS** | **MariaDB database password** | **required** | `some_secure_password`
| **DB\_PREF** | Flarum tables prefix | *optional* | none
| **DB\_PORT** | MariaDB database port | *optional* | 3306
| **FLARUM\_PORT** | Port to run Flarum on inside the container | *optional* | 8888
| **UPLOAD\_MAX\_SIZE** | The maximum size of an uploaded file | *optional* | 50M
| **PHP\_MEMORY\_LIMIT** | PHP memory limit | *optional* | 128M |
| **OPCACHE\_MEMORY\_LIMIT** | OPcache memory size in megabytes | *optional* | 128
| **LOG\_TO\_STDOUT** | Enable nginx and php error logs to stdout | *optional* | false
| **GITHUB\_TOKEN\_AUTH** | Github token to download private extensions | *optional* | false
| **PHP\_EXTENSIONS** | Install additional php extensions (space separated) | *optional* | none

### Required for First Installation

| Variable                | Description                   | Type       | Default value |
| ----------------------- | ----------------------------- | ---------- | ------------- |
| **FLARUM\_ADMIN\_USER** | **Name of your admin user** | **required** | `admin`         |
| **FLARUM\_ADMIN\_PASS** | **Admin user password** | **required** | `another_strong_password` |
| **FLARUM\_ADMIN\_MAIL** | **Admin user email address** | **required** | `admin@example.com` |
| **FLARUM\_TITLE** | Set the name of your forum    | *optional* | `My Flarum Forum` |

---

## Installation

#### 1. Clone The Repository

```bash
git clone https://github.com/hansmorb/docker-flarum.git
cd docker-flarum
```

#### 2. Create Your Local Configuration

Copy the example compose file to create your own local configuration.

```bash
cp docker-compose.yml.example docker-compose.yml
```
Edit the `environment:` section to set your own secure passwords, forum title, admin user, public URL, and any other configurations you want.

#### 3. Run It!

Build your Flarum image and start all services.

```bash
docker-compose up -d --build
```

#### 4. Log In

Your forum will be live at the `FORUM_URL` you configured. Visit the site and log in with your database credentials, as well as the `FLARUM_ADMIN_USER` and `FLARUM_ADMIN_PASS` you set in the `docker-compose.yml` file.

---

## License

This project is released under the [MIT License](LICENSE).