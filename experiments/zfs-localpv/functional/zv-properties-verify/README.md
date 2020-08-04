## About this experiment

This experiment verifies that zvolume properties are same as set via the stoarge-class.

## Supported platforms:

K8S : 1.14+

OS : Ubuntu 18.04, Ubuntu 16.04, CentOS 7, CentOS 8

ZFS : 0.7, 0.8

ZFS-LocalPV version: 0.2+

## Entry-Criteria

- K8s cluster should be in healthy state including all the nodes in ready state.
- zfs-controller and node-agent daemonset pods should be in running state.

## Steps performed

- Get the zvolume name and the storage class name by which volume was provisioned.
- After that following properties are verified to be same from zvol properties as well as from storage class.
  1. File-system type
  2. Compression
  3. Dedup
  4. Recordsize / volblocksize

## How to run

- This experiment accepts the parameters in form of job environmental variables.
- For running this experiment of zfspv-clone creation, clone openens/e2e-tests repo and then first apply the rbac and crds.
```
kubectl apply -f e2e-tests/hack/rbac.yaml
kubectl apply -f e2e-tests/hack/crds.yaml
```
then update the needed test specific values in run_litmus_test.yml file and create the kubernetes job.

## Experiment job env's

| Parameters    | Description                                            |
| ------------- | ------------------------------------------------------ |
| APP_NAMESPACE | Namespace where application and volume is deployed.    |
| OPERATOR_NS   | Namespace in which all the resources created by zfs driver will be present for e.g. zfsvolume (zv) will be in this namespace |
| APP_PVC | Application pvc name  |
