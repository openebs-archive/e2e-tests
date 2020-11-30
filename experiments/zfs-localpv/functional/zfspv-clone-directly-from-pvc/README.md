## About this experiment

This experiment creates the clone directly from the volume as datasource and use that cloned volume for some application. This experiment verifies that clone volume should have the same data for which snaphsot was taken and this data should be easily accessible from some new application when this clone volume is mounted on it.

## Supported platforms:

K8S : 1.17+

OS : Ubuntu 18.04, Ubuntu 16.04, CentOS 7, CentOS 8

ZFS : 0.7, 0.8

ZFS-LocalPV version: v1.1.0+

## Entry-Criteria

- K8s cluster should be in healthy state including all the nodes in ready state.
- zfs-controller and node-agent daemonset pods should be in running state.
- size for the clone-pvc should be equal to the original pvc.

## Steps performed

This experiment consist of provisioning and deprovisioing of zfspv-clone but performs one task at a time based on ACTION env value < provision or deprovision >.

Provision:

- Create the clone by applying the pvc yaml with parent pvc name in the datasource.
- Verify that clone-pvc gets bound.
- Deploy new application and verifies that clone volume gets successully mounted on application.
- Verify the data consistency that it should contain the same data as of volume snapshot.

Deprovision:

- Delete the application which is using the cloned volume.
- Verify that clone pvc is deleted successfully.
- Verify that zvolume is deleted successfully.

## How to run

- This experiment accepts the parameters in form of job environmental variables.
- For running this experiment of zfspv-clone-from-pvc creation, clone openens/e2e-tests repo and then first apply the rbac and crds.
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
| STORAGE_CLASS| Storage class name by which original volume was provisioned |
| PARENT_PVC_NAME | This parent pvc name will be used as datasource for clone creation  |
| CLONED_PVC_NAME |Cloned pvc will be created by this name in the same namespace where spapshot is present |
| CLONE_PVC_SIZE | clone PVC size should match the size of the snapshot  |
| APP_NAME       | Provide the application name which will be deployed using cloned PVC. Supported values are: `busybox` and `percona` |
| APP_LABEL     | Label name of the application                     |
| DATA_PERSISTENCE | Data accessibility & integrity verification by dumping some test data into the application and verify if later. To check against busybox set value: "busybox" and for percona, set value: "mysql". Only supported for busybox and percona application, for other application leave this env blank.|

