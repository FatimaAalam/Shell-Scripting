# Django Notes App Deployment

This Bash script automates the deployment of the **Django Notes App** using **Docker** and **NGINX** on an Ubuntu server.  
It handles cloning the code, installing dependencies, managing permissions, and running the app in containers.

---

## Features

- **Code cloning:** Automatically clones the Django Notes App repository if not already present.
- **Dependency installation:** Installs `docker.io`, `docker-compose`, and `nginx`.
- **Permissions & restarts:** Fixes Docker socket and project folder ownership to ensure smooth deployment.
- **Deployment:** Builds Docker image and runs the app using `docker compose up -d` or `docker-compose up -d`.
- **Error handling:** Stops execution and reports errors at each step.

---

## Requirements

- Ubuntu 20.04 / 22.04 LTS (or compatible)
- Git
- Bash shell
- Internet connection to clone the repo and download packages
- Docker and Docker Compose

---

## Usage

```bash
# Navigate to your script directory
cd ~/Shell-Scripting/projects/Django-Deployment

# Run the deployment script
./deploy-django-app.sh
```
## Deployment Overview

The script will automatically:

- Clone the Django app repository if not present
- Install required dependencies
- Fix permissions and perform necessary restarts
- Build and deploy the Docker container running the Django app
- Make the app accessible on the server's public IP

---

## Technologies Used

- **Django** – Python web framework  
- **Python** – Application language  
- **Docker & Docker Compose** – Containerization and orchestration  
- **NGINX** – Reverse proxy server  
- **Bash** – Automation scripting  
- **Linux / Ubuntu** – Operating system environment  

---

## Notes

- Ensure AWS/VM instance or local Ubuntu machine has enough disk space before running
- If dependencies are already installed, the script will skip reinstalling them
- Script can be rerun to update or redeploy the app safely
