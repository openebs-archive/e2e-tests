## About this experiment

This experiment verifies the volume resize feature of zfs-localpv. For resize the volume we just need to update the pvc yaml with desired size and apply it. One thing need to be noted that volume resize can only be done from lower pvc size to higher pvc size. We can not resize the volume from higher pvc size to lower one. zfs driver supports online volume expansion, so that for using the resized volume application pod restart is not required. For resize, storage-class which will provision the pvc should have `allowVolumeExpansion: true`.
for e.g.

```
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: openebs-zfspv
allowVolumeExpansion: true
parameters:
  poolname: "zfspv-pool"
provisioner: zfs.csi.openebs.io
```

## Supported platforms:

K8S : 1.16+

OS : Ubuntu 18.04, Ubuntu 16.04, CentOS 7, CentOS 8

ZFS : 0.7, 0.8

ZFS-LocalPV version: 0.5+

## Entry-criteria

- K8s cluster should be in healthy state including all the nodes in ready state.
- zfs-controller and node-agent daemonset pods should be in running state.
- storage class with `allowVolumeExpansion: true` enabled should be present.
- Application should be deployed succesfully consuming the zfs-localpv storage.

## Exit-criteria

- Volume should be resized successfully and application should be accessible seamlessly.
- Application should be able to use the new space.

## How to run

This experiment is located at path `e2e-tests/experiments/functional/csi-volume-resize`. 
- This experiment accepts the parameters in form of job environmental variables.
- For running this experiment of zfspv-shared-mount volume creation, clone openens/e2e-tests repo and then first apply the rbac and crds.
```
kubectl apply -f e2e-tests/hack/rbac.yaml
kubectl apply -f e2e-tests/hack/crds.yaml
```
then update the needed test specific values in run_litmus_test.yml file and create the kubernetes job.