#!/bin/bash

RANDOMIZER=$(uuid | cut -b-5)
POD_NAME="bash-shell-$RANDOMIZER"
IMAGE=ubuntu

kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: $POD_NAME
spec:
  containers:
  - name: $POD_NAME
    image: $IMAGE
    command: ["/bin/bash"]
    args: ["-c", "while true; do date; sleep 5; done"]
  hostNetwork: true
  dnsPolicy: Default
  restartPolicy: Never
EOF

echo "---------------------------------"
echo "| Press ^C when pod is running. |"
echo "---------------------------------"

kubectl get pod $POD_NAME -w

echo

kubectl exec -it $POD_NAME -- /bin/bash

kubectl delete pod $POD_NAME
