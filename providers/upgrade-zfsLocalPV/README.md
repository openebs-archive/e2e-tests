## Experiment Metadata

| Type       | Description                                             |  K8s Platform and OS        |
| ---------- | --------------------------------------------------------|  ----------------------     |
| Upgrade    | Upgrade the zfs-driver for zfs-localpv                  | K8s 1.14 + and Ubuntu 18.04 |

## Entry-Criteria

- K8s nodes should be ready.
- Application should be deployed succesfully if there any consuming the ZFS-localPV storage.
- ZFS-controller and node-agent daemonset pods should be in running state.

## Exit-Criteria

- zfs-driver should be upgraded to desired version.
- All the components related to zfs-localpv including zfs-controller and node-agents should be running and
  upraded to desired version as well.
- All the zfs volumes should be healthy and data prior to the upgrade should not be impacted.
- After upgrade we should be able to provision the volume and other related task with no regressions.

## Notes

- This upgrade test upgrade the zfs-driver to the desired latest version.
- This litmusbook accepts the parameters in form of job environmental variables.
- For running this litmus experiment of upgrade test give the required env's in the run_litmus_test.yml file and create the kubernetes job.


## Litmusbook Environment Variables

| Parameters    | Description                                            |
| ------------- | ------------------------------------------------------ |
| TO_VERSION_ZFS_BRANCH | give the branch name in openebs/zfs-localpv repo to which you want to upgrade the zfs-driver as we get the zfs-operator file from that branch for versioned upgrades. To upgrade to developement changes use master branch instead of versioned branch     |
| TO_VERSION_ZFS_DRIVER_IMAGE   | Provide the full image name of zfs-driver including its tag also. If using master branch to upgrade use ci image. for e.g. `quay.io/openebs/zfs-driver:ci`|
| OPERATOR_NAMESPACE| It is the namespace where all the ZF-localpv CRs are created like zvolume. by default its value is openebs|


