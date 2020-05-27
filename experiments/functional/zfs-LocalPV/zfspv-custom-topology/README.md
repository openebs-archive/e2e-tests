## Experiment Metadata

| Type       | Description                                             |  K8s Platform and OS        |
| ---------- | --------------------------------------------------------|  ----------------------     |
| Functional | Functional test for validation of custom-topology support for zfs-localpv                 | K8s 1.14 + and Ubuntu 18.04 |

## About the experiment

- After zfs-driver:v0.7.x user can label the nodes with the required topology, the ZFSPV driver will support all the node labels as topology keys.
- In this experiment we cover two scenarios such as one with immediate volume binding and other with late binding (i.e. WaitForFirstConsumer). If we add a label to node after zfs-localpv driver deployment and using late binding mode, then a restart of all the node agents are required so that the driver can pick the labels and add them as supported topology key. Restart is not required in case of immediate volumebinding irrespective of if we add labels after zfs-driver deployment or before.

## How to run experiment

- This litmusbook accepts the parameters in form of job environmental variables.
- For running this litmus experiment of validation of custom-topology feature support for zfs-localv update the needed test specific values in run_litmus_test.yml file and create the kubernetes job.
- Here we will provision five volumes across two of the nodes which are labeled with custom topology and will validate the custom-topology support for both types of volumeBinding mentioned above.

## Litmusbook Environment Variables

| Parameters    | Description                                            |
| ------------- | ------------------------------------------------------ |
| APP_NAMESPACE | Namespace where application and volume will be deployed.    |
| APP_LABEL     | Label name of the application                     |
| ZPOOL_NAME    | give the zpool name from which dataset/zvol will be provisioned  |
| NODE_LABEL    | give the label name by which nodes will be labeled               |
| FS_TYPE       | To create storage class with this fs_type parameter (zfs,xfs,ext)               |






