# Test Case to deploy the OpenEBS cStor operator.

## Description
   - This test case is capable of setting up OpenEBS cStor and cvc operator.

   - This test constitutes the below files. 

### run_litmus_test.yml
   - This includes the litmus job which triggers the test execution. The pod includes several environmental variables such as 
        - CSPC_OPERATOR_IMAGE: Release image tag for the cstor CSPC and CVC operator.
        - RELEASE_BRANCH: Branch name where to take the cstor provsioner spec
        - RELEASE_VERSION: Version Tag for the cstor operator
        - OPERATOR_NS: Namespace where the cstor cspc and cvc plugins are deployed

### csi-cstor-sc.j2
   - The storage class template which has to be populated with the given variables

### test_vars.yml
   - This test_vars file has the list of test specific variables used in LitmusBook

### test.yml
   - test.yml is the playbook where the test logic is built to deploy OpenEBS cStor CSPC and CVC operator.
