#!/bin/bash

loadEnv() {
  local envFile="${1?Missing environment file}"
  local environmentAsArray variableDeclaration
  mapfile environmentAsArray < <(
    grep --invert-match '^#' "${envFile}" \
      | grep --invert-match '^\s*$'
  ) # Uses grep to remove commented and blank lines
  for variableDeclaration in "${environmentAsArray[@]}"; do
    export "${variableDeclaration//[$'\r\n']}" # The substitution removes the line breaks
  done
}

loadEnv .env.prod

echo -e "\033[1;32m Updating...\033[1;32m"
git fetch --all
git reset --hard origin/main
git pull

echo -e "\033[1;32m \033[41m Granting rights to bsh scripts... \033[0m"
# git submodule update --remote --merge
git submodule update --recursive
chmod +x restart.sh
chmod +x ./docker/certbot/run.sh
chmod +x ./docker/certbot/gen-ssl.sh

echo -e "\033[1;32m \033[41m Getting a wildcard certificate... \033[0m"
./docker/certbot/run.sh $DOMAIN $CLOUDFLARE_API_KEY $CLOUDFLARE_EMAIL

echo -e "\033[1;32m \033[41m Launching a project... \033[0m"
make up