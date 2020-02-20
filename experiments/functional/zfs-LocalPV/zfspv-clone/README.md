## Experiment Metadata

| Type       | Description                                                  | Applications | K8s Platform and OS| 
| ---------- | ------------------------------------------------------------ | -------      | ------------ |
| Functional | clone creation from the volume snapshot of zfs persistent volume | Any      | K8s 1.14 + and Ubuntu 18.04 |

## Entry-Criteria

- K8s nodes should be ready.
- Volume snapshot should be present and should be in ready to use state.
- Volume snapshot should be in the same namespace where application and pvc are present.
- size for the clone-pvc should be equal to the original pvc.

## Exit-Criteria

- Clone of the volume snapshot should be created succesfully.
- The cloned volume should contain data available during snapshot creation.


## Notes

- This functional test checks if the clone of the volume snapshot can be created successfully.
- This litmusbook accepts the parameters in form of job environmental variables.
- For running this litmus experiment of clone creation, update the needed test specific values in run_litmus_test.yml file and create the kubernetes job.


## Litmusbook Environment Variables

| Parameters    | Description                                            |
| ------------- | ------------------------------------------------------ |
| APP_NAMESPACE | Namespace where application and volume is deployed.    |
| OPERATOR_NS   | Namespace in which all the resources created by zfs driver will be present for e.g. zfsvolume (zv) will be in this namespace |
| STORAGE_CLASS| Storage class name by which original volume was provisioned |
| SNAPSHOT_NAME | Snapshot will be created with this name in application namespace  |
| CLONED_PVC_NAME |Cloned pvc will be created by this name in the same namespace where spapshot is present |
| CLONE_PVC_SIZE | clone PVC size should match the size of the snapshot  |
| APP_NAME       | Provide the application name which will be deployed using cloned PVC. Supported values are: `busybox` and `percona` |
| APP_LABEL     | Label name of the application                     |
| DATA_PERSISTENCE | Data accessibility & integrity verification by dumping some test data into the application and verify if later. To check against busybox set value: "busybox" and for percona, set value: "mysql"|

