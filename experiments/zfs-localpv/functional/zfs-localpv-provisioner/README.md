## About this experiment

This experiment first create the zpool on each node of the k8s cluster and then deploys the zfs-localpv provisioner in kube-system namespace which includes zfs-controller and csi-node agent deamonset. Apart from this, storage-classes with different type of file-system for dynamic provisioning of the volumes and volume snapshot class for creation of volume snapshot also get created in this experiment.

## Supported platforms:

K8S : 1.14+

OS : Ubuntu 18.04, Ubuntu 16.04, CentOS 7, CentOS 8

ZFS : 0.7, 0.8

## Entry-Criteria

- K8s cluster should be in healthy state including all the nodes in ready state.
- zfs utils should be installed on each node.
- [Limitation] This experiment assumes that you have external disk attached to all the nodes and only disk `/dev/sdb` will be used for creating the zpool on each node. So make sure you have disk `/dev/sdb` in not used state.
- If we dont use this experiment to deploy zfs-localpv provisioner, we can directly apply the zfs-operator file as mentioned below and make sure you have zpool created on desired nodes to provision volumes.
```kubectl apply -f https://raw.githubusercontent.com/openebs/zfs-localpv/master/deploy/zfs-operator.yaml```

## Exit-Criteria

- zfs-localpv components should be deployed successfully and all the pods including zfs-controller and csi node-agent daemonset are in running state.
- storage classes have been created successfully.

## How to run

- This experiment accepts the parameters in form of job environmental variables.
- For running this experiment of deploying zfs-localpv provisioner, clone openens/e2e-tests repo and then first apply the rbac and crds.
```
kubectl apply -f e2e-tests/hack/rbac.yaml
kubectl apply -f e2e-tests/hack/crds.yaml
```
then update the needed test specific values in run_litmus_test.yml file and create the kubernetes job. All the env variables description is provided with the comments in the same file.

