## USER DOCUMENTATION

This document explains how to use and operate the Inception Docker infrastructure as an end user or system administrator.

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

# Project explanation
As part of this project, LEMP stack is implemented. LEMP is an open-source web application stack used to develop web applications.
LEMP Stands For:
    L- Linux Operating System
    E- Nginx Server:  Web server acting as the single entrypoint using HTTPS (TLSv1.2/1.3).
    M- MySQL Database (represented by MariaDB): The relational database management system that stores the website's data.
    P- PHP (represented by WordPress): The programming language used to build dynamic web applications. Website and administration interface running with PHP-FPM.

# Start and stop of the project
In order to start the project, redirect to the root directory and run "make" command. This will build all Docker images (for all 3 services), create the Docker network and volumes with help of Docker compose functionality and start all the containers in the detached mode (so that you may still have access to the terminal on your host machine).

To stop the project run the commands:
- "make down" - it is similar to the command docker compose down - to stop the work of services. 
- "make clean" also removes all unused data, including stopped containers, dangling images and unused network.
- "make fclean" - it additionally removes volumes (i.e., deletes all website and database data) - so use this command carefully.

# Access to the web site
The main idea of the project is no just compose the Docker containers for LEMP stack but also to set up the web application using WordPress and then present the result. To access the application, open a browser (it's preferable to use Chromium browser) and redirect to the website: https://amelniko.42.fr.
The browser will displaye a warning related to that we are using a self-signed SSL certificate instead of using existing ones. As the browser doesn't know this kind of certificate, it warns the user to prevent accessing the malicious sites. To skip it, we need to expand Additional settings and redirect to the site.
If we attempt to connect to the site using non-secured connection (http connection), then the browser will just block this redirection (this is set up this way according to the requirements of the subject).

https://amelniko.42.fr - this is a general site of the application. In order to access to the WordPress Admin Panel (where some configurations may be done by the user depending on its privileges), redirect to https://amelniko.42.fr/wp-admin. To log in as an administrator, use the credentials saved in .env file. There is at least one another user created in the database (requirement of the subject) - its credentials are saved in secrets/credentials.txt file.

# Credentials
By the way, you will not find neither .env file, nor secrets directory in the project downloaded from the git. It is done deliberately according to the security measures. In order to get these files, request them from the project owner or reproduce those files on your own (if you know the credentials).
NOTE: normally, secrets' text files are also integrated into the Docker logic by the developer but for this project, credentials.txt was created just to store the essential credentials - it is not integrated unlike .env file.
You will have to input the credentials data to WordPress site manually.

# Services status
In order to verify that the project works fine, you may not only open the web app in the browser to see the result but also check the services status. For doing that, use command "docker ps" in the terminal - it will list the running containers. If there is any issue with the service, then the status will be set as "Resetting".
To better understand the error or to see the logs of the service, you may run "docker logs [service]".
To check the container "health" and some settings, you may run "docker inspect <container_name>".

It is also important to verify the data persistence locations in the host machine (mentioned in the subject). Directories db_data (wordpress database) and wp_data (wordpress files) are stored on the path /home/amelniko/data/ on the host machine.These Directories are Docker named volumes and persist even after container restarts.