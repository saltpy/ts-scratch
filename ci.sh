#!/usr/bin/env bash

set -e

NAME=$(cat package.json | jq -r ".name")
VERSION=$(cat package.json | jq -r ".version")

yarn install
yarn lint
yarn tsc
yarn test
yarn build
docker build --tag saltpy/$NAME:$VERSION --file srv/Dockerfile .
