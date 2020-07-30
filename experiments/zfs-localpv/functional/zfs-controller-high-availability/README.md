## About this experiment

This functional experiment installs the zfs-controller in high availability and then verifies the zfs-localpv behaviour when one of the replica goes down. This experiment checks the starting no of replicas of zfs-controller and scale it by one if a free node is present which should be able to schedule the pods.

## Supported platforms:

K8S : 1.14+

OS : Ubuntu 18.04, Ubuntu 16.04, CentOS 7, CentOS 8

ZFS : 0.7, 0.8

## Entry-Criteria

- K8s cluster should be in healthy state including all the nodes in ready state.
- zfs-controller and node-agent daemonset pods should be in running state.

## Exit-Criteria

- zfs-controller statefulset should be scaled up by one replica.
- All the replias should be in running state.
- All the zfs volumes should be healthy and data prior to the upgrade should not be impacted.
- This experiment makes one of the zfs-controller statefulset replica to go down, as a result active/master replica of zfs-controller prior to the experiment will be changed to some other remaining replica after the experiment completes. This happens because of the lease mechanism, which is being used to decide which replica will be serving as master. At a time only one replica will be master and other replica will follow the anti-affinity rules so these replica pod will be present on different nodes only.
- Volumes provisioning / deprovisioning should not be impact if one replica goes down.

## How to run

- This experiment accepts the parameters in form of job environmental variables.
- For running this experiment of installing zfs-controller in high availability, clone openebs/e2e-tests repo and then first apply the rbac and crds.
```
kubectl apply -f e2e-tests/hack/rbac.yaml
kubectl apply -f e2e-tests/hack/crds.yaml
```
then update the needed experiment specific values in run_litmus_test.yml file and create the kubernetes job. All the env variables description is provided with the comments in the same file.




