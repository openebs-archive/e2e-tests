## About the experiment

- After zfs-driver:v0.7.x user can label the nodes with the required topology, the zfs-localpv driver will support all the node labels as topology keys. This experiment verifies this custom-topology support for zfs-localpv. Volume should be provisioned on only such nodes which have been labeled with the keys set via the storage-class.
- In this experiment we cover two scenarios such as one with immediate volume binding and other with late binding (i.e. WaitForFirstConsumer). If we add a label to node after zfs-localpv driver deployment and using late binding mode, then a restart of all the node agents are required so that the driver can pick the labels and add them as supported topology key. Restart is not required in case of immediate volumebinding irrespective of if we add labels after zfs-driver deployment or before.

## Supported platforms:

K8S : 1.14+

OS : Ubuntu 18.04, Ubuntu 16.04, CentOS 7, CentOS 8

ZFS : 0.7, 0.8

ZFS-LocalPV version: 0.7+

## Entry-Criteria

- K8s cluster should be in healthy state including all the nodes in ready state.
- zfs-controller and node-agent daemonset pods should be in running state.

## Steps performed

- select any of the two nodes randomly from the k8s cluster and label them with some key.
- deploy five applications using the pvc provisioned by storage class in which volume binding mode is immediate.
- verify that pvc is bound and application pod is in running state.
- verify that volume is provisioned on only those nodes which was labeled prior to the provisioning.
- after that deploy five more applications using the pvc provisioned by storage class in which volume binding mode is waitforfirstconsumer.
- check that pvc remains in pending state.
- restart the csi node-agent pods on all nodes.
- verify that new topology keys are now present in csi-nodes.
- now pvc should come into bound state and application should be in running state.
- verify that volume is provisioned on only those nodes which was labeled.

## How to run

- This experiment accepts the parameters in form of job environmental variables.
- For running this experiment of custom-topology support for zfs-localpv, clone openens/e2e-tests repo and then first apply the rbac and crds.
```
kubectl apply -f e2e-tests/hack/rbac.yaml
kubectl apply -f e2e-tests/hack/crds.yaml
```
then update the needed test specific values in run_litmus_test.yml file and create the kubernetes job.

## Litmusbook Environment Variables

| Parameters    | Description                                            |
| ------------- | ------------------------------------------------------ |
| APP_NAMESPACE | Namespace where application and volume will be deployed.    |
| APP_LABEL     | Label name of the application                     |
| ZPOOL_NAME    | give the zpool name from which dataset/zvol will be provisioned  |
| NODE_LABEL    | give the label name by which nodes will be labeled               |
| FS_TYPE       | To create storage class with this fs_type parameter (zfs,xfs,ext)|






