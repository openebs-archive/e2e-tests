# OpenEBS v0.7 e2e job

This e2e job installs OpenEBS v0.7 on a e2e enabled cluster. This job first downloads the openebs-operator.yaml from the following link ```https://raw.githubusercontent.com/openebs/openebs/master/k8s/openebs-operator.yaml``` and cas template from ```https://raw.githubusercontent.com/openebs/openebs/master/k8s/openebs-pre-release-features.yaml``` and then scans the environment variables for explicitly passed image names. If any explicitly passed image name is found then it replaces the images present in operator yaml by explicitly passed image name. After replacing the image names it applies the operator and waits till all the pods to get into running state before exiting. 

### Prerequisites

-> The cluster should be e2e enabled.  
-> Admin context should be available. 

### Installing

-> Starting the openebs setup job :```kubectl apply -f e2ebook/openebs_setup.yaml```.
-> Deleting the setup job :```kubectl delete -f e2ebook/setup_setup.yaml```.
-> Starting the openebs cleanup job :```kubectl apply -f e2ebook/openebs_cleanup.yaml```.
-> Deleting the openebs cleanup job :```kubectl delete -f e2ebook/openebs_cleanup.yaml```.  


### Note:

Image names for openebs-operator can be explicitly passed by environment variable in the setup_openebs.yaml .
Example:
```
---
apiVersion: batch/v1
kind: Job
metadata:
  name: e2e-openebs-setup-v0.7
  namespace: e2e 
spec:
  template:
    metadata:
      name: e2e
    spec:
      serviceAccountName: e2e
      restartPolicy: Never
      containers:
      - name: ansibletest
        image: openebs/ansible-runner:ci
        imagePullPolicy: IfNotPresent
        env: 
          - name: mountPath
            value: /mnt/openebs
          - name: ANSIBLE_STDOUT_CALLBACK
            value: actionable
          - name: MAYA_APISERVER_IMAGE
            value:
          - name: OPENEBS_PROVISIONER_IMAGE
            value:
          - name: OPENEBS_SNAPSHOT_CONTROLLER_IMAGE
            value:
          - name: OPENEBS_SNAPSHOT_PROVISIONER_IMAGE
            value:
          - name: OPENEBS_IO_JIVA_CONTROLLER_IMAGE
            value:
          - name: OPENEBS_IO_JIVA_REPLICA_IMAGE
            value:
          - name: OPENEBS_IO_VOLUME_MONITOR_IMAGE
            value:
          - name: OPENEBS_IO_JIVA_REPLICA_COUNT
            value:
          - name: NODE_DISK_MANAGER_IMAGE
            value:
          - name: OPENEBS_IO_CAS_TEMPLATE_TO_LIST_VOLUME
            value:
        command: ["/bin/bash"]
        args: ["-c", "ansible-playbook ./operator/0.7/ansible/openebs_setup.yaml -i /etc/ansible/hosts -vv; exit 0"]
        volumeMounts:
          - name: kubeconfig 
            mountPath: /root/admin.conf
            subPath: admin.conf
          - name: logs
            mountPath: /var/log/ansible 
      volumes: 
        - name: kubeconfig
          configMap: 
            name: kubeconfig 
        - name: logs 
          hostPath:
            path: /mnt/openebs
            type: ""
```


#### Environment variables that can be used for passing image name to the job
-> MAYA_APISERVER_IMAGE
-> OPENEBS_PROVISIONER_IMAGE
-> OPENEBS_SNAPSHOT_CONTROLLER_IMAGE
-> OPENEBS_SNAPSHOT_PROVISIONER_IMAGE
-> OPENEBS_IO_JIVA_CONTROLLER_IMAGE
-> OPENEBS_IO_JIVA_REPLICA_IMAGE
-> OPENEBS_IO_VOLUME_MONITOR_IMAGE
-> OPENEBS_IO_JIVA_REPLICA_COUNT
-> NODE_DISK_MANAGER_IMAGE
-> OPENEBS_IO_CAS_TEMPLATE_TO_LIST_VOLUME