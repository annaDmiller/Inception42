This project has been created as part of the 42 curriculum by <amelniko>

Description:
This project's aim is to broaden the student's knowledge and skills in system administration by using Docker and
to get acknowledged with Docker functionality. It is required to use the VM for the project where Docker will be
installed.

As part of the project, a LEMP stack implementation is done. LEMP is an open-source web application stack used
 to develop web applications.
LEMP Stands For:
    L- Linux Operating System
    E- Nginx Server:  The web server software that handles HTTP requests.
    M- MySQL Database (represented by MariaDB): The relational database management system that stores the
     website's data.
    P- PHP (represented by WordPress): The programming language used to build dynamic web applications.

All parts of LEMP stack are composed as a separate container and connected via Docker network sharing volumes.
It is required to create our own Dockerfiles for each container instead of using an existing solution to better
 understand the logic of building a full Docker image ready for build.


VM vs Docker
    VM is the emulation of a whole physical computer including hardware components and network interfaces. Each VM
 runs its own OS which is fully isolated from host machine and other VMs.
    Docker is a solution of virtualization as well. Containers created with Docker are lightweight, portable and
 scalable environments for running apps. They share the host machine's OS kernel and only include app-specific
 dependencies and libraries which allow to maintain them lightweight. But each container is well isolated from another
 and from host machine as well.

    Comparing VM and Docker, we can conclude that Docker containers require of lower resources for running (as they
 don't require the installation of full OS stack), they are set up faster than VM, high portable and can be spreaded
 to different platforms (with the same behavior of the app, no need to adapt), it's easier to maintain them than VM.
 However, containers have some secutiry concerns and vulnarabilities which may be used by attackers (for example,
 credentials in the code).


Secrets vs Environment variables
    Both terms are related with the security measures usually applied for Docker projects.
    Docker Compose provides a way for you to use secrets without having to use environment variables to store information.
 If you’re injecting passwords and API keys as environment variables, you risk unintentional information exposure. Services
 can only access secrets when explicitly granted by a secrets attribute within the services top-level element.
    Environment variables are often available to all processes, and it can be difficult to track access. They can also be
 printed in logs when debugging errors without your knowledge. Using secrets mitigates these risks.
    Environment variables have more of security leak risks but it's much easier to implement them into the project than
 secret files. Moreover, in order to use secret files, the app must be able to READ from file. For 42 project it is
 enough to use environment variables.
    It's a best practice to store all passwords and essential credentials in secrets especially when it comes to 
 Production. It's also forbidden to store .env or secret files in the cloud.


Docker Network vs Host Network
    Docker provides multiple networking types. The default networking is BRIDGE and another most common one is HOST.
    Bridge Network (default Docker network). Docker creates a virtual network bridge and assigns each container its own
 IP addresses so containers can communicate with each other over this bridge. This way the ports must be explicitly
 published to the host in the command (docker run -p 8080:80 my-app - The container’s port 80 is accessible on the host 
 at 8080). It provides good isolation for each container and it works fine with Docker compose so it is used for
 multi-container apps.
    Host Network means that the container shared the host's network stack directly. It leads that there is no separate
 IP for the container, no port mapping is required and the container listens on the host's network interfaces directly.
 This type of network provides higher performance comparing with Bridge one, and simplifies the networking for some use cases.
 But it leads to the risk of port conflicts and there is no network isolation. So Host Network most often is used when
 the performance is critical or by some reasons, we need to have direct access to the host networking.



Docker Volumes vs Bind Mounts
    There are 2 main ways to save the data ourside of the container: volumes and bind mounts.
    Docker volumes are docker-managed storage locations that live outside of the containers' system. They are stored in
 the Docker's internal data directory and can be easily reused and shared between containers. They are safer across
 environments as managed entirely by Docker, and work perfectly with Docker Compose or other orchestration tools.
    Bind Mounts is a direct mapping between a host directory or file and container path. To manage the data, the container
 reads/writes directly to the host filesystem so the changes are immediately applied on both sides (inside containter and
 at the host). This is perfect for debugging and allows to have easier access to the files on the host but it is less portable
 (the host path must exist) and there are higher risks of permission and security issues. So Bind Mounts are better for
 development but it's not recommended to use them in Production.




Instructions (after the project is cloned to the local machine):
1. The project is lack of .env file which contains all essential data related to credentials, important variables
    of database. In order to start any compilation it is required to create/copy the .env file into the /srcs
    directory. This file must contain at least such values: MYSQL_DATABASE, MYSQL_USER, MYSQL_PASSWORD,
    MYSQL_ROOT_PASSWORD, SERVER_NAME.
2. After the .env file is added, the user must run 'make' command in the root directory of the project to start
    compilation of all files (see Makefile). There, all the images are created and built, then all of containers
    are launched in one network based on the defined configurations. Make sure that the Docker and Docker compose
    are installed on the local machine before launching the compilation.
3. In order to verify the work of the web app open the web browser and redirect to https://amelniko.42.fr page. The
    browser may display a warning for this web app as it uses the self-signed cetificate for secure connection. This
    page will show the Inception blog. However, if the user wants to log in to the blog or manage it, the correct
    url is https://amelniko.42.fr/wp-admin. Multiple users are created for testing (their credentials are saved by the
    author of the solution).
4. For evaluation of the solution, follow the steps of evaluation sheet for the project.




Resources:
- Docker official web page
- Articles about Docker and its usage
- Articles about how to work with Docker and Docker terms
- NGINX official web page
- WordPress official web page
- Stack overflow posts about some errors related to Docker, NGINX, WordPress and MariaDB
- Articles about LEMP stack
- Tutorials of how to setup NGINX-WordPress-MariaDB in Docker
- AI (Perplexity) : it was used to better understand the theory of Docker (learning mode) as well as the help with
    configuration files and bash files for the services; some errors were analyzed with help of AI as well.
