## Experiment Metadata

| Type       | Description                                           | Storage      | Applications | K8s Platform |
| ---------- | ----------------------------------------------------- | ------------ | ------------ | ------------ |
| CHAOS      | Restart the pool pod while CSPC pool expansion is in progress | OpenBS cStor | Any          | Any          |

## Entry-Criteria

- K8s nodes should be ready.
- cStor CSPC should be created.
- Application should be deployed using with volume provisioned through CSI provisioner.
- Uncliamed BlockDevices should be available to expand the pool.

## Exit-Criteria

- Pool expansion should be expanded successfully and the application is still up and running.

## Procedure

- This chaos test checks if the cspc pool expanded succesfully upon the restart of the pool pod.
- This litmusbook accepts the parameters in form of job environmental variables.
- This job patched the respective CSPC pool to expand the cspc pool and verifying the status of cspi. 

## Litmusbook Environment Variables

| Parameters    | Description                                            |
| ------------- | ------------------------------------------------------ |
| POOL_NAME     | CSPC Pool name to expand                               |
| POOL_TYPE     | CSPC pool raid type [stripe,mirror,raidz,raidz2]       |
| OPERATOR_NS   | Nmaespace where the openebs is deployed                |
