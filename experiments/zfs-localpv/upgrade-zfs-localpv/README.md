## About this experiment

This experiment upgrades the zfs-localpv components from any previous version to the latest desired stable version or to the master branch ci images. 

## Supported platforms:

K8S : 1.14+

OS : Ubuntu 18.04, Ubuntu 16.04

ZFS : 0.7, 0.8

## Entry-Criteria

- K8s nodes should be ready.
- Do not provision/deprovision any volumes during the upgrade, if we can not control it, then we can scale down the openebs-zfs-controller stateful set to zero replica which will pause all the provisioning/deprovisioning request. And once upgrade is done, the upgraded Driver will continue the provisioning/deprovisioning process.

## Exit-Criteria

- zfs-driver should be upgraded to desired version.
- All the components related to zfs-localpv including zfs-controller and node-agents should be running and
  upraded to desired version as well.
- All the zfs volumes should be healthy and data prior to the upgrade should not be impacted.
- After upgrade we should be able to provision the volume and other related task with no regressions.

## How to run

- This experiment accepts the parameters in form of job environmental variables.
- For running this experiment of upgrading zfs-localpv, clone openens/e2e-tests repo and then first apply the rbac and crds.
```
kubectl apply -f e2e-tests/hack/rbac.yaml
kubectl apply -f e2e-tests/hack/crds.yaml
```
then update the needed test specific values in run_litmus_test.yml file and create the kubernetes job. All the env variables description is provided with the comments in the same file.

## Experiment job env's

| Parameters    | Description                                            |
| ------------- | ------------------------------------------------------ |
| TO_VERSION_ZFS_BRANCH | give the branch name in openebs/zfs-localpv repo to which you want to upgrade the zfs-driver as we get the zfs-operator file from that branch for versioned upgrades. To upgrade to developement changes use master branch instead of versioned branch     |
| TO_VERSION_ZFS_DRIVER_IMAGE   | Provide the full image name of zfs-driver including its tag also. If using master branch to upgrade use ci image. for e.g. `quay.io/openebs/zfs-driver:ci`|
| OPERATOR_NAMESPACE| It is the namespace where all the ZF-localpv CRs are created like zvolume. by default its value is openebs|


