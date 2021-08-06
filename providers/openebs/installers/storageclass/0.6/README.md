# OpenEBS v0.6 storageclass job

This e2e job installs openebs storage pool and openebs storage class for openebs jiva v0.6. By default this job creates a storage pool with name *openebs-mntdir* and storage class with name *openebs-storageclass* and uses the following yaml jinja template.

*StorageClass.yaml*

```
---
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
   name: "{{ lookup('env','STORAGECLASS_NAME') }}"
provisioner: openebs.io/provisioner-iscsi
parameters:
  openebs.io/storage-pool: "{{ lookup('env','STORAGE_POOL_NAME') }}"
  openebs.io/jiva-replica-count: "{{ lookup('env','JIVA_REPLICA_COUNT') }}"
  openebs.io/volume-monitor: "{{ lookup('env','VOLUME_MONITOR') }}"
  openebs.io/capacity: {{ lookup('env','CAPACITY') }}
```

*StoragePool.yaml*

```
---
apiVersion: openebs.io/v1alpha1
kind: StoragePool
metadata:
    name: {{ lookup('env','STORAGE_POOL_NAME') }}
    type: hostdir
spec:
    path: "{{ lookup('env','STORAGE_PATH') }}"
```

### Prerequisites

-> The cluster should be e2e enabled.  
-> Openebs v0.6 operator must be installed.  

### Installing

-> Starting storageclass_setup job :```kubectl apply -f e2ebook/storageclass_setup.yaml```.  
-> Deleting storageclass_setup job :```kubectl delete -f e2ebook/storageclass_setup.yaml```.  
-> Starting storageclass_cleanup job :```kubectl apply -f e2ebook/storageclass_cleanup.yaml```.  
-> Deleting storageclass_cleanup job :```kubectl apply -f e2ebook/storageclass_cleanup.yaml```.  

### Note:

Some storage class and storage pool artifacts can be passed explicitly by changing the environment variables.

Example:

```
---
apiVersion: batch/v1
kind: Job
metadata:
  name: e2e-storageclass-setup-jiva-v0.6-setup
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
          - name: STORAGE_POOL_NAME
            value: openebs-mntdir
          - name: STORAGECLASS_NAME
            value: openebs-storageclass
          - name: STORAGE_PATH
            value: /var/openebs
          - name: JIVA_REPLICA_COUNT 
            value: 3
          - name: CAPACITY 
            value: 5Gi
          - name: VOLUME_MONITOR 
            value: true
        command: ["/bin/bash"]
        args: ["-c", "ansible-playbook ./storageclass/0.6/ansible/storageclass_setup.yaml -i /etc/ansible/hosts -vv; exit 0"]
```


#### Environment variables that can be used for passing storage pool and storage class artifacts
-> STORAGE_POOL_NAME  
-> STORAGE_PATH  
-> STORAGECLASS_NAME  
-> JIVA_REPLICA_COUNT  
-> CAPACITY
-> VOLUME_MONITOR
