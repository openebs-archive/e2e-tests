# Test Case to deploy the OpenEBS cStor operator.

## Description
   - This test case is capable of setting up OpenEBS cStor cspc,cvc operator and OpenEBS CSI control plane components

   - This test constitutes the below files. 

### run_litmus_test.yml
   - This includes the litmus job which triggers the test execution. The pod includes several environmental variables such as 
        - IMAGE_TAG: Release image tag for the cstor CSPC and CVC operator and csi driver.
        - RELEASE_BRANCH: Branch name where to take the cstor provsioner spec
        - RELEASE_VERSION: Version Tag for the cstor operator
        - ACTION: Values should be provision for deploy, to remove the operator value should be deprovision.
        - WEBHOOK_FAILURE_POLICY: value for the webhook failure policy.
        - SNAPSHOT_CLASS: Name of the snapshot class.
        - CSI_NS: Namespace where the csi plugins are deployed.
        - NODE_OS : The operating system of worker nodes.

### test_vars.yml
   - This test_vars file has the list of test specific variables used in LitmusBook

### test.yml
   - test.yml is the playbook where the test logic is built to deploy OpenEBS cStor CSPC, CVC operator and OpenEBS CSI control plane components.
