#!/usr/bin/env bash

#######
# open issue https://github.com/microsoft/vscode-remote-release/issues/4024?ysclid=lbz6geepsn205383988
eval `ssh-agent -s`
find ~/.ssh/ -type f -exec grep -l 'PRIVATE' {} \; | xargs ssh-add

# #######
# if docker volume create --name eggshell-volume &> /dev/null; then
#   echo "Created volume eggshell-volume"
# else
#   echo "Failed to create volume eggshell-volume"
# fi

# docker network create eggshell-network &> /dev/null
# if [ "$?" -ne "0" ]; then
#   echo "Network eggshell-network already exists"
# else
#   echo "Created docker network eggshell-network"
# fi