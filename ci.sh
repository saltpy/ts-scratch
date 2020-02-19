#!/usr/bin/env bash

set -e

NAME=$(cat package.json | jq -r ".name")
VERSION=$(cat package.json | jq -r ".version")

echo "Build & Validate the javascript app"
yarn install
yarn lint
yarn tsc
yarn test
yarn build

echo "Make sure the test harness is running"
kubectl apply -f tenv/selenium-hub-deployment.yaml
kubectl apply -f tenv/selenium-hub-svc.yaml

echo "Build the integration test suite"
pylint features/steps/*.py
docker build --tag saltpy/integration --file integration/Dockerfile .
docker push saltpy/$NAME-integration

echo "Build & Validate the server"
docker build --tag saltpy/$NAME:$VERSION --file srv/Dockerfile .
docker push saltpy/$NAME:$VERSION
kubectl apply -f srv/ts-scratch-deployment.yaml
kubectl apply -f srv/ts-scratch-svc.yaml
kubectl delete jobs/integration
kubectl apply -f integration/integration-job.yaml
