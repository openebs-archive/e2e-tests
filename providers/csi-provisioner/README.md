# LitmusBook to deploy the OpenEBS CSI Driver.

## Description
   - This LitmusBook is capable of setting up OpenEBS CSI Driver and create a storageclass.

   - This test constitutes the below files. 

### run_litmus_test.yml
   - This includes the litmus job which triggers the test execution. The pod includes several environmental variables such as 
        - NODE_OS : The operating system of worker nodes.
        - IMAGE_TAG: Release image tag for the cstor csi provisioner.
        - RELEASE_BRANCH: Branch name where to take the csi provsioner spec
        - RELEASE_VERSION: Version Tag for the csi plugins
        - OPERATOR_NS: Namespace where the csi plugins are deployed
        - SNAPSHOT_CLASS: Name of the snapshot class.

### csi-cstor-sc.j2
   - The storage class template which has to be populated with the given variables

### test_vars.yml
   - This test_vars file has the list of test specific variables used in LitmusBook

### test.yml
   - test.yml is the playbook where the test logic is built to deploy OpenEBS CSI Driver and create stoarge class.
