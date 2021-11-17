#!/bin/bash
kubectl create secret generic registry-bookinfo --from-file=.dockerconfigjson=$HOME/.docker/config.json --type=kubernetes.io/dockerconfigjson
kubectl create secret generic bookinfo-prd-ratings-mongodb-secret --from-literal=mongodb-password=123456 --from-literal=mongodb-root-password=123456
kubectl create configmap bookinfo-prd-ratings-mongodb-initdb --from-file ~/app/ratings/databases/ratings_data.json --from-file ~/app/ratings/databases/script.sh
helm install -f ~/app/ratings/k8s/helm-values/values-bookinfo-prd-ratings-mongodb.yaml bookinfo-prd-ratings-mongodb bitnami/mongodb --version 10.28.4
helm install -f ~/app/ratings/k8s/helm-values/values-bookinfo-prd-ratings.yaml bookinfo-prd-ratings ~/app/ratings/k8s/helm