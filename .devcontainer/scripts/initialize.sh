#!/usr/bin/env bash

#######
find ~/.ssh/ -type f -exec grep -l 'PRIVATE' {} \; | xargs ssh-add

#######
if docker volume create --name eggshell-volume &> /dev/null; then
  echo "Created volume eggshell-volume"
else
  echo "Failed to create volume eggshell-volume"
fi

docker network create eggshell-network &> /dev/null
if [ "$?" -ne "0" ]; then
  echo "Network eggshell-network already exists"
else
  echo "Created docker network eggshell-network"
fi