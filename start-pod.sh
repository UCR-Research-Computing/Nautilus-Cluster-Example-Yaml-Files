#!/bin/bash

kubectl get pods
kubectl create -f $@ 
echo "kubectl get pods"
watch "kubectl get pods"
