## About this experiment

This experiment verifies the provision and deprovision of raw block volumes by zfs-localpv. There are some specialized applications that require direct access to a block device because, for example, the file system layer introduces unneeded overhead. The most common case is databases, which prefer to organize their data directly on the underlying storage. In this experiment we are not using any such application for testing, but using a simple busybox application to verify successful provisioning and deprovisioning of raw block volume.

To provisione the Raw Block volume, we should create a storageclass without any fstype as Raw block volume does not have any fstype.

```
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: zfspv-block
  allowVolumeExpansion: true
  parameters:
    poolname: "zfspv-pool"
    provisioner: zfs.csi.openebs.io
```    
Note: For running this experiment above storage-class should be present. This storage class will be created as a part of zfs-localpv provisioner experiment. If zfs-localpv components are not deployed using e2e-test script located at `e2e-tests/experiment/zfs-localpv/functional/zfs-localpv-provisioiner` please make sure you create the storage class from above mentioned yaml.

## Supported platforms:

K8S : 1.14+

OS : Ubuntu 18.04, Ubuntu 16.04, CentOS 7, CentOS 8

ZFS : 0.7, 0.8

ZFS-LocalPV version: 0.7+

## Entry-Criteria

- K8s cluster should be in healthy state including all the nodes in ready state.
- zfs-controller and node-agent daemonset pods should be in running state.
- storage class without any fstype should be present.

## Steps performed

- deploy the busybox application with given a devicePath.
- verify that application pvc gets bound and application pod is in running state.
- dump some data into raw block device and take the md5sum of data.
- restart the application and verify the data consistency.

## How to run

- This experiment accepts the parameters in form of job environmental variables.
- For running this experiment of raw block volume creation, clone openens/e2e-tests repo and then first apply the rbac and crds.
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