# JuiceFS Background Client Container

This project provides a Docker container that acts as a background client for JuiceFS, performing tasks such as backups. It is designed to run as a background service and is not intended for other purposes.

---

## 🚀 Getting Started

### Prerequisites
- **Existing JuiceFS environment**

---

## 🛠️ Building the Docker Image

To build the Docker image yourself, run the following command:
Please specify the needed JuiceFS version with the JFS_VERSION_TAG

```bash
docker build --build-arg JFS_VERSION_TAG=<version> -t juicefs-bgclient .
```

Alternatively, you can pull the pre-built image from Docker Hub:

```bash
docker pull pondi/juicefs-bgjob:<version>
```

---

## ✅ Pre-built Versions

The following JuiceFS versions are pre-built on Docker Hub:

- **1.0.7**
- **1.1.1**
- **1.1.2**
- **1.1.3**
- **1.1.4**
- **1.1.5**
- **1.1.6**
- **1.2.0**
- **1.2.1**
- **1.2.2**
- **1.2.3

---

## 🏃 Running the Container

To run the container, use the following command:

```bash
docker run -d \
  -e JUICEFS_MOUNTSTRING="<your_juicefs_mountstring>" \
  -e TZ="<your_timezone>" \
  -e USAGE_REPORT="<optional_usage_report_flag>" \
  -e CACHE_SIZE="<optional_cache_size>" \
  -e BACKUP_META="<optional_backup_meta>" \
  pondi/juicefs-bgjob:<version>
```

---

## 🌐 Environment Variables

- `JUICEFS_MOUNTSTRING` (required): The mount string for JuiceFS. Refer to the JuiceFS documentation for details.
- `TZ` (optional): Timezone to set inside the container (e.g., UTC, America/New_York).
- `USAGE_REPORT` (optional): Set to any value to disable usage reporting.
- `CACHE_SIZE` (optional): Size of the cache (e.g., 100M, 1G).
- `BACKUP_META` (optional): Backup metadata interval (e.g., 1h, 30m, 1h30m).

---

## 🗂️ Default Mount Point

The default mount point inside the container is `/mnt/juicefs`.

---

## 📄 License

This project is licensed under the MIT License. See the `LICENSE` file for details.

---

## 📞 Support

For support or request for other variables, please open an issue in this GitHub repository.
