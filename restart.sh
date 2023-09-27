#!/bin/bash

echo -e "\033[1;32m \033[41m Updating... \033[0m"
git fetch --all
git reset --hard origin/master
git pull

echo -e "\033[1;32m \033[41m Granting rights to bsh scripts... \033[0m"
# git submodule update --remote --merge
git submodule update --init --recursive
chmod +x restart.sh

echo -e "\033[1;32m \033[41m Launching a project... \033[0m"
make up