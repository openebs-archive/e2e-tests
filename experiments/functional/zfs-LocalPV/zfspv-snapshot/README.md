## Experiment Metadata

| Type       | Description                                             | Applications | K8s Platform and OS |
| ---------- | --------------------------------------------------------| -------      | ------------ |
| Functional | Creation of volume snapshot of zfs persistent volume    | Any          | K8s 1.14 + and Ubuntu 18.04          |

## Entry-Criteria

- K8s nodes should be ready.
- Application should be deployed succesfully consuming the ZFS-localPV storage.
- Volume snapshot class of zfs csi drivers should be present to create the snapshot.

## Exit-Criteria

- Volume snapshot should be created succesfully and it should be in ready state to be used further for clone creations.

## Notes

- This functional test checks if the volume snapshot can be created successfully for a given pvc.
- This litmusbook accepts the parameters in form of job environmental variables.
- For running this litmus experiment of snapshot creation update the needed test specific values in run_litmus_test.yml file and create the kubernetes job.


## Litmusbook Environment Variables

| Parameters    | Description                                            |
| ------------- | ------------------------------------------------------ |
| APP_NAMESPACE | Namespace where application and volume is deployed.    |
| OPERATOR_NS   | Namespace in which all the resources created by zfs driver will be present for e.g. zfsvolume (zv) will be in this namespace |
| SNAPSHOT_CLASS| Name of zfspv volumesnapshotclass |
| SNAPSHOT_NAME | Snapshot will be created with this name in application namespace  |
| APP_PVC       | PersistentVolumeClaim Name for the application                     |
| APP_LABEL     | Label name of the application                     |
| DATA_PERSISTENCE | Data accessibility & integrity verification by dumping some test data into the application and verify if later. To check against busybox set value: "busybox" and for percona, set value: "mysql"|

