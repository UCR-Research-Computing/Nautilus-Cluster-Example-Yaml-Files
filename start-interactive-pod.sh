#!/bin/bash

kubectl create -f $@ 
echo "kubectl get pods"
kubectl get pods
sleep 10
kubectl get pods
kubectl exec -it $(kubectl get pods | tail -1 | awk '{print $1}') bash
