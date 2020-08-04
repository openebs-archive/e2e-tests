## About the experiment

- This functional test verifies the zfs-localpv shared mount volume support via multiple pods. Applications who wants to share the volume can use the storage-class as below.

```
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: openebs-zfspv
parameters:
  shared: "yes"
  fstype: "zfs"
  poolname: "< zpool_name >"
provisioner: zfs.csi.openebs.io
```
Note: For running this experiment above storage-class should be present. This storage will be created as a part of zfs-localpv provisioner experiment. If zfs-localpv components are not deployed using e2e-test script located at `e2e-tests/providers/zfs-localpv-provisioiner` please make sure you create the storage class from above mentioned yaml.

## Supported platforms:

K8S : 1.17+

OS : Ubuntu 18.04, Ubuntu 16.04, CentOS 7, CentOS 8

ZFS : 0.7, 0.8

ZFS-LocalPV version: 0.8+

## Entry-Criteria

- K8s cluster should be in healthy state including all the nodes in ready state.
- zfs-controller and node-agent daemonset pods should be in running state.
- storage class with `shared: yes` enabled should be present.

## Steps performed in this experiment:

1. First deploy the busybox application using `shared: yes` enabled storage-class
2. Then we dump some dummy data into the application pod mount point.
3. Scale the busybox deployment replicas so that multiple pods (here replicas = 2) can share the volume.
4. After that data consistency is verified from the scaled application pod in the way that data is accessible from both the pods and after restarting the application pod data consistency should be maintained.

## How to run

- This experiment accepts the parameters in form of job environmental variables.
- For running this experiment of zfspv-shared-mount volume creation, clone openens/e2e-tests repo and then first apply the rbac and crds.
```
kubectl apply -f e2e-tests/hack/rbac.yaml
kubectl apply -f e2e-tests/hack/crds.yaml
```
then update the needed test specific values in run_litmus_test.yml file and create the kubernetes job.

## Experiment job env's

| Parameters    | Description                                            |
| ------------- | ------------------------------------------------------ |
| APP_NAMESPACE | Namespace where application and volume is deployed.    |
| OPERATOR_NAMESPACE  | Namespace in which all the resources created by zfs driver will be present for e.g. zfsvolume (zv) will be in this namespace |
| STORAGE_CLASS| Storage class will be created with this name |
| APP_PVC | Application pvc name  |
| ACTION     | provision the volume or deprovision the volume                     |
| DATA_PERSISTENCE | Data accessibility & integrity verification by dumping some test data into the application and verify if later. To check against busybox set value: "busybox"|