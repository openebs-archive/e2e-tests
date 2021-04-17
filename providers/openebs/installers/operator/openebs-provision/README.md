## Litmus Job for Provisioning OpenEBS

This job installs OpenEBS on a litmus enabled cluster. It first scans the environment variables for explicitly passed release version of OpenEBS and the NDM image tags, downloads the openebs-operator.yaml, preconditions it (if necessary), applies the (updated) operator manifest and waits for all the pods to get into running state before exiting. 

### Prerequisites

- The cluster should be litmus enabled. To enable the litmus apply the `rbac.yaml` and `crds.yaml` from [here](https://github.com/mayadata-io/litmus/tree/master/hack), using the following commands:

  ```
    kubectl apply -f rbac.yaml
  ```
  ```
    kubectl apply -f crds.yaml
  ```

### Steps to Install OpenEBS:

 - Create Litmus Job to deploy the OpenEBS.
  
  ```
  kubectl create -f run_litmus_test.yml
  ```

 - Check the status of Job pod created in Litmus namesapce.

    ```
     kubectl get pod -n litmus
    ```

 - Once the litmus pod status is completed check the OpenEBS components are installed successfully in openebs namespace.
     
    ```
     kubectl get pods -n openebs
    ```
    ```
     user@user-Lenovo-ideapad-320-15IKB:~$ kubectl get pods -n openebs
     NAME                                                              READY   STATUS      RESTARTS   AGE
     cspc-operator-5dd4b95486-4v4nt                                    1/1     Running     0          135m
     cvc-operator-6d9dfff6d7-t5dfp                                     1/1     Running     0          135m
     maya-apiserver-6df9b6cfb4-7dztx                                   1/1     Running     0          135m
     openebs-admission-server-76b94d8895-9jh87                         1/1     Running     0          135m
     openebs-localpv-provisioner-7b75dcb8df-ptvll                      1/1     Running     0          135m
     openebs-ndm-627nk                                                 1/1     Running     0          134m
     openebs-ndm-88dvx                                                 1/1     Running     0          135m
     openebs-ndm-operator-99cbdf5dc-wp7kw                              1/1     Running     0          135m
     openebs-ndm-p7n9w                                                 1/1     Running     0          135m
     openebs-provisioner-9568498d9-xc45v                               1/1     Running     0          135m
     openebs-snapshot-operator-66479cf4-twfl2                          2/2     Running     0          135m

   ```
  
### Note:

Image names for openebs-operator can be explicitly passed by environment variable in the run_litmus_test.yml .

Example:

```yaml
---
apiVersion: batch/v1
kind: Job
metadata:
  generateName: litmus-openebs-provision-
  namespace: litmus
spec:
  template:
    metadata:
      name: litmus
      labels:
        app: openebs-provision
    spec:
      serviceAccountName: litmus
      restartPolicy: Never
      containers:
      - name: ansibletest
        image: openebs/ansible-runner:ci
        imagePullPolicy: IfNotPresent

        env:
          - name: ANSIBLE_STDOUT_CALLBACK
            #value: log_plays, actionable, default
            value: default

            # OpenEBS Version
          - name: RELEASE_VERSION
            value: 1.6.0
            
            # Namespace where OpenEBS is deployed
          - name: OPERATOR_NS
            value: openebs

            #  Image tag for NDM (optional)
          - name: NDM_TAG
            value: ""
 
            # Mode the deploy the OpenEBS (operator or helm)
          - name: DEPLOY_TYPE
            value: operator

          - name: ACTION
            value: provision 

        command: ["/bin/bash"]
        args: ["-c", "ansible-playbook ./providers/openebs/installers/operator/openebs-provision/test.yml -i /etc/ansible/hosts -v; exit 0"]
```

### Troubleshooting
- In case of unsuccessful/incomplete installation view the logs of the litmus job.
   ```
    kubectl logs -f <litmus_job_pod_name> -n litmus
   ```

