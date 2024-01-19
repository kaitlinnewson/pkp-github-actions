#!/bin/bash


set -e

# Search for composer.json files, and run Composer to install the dependencies.
find . -maxdepth 4 -name composer.json -exec bash -c 'composer --no-ansi --working-dir="`dirname {}`" install --optimize-autoloader' ";"

# Install node modules
npm i g -npm
npm i @vue/cli-service
npm i cypress
npm install
npm run build
