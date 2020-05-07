## Experiment Metadata

| Type  | Description                                                  | Storage | Applications | K8s Platform |
| ----- | ------------------------------------------------------------ | ------- | ------------ | ------------ |
| Chaos | Ensure that preloading does not affect syncing of the data. | OpenEBS | Any          | Any          |

## Entry-Criteria

- Application should be created using jiva volume and should be up.
- Jiva volume should be created with three replica.

## Exit-Criteria

- Application and all three jiva replica should be up.

## Procedure

- Check all the replicas are up and running.
- Write data to even offset using dd.
- Restart all three replicas.
- Wait for two replicas to come into RW state.
- Start I/O with full pace, this time to odd offsets.
- Check whether all the three replicas are up and in running state.

## Note

- The reason behind dumping the data in even and odd offsets is to increase the number of extents in 'filefrag -e file_name'. As the number of extents will go high, preloading will take some time and our intention of experiment would get surved. 
- Preloading will be done in the first replica only before serving any I/O and timeout for the I/Os are set to infinity, in the rest of the replicas preloading will takes place after syncing up the data.
 
## Environment Variables

| Parameters        | Description                                      |
| ----------------- | ------------------------------------------------ |
| APP_LABEL         | Label of the Application.                        |
| APP_NAMESPACE     | Namespace where application is deployed.         |
| APP_PVC           | Persistent Volume Claim of the application.      |
| OFFSET_COUNT      | Block Count to dump the data using dd.           |
| OPERATOR_NS       | OpenEBS.                                         |
| MOUNT_PATH        | Mount path where volume is mounted.              |