#!/bin/bash

programName=$0
function usage {
    echo ""
    echo "Connect to a Docker container via sFTP"
    echo ""
    echo "usage: $programName --cid string "
    echo ""
    echo "  --cid string  container id (example: fe5780b2c44d)"
    echo ""
}

function die {
    printf "Script failed: %s\n\n" "$1"
    exit 1
}

while [ $# -gt 0 ]; do
    if [[ $1 == "--"* ]]; then
        v="${1/--/}"
        declare "$v"="$2"
        shift
    fi
    shift
done

#RUN
if [[ -z $cid ]]; then
    usage
    die "Missing parameter --cid"
fi

containerName=$(docker inspect --format '{{.Name}}' "$cid" | sed 's/^\/\(.*\)/\1/')
echo "Start sftp-docker for container: $containerName"

workdirPath="/home/sftp-docker"

docker cp "docker-fs/sftp-docker" "$cid:$workdirPath"
if [ $? -ne 0 ]; then
    echo "Failed to copy files to container ID: $cid"
    exit 1
fi
docker exec "$cid" chmod -R +x "$workdirPath"

docker exec "$cid" "$workdirPath/setup_sftp.sh"

# Check if the chmod command was successful
if [ $? -ne 0 ]; then
    echo "Failed to change file permissions in container ID: $cid"
    exit 1
fi

ipAddress=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' "$cid")
if [ -z "$ipAddress" ]; then
    networkMode=$(docker inspect --format '{{ .HostConfig.NetworkMode }}' "$cid")
    if [ "$networkMode" = "host" ]; then
      ipAddress="127.0.0.1"
    else
        echo "ERROR: Can not determinate ipAddress of container. Check its network"
    fi
fi
ssh-keygen -f "$HOME/.ssh/known_hosts" -R "$ipAddress"

echo "Sftp-docker finished."
echo "ADDRESS : sftp://root@$ipAddress"
echo "PASSWORD: root"

