## DEVELOPPER DOCUMENTATION
This document describes how developers can set up, build, manage, and extend the Inception infrastructure.

# Prerequisites
Install required tools:

- Docker
- Docker Compose
- GNU Make
- Virtual Machine (as required by project)

Verify installation:

docker --version
docker compose version
make --version

The project sctructure must look like this:
.
├── Makefile
├── secrets/
├── srcs/
│   ├── .env
│   ├── docker-compose.yml
│   └── requirements/
│       ├── nginx/
│       ├── wordpress/
│       ├── mariadb/
│       └── bonus/

# Secrets and credentials
To store the data related to the credentials, additional files will be required - .env file and secrets. Define the environment variables that you are going to use in the project's files in .env file but it's not recommended to store any credentials there as it may lead to the security risks. For all credentials, it's better to create a files in secrets directory. However, secrets files are more difficult to integrate into the code.
In order to integrate .env file into the project's services, it is required to mantion it in the service description in docker-compose.yml file line this:
    env_file: 
      - .env

For secrets, it is required to mention them both in the service setup and a separate element in docker-compose.yml:
(Example of the code)
services:
  myapp:
    image: myapp:latest
    secrets:
      - my_secret
secrets:
  my_secret:
    file: ./my_secret.txt

(For 42Inception project, the author decided not to use secrets integration as it's not Production).

# Configuration files
For some of the services, it is required to compose their own configuration files which will set up the proper settings for the service. For example, configuration file for the NGINX is required to maintain TLSv1.2/TLSv1.3 protocol to be implemented for the connections handled by the service.

# Build and launch the project
There are 2 ways to build and launch the project. It can be done directly with docker compose commands from the directory where docker-compose.yml file is located. Another option is to write a Makefile which will have a proper configurations for build and stop/destruction of the project.
To build the project the command "docker compose --build -d up" is used. If you are trying to build and launch project outside of the directory with the yml file, it's possible to define the PATH to it directly in the command with -f flag.
To stop the containers, command "docker compose down" is used.
It is also possible to indicate an accurate service that you would like to build/stop by adding its name in the command.

# Some other useful commands

Container management
- docker ps - to list all currently running containers. Add -a flag if you want to see also the stopped containers.
- docker stop <container_name> - to gracefully stop a running container.
- docker start <container_name> - to start a previously stopped container.
- docker restart <container_name> - to restart a container. Useful after changing the configuration files.
- docker rm <container_name> - to remove a stopped container (doesn't delete volumes).
- docker logs <container_name> - to display the container logs. Crucial for debbuging and monitoring of errors.
- docker exec -it <container_name> [execution line] - to run the execution line (command or multiple commands) inside a running container for inspection or debugging. By adding sh instead of [execution line], you ensures to open an interactive shell inside a container.

Image management
- docker images - to list all locally built Docker images.
- docker rmi <image_name> - to remove and image.
- docker compose build - to build/rebuild all images defined in docker-compose.yml file. By adding the <service_name> in the end, you may specify for which service you would like to build/rebuild the image.

Volume management
- docker volume ls - to list all Docker volumes on the system.
- docker volume inspect <volume_mane> - to show detailed information about a volume, icnluding mountpoint path on the host (if identified).
- docker volume rm <volume_name> - to delete a volume. ATTENTION!: this permanently removes stored data.
- docker system prune --volumes - to clean unused containers, networks, images and volumes. Useful for freeing disk space.

Network management
- docker network ls - to list all Docker networks.
- docker network inspect <network_name> - to display network configuration and connected containers.

# Project data
According to the subject of this project, the volumes must be available in the /home/<login>/data folder of the host machine. This allows to persist the data even after the deletion or restart of the containers.
Project data is saved in 2 volumes:
- db_data (wordpress database)
- wp_data (wordpress files)