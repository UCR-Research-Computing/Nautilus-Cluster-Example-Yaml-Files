#!/bin/sh

namedefault="test"
imagedefault="gitlab-registry.nautilus.optiputer.net/prp/jupyterlab:latest"
cmddefault="bash"

name=${1:-$namedefault}
image=${3:-$imagedefault}
cmd=${2:-$cmddefault}

if kubectl get pods --no-headers --selector=job-name=$name 2>/dev/null | grep $name
  then
    echo "Job with that name found"
    kubectl delete job $name
    name="tempjob"
  else
    true
fi

cat <<EOF | kubectl apply -f -
apiVersion: batch/v1
kind: Job
metadata:
  name: $name
spec:
  template:
    spec:
      containers:
      - name: blast
        image: $image
        command: ["sleep", "infinity"]
        volumeMounts:
        - mountPath: /sharedvol
          name: sharedvol
        resources:
          limits:
            memory: 6Gi
            cpu: "4"
          requests:
            memory: 2Gi
            cpu: "1"
      volumes:
      - name: sharedvol
        persistentVolumeClaim:
          claimName: master-vol
      - name: git-repo
        emptyDir: {}
      restartPolicy: Never
  backoffLimit: 1
EOF

podname=$(kubectl get pods --no-headers --selector=job-name=$name | awk '{print $1}')
echo $podname

until kubectl get pods --no-headers $podname | grep "Running"
do
  kubectl get pods --no-headers $podname
  sleep 1
done
kubectl exec -it $podname $cmd
kubectl delete job $name
