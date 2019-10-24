# using-nautilus-cluster


### basic commmands

```bash

kubectl get pods
kubectl create -f <yaml-file>
kubectl delete pods <pod-name>

kubectl exec -it <pod-name> bash
kubectl port-forward <pod-name> 8888:8888

```


### Starting Jupyter

Use the tensorflow-cpu-pod.yaml or tensorflow-gpu-pod.yaml file to start the pod

```bash

kubectl create -f tensorflow-gpu-pod.yaml
kubectl exec -it gpu-pod-example bash

jovyan@gpu-pod-example:~$ jupyter notebook --ip='0.0.0.0'

kubectl port-forward gpu-pod-example 8888:8888

```

- open browser to localhost:8888 and paste in the token from the jupyter notebook start command
