## About this experiment

This experiment creates the volume snapshot of zfs-localpv which can be used further for creating a clone. Snapshot will be created in the same namespace where application pvc is created. One thing need to be noted that this experiment scale down the application before taking the snapshot, it is done this way to create the application consistent volume snapshot. After creating the snapshot application will be scaled up again.

## Supported platforms:

K8S : 1.17+

OS : Ubuntu 18.04, Ubuntu 16.04, CentOS 7, CentOS 8

ZFS : 0.7, 0.8

ZFS-LocalPV version: 0.4+

## Entry-Criteria

- K8s cluster should be in healthy state including all the nodes in ready state.
- zfs-controller and node-agent daemonset pods should be in running state.
- Application should be deployed succesfully consuming the zfs-localpv storage.
- Volume snapshot class of zfs csi driver should be present to create the snapshot.

## Steps performed

This experiment consist of provisioning and deprovisioing of volume snapshot but performs one task at a time based on ACTION env value < provision or deprovision >.

Provision: 

- Check the application pod status, should be in running state.
- If DATA_PERSISTENCT check is enabled then dump some data into application pod mount point.
- Check if volume snapshot class is present.
- Scale down the application and wait till pod terminates successfully.
- Create the volume snapshot in the application namespace itself.
- Check the created snapshot resource and make sure readyToUse field is true.
- Scale up the application again.

Deprovision: 

- Check if no clone-pvc is using the snapshot.
- Delete the volume snapshot from the application namespace.
- Verify that volume snapshot content is no longer present.

## How to run

- This experiment accepts the parameters in form of job environmental variables.
- For running this experiment of snapshot creation, clone openens/e2e-tests repo and then first apply the rbac and crds.
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
| SNAPSHOT_CLASS| Name of zfspv volumesnapshotclass |
| SNAPSHOT_NAME | Snapshot will be created with this name in application namespace  |
| APP_PVC       | PersistentVolumeClaim Name for the application                     |
| APP_LABEL     | Label name of the application                     |
| DATA_PERSISTENCE | Data accessibility & integrity verification by dumping some test data into the application and verify if later. To check against busybox set value: "busybox" and for percona, set value: "mysql". Only supported for busybox and percona application, for other application leave this env blank.|


