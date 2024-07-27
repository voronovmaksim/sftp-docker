# SFTP Docker

## What is this?
**SFTP Docker** is a simple BASH script for setting up an SFTP server inside an existing Docker container.

## Who is this for?
Connecting to a Docker container using SFTP can be beneficial for developers working with files within the container. For instance, if you’re developing a web application and need to upload files to the server, you can use SFTP to access the container and transfer files from your local development environment.

## Usage
Clone the repository and perform `./run.sh --cid <CONTAINER-ID>`.
After running the script, you will be able to connect to your Docker container using the following credentials:
````
ADDRESS : sftp://root@<CONTAINER-IP-ADDR>
PASSWORD: root
````

## Limitations and Caution
- This script is intended for development purposes only. It set the password for the root user to 'root' using the command `echo 'root:root' | chpasswd`.
- The script currently only supports Docker images that use the `apt` package manager.
- It has been tested on Docker version 27.0.3.
  
# Disclaimer
This script was not originally intended for public release; it was created quickly to meet my requirements. As a result, it has limitations and potential security concerns.
If this script is of interest to the community, I am open to adding new features and fixing bugs. Please feel free to create an issue or submit a pull request.
I am going to add new features when force new requirements.