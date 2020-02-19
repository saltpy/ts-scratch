#!/usr/bin/env bash

set -e

kubectl apply --filename=selenium-hub-deployment.yaml
kubectl apply --filename=selenium-hub-svc.yaml
export NODEPORT=`kubectl get svc --selector='app=selenium-hub' --output=template --template="{{ with index .items 0}}{{with index .spec.ports 0 }}{{.nodePort}}{{end}}{{end}}"`
export NODE=`kubectl get nodes --output=template --template="{{with index .items 0 }}{{.metadata.name}}{{end}}"`

curl http://$NODE:$NODEPORT

kubectl create --filename=selenium-node-chrome-deployment.yaml
