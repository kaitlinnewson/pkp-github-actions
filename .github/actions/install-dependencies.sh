#!/bin/bash

php -v
composer --version
set -e

# Search for composer.json files, and run Composer to install the dependencies.
composer_output=$(find . -maxdepth 4 -name composer.json -exec bash -c 'composer --no-ansi --working-dir="`dirname {}`" install --optimize-autoloader' ";")
echo $composer_composer_output
exit 1


sudo npm cache clean -f
sudo npm install -g n
sudo n  $NODE_VERSION
source ~/.bashrc

# Install node modules
npm i g -npm
if [[ "$NODE_VERSION" -gt "13"  ]]; then
npm i @vue/cli-service
npm i cypress@12.17.4
fi
npm install
npm run build
