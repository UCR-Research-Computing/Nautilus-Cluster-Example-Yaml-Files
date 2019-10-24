#!/bin/bash

hostname
kubectl get pods
kubectl create -f $@ 
kubectl create -f .yaml-file
