# Test Case to create OpenEBS cStor SPC pools.

## Description
   - This test is capable of creating the SPC pool. 
   - To create SPC pools nodes must have unclaimed block devices in all the nodes.
   - If specify maxPools count to limit the storage pool creation. Only the specified number of pool will be created using auto mode.
   - This test constitutes the below files.
     - test_vars.yml - This test_vars file has the list of test specific variables used in this test case.
     - test.yml - Playbook where the test logic is to create/delete the spc pool.
     - spc.yml  - SPC pool spec which has to be populated with the given variables.
   - This test case should be provided with the parameters in form of job environmental variables in run_litmus_test.yml.

## Litmusbook Environment Variables

| Parameters              | Description                                                                       |
| ----------------------- | --------------------------------------------------------------------------------- |
| OPERATOR_NS             | Namespace where the openebs is deployed                                           |
| POOL_NAME               | Name of the pool that going to be created                                         |
| POOL_TYPE               | Type of the pool to create, supported values are striped, mirrored, raidz ,raidz2 |
| STORAGE_CLASS           | Name the storage class to create that using this SPC pool                         |  
| DEPLOY_MODE             | To create a pool value is `create` and to delete a pool value is `delete`         |
| THICK_PROVISIONING      | If want to disable the thick provisioning value must be 'false'                   |
| SPC_MAXPOOL_COUNT       | Maximum number of pool to be created, if the value is set it will create a pool according to that max pool count. If the value is set to '0' it will create pool on each node |
