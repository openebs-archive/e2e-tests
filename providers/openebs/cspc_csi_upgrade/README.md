## Test Case to upgrade the cspc csi components

## Description
   - This TestCase is capable of Upgrade the OpenEBS CSPC CSI related components.
   - First it will verifying the CSPC CSI components version to upgrade.
   - This test case upgrades the cstor operator, csi provisioner , cspc pool and csi volumes 
     into new desired version. And verifying the status of each components.
   - This test constitutes the below files.
     - cstor-csi-volume-upgrade-job.j2 - CSI volume upgrade job template which has to be populated with the given variables
     - cstor-cspc-upgrade-job.j2 - CSPC pool upgrade job template which has to be populated with the given variables
     - test_vars.yml - This test_vars file has the list of test specific variables used in LitmusBook
     - test.yml - Playbook where the test logic is built to Upgrade the CSPC CSI components
   - This test case the parameters in form of job environmental variables in run_litmus_test.yml

## Litmusbook Environment Variables

| Parameters              | Description                                                |
| ----------------------- | ---------------------------------------------------------- |
| FROM_VERSION            | Old version which needs to be upgrade                      |
| TO_VERSION              | New version to upgrade                                     |
| OPERATOR_NS             | Nmaespace where the openebs is deployed                    |
| UPGRADE_IMAGE_TAG       | Image tag for upgrade job                                  |
| UPGRADE_TO_CI           | In case of upgrade to ci set the image tag to `ci`         |
| NODE_OS                 | Supported worker nodeos in case of upgrade csi provisioner |
| CSPC_POOL_UPGRADE       | Set the value as `true` to Upgrade cspc pool               |
| CSPC_VOLUME_UPGRADE     | Set the value as `true` to Upgrade csi volumes             |
| CSTOR_OPERATOR_UPGRADE  | Set the value as `true` to upgrade the csto opertor and csi proviisoner |
