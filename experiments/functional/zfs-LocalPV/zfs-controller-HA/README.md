## Experiment Metadata

| Type       | Description                                             |  K8s Platform and OS        |
| ---------- | --------------------------------------------------------|  ----------------------     |
| Functional  Scale the zfs-controller replicas and check the zfspv behaviour when one of the replica goes down                 | K8s 1.14 + and Ubuntu 18.04 |

## Entry-Criteria

- K8s nodes should be ready.
- Application should be deployed succesfully if there any; consuming the ZFS-localPV storage.
- ZFS-controller and node-agent daemonset pods should be in running state.

## Exit-Criteria

- zfs-controller statefulset should be scaled up by one replica.
- All the replias should be in running state.
- All the zfs volumes should be healthy and data prior to the upgrade should not be impacted.
- This test makes one replica to go down as a result active/master replica of zfs-controller prior to the test will be changed to some other remaining replica after the test completes.
- Volumes provisioning / deprovisioning should not be impact if one replica goes down.

## Notes

- This functional test scale the zfs-controller replica and any other replica takes the place of master/active replica when the same goes down.
- For running this litmus experiment of zfs-controller High availability test ceate the kubernetes job from run_litmus_test.yml file
- This test checks the starting no of replicas of zfs-controller and scale it by one if a free node is present which is able to schedule the pods.




