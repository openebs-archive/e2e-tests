## About the experiment

- This functional test verifies the zfs-localpv shared mount volume support via multiple pods. Applications who wants to share the volume can use the storage-class as below.

```
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: openebs-zfspv
parameters:
  shared: "yes"
  fstype: "zfs"
  poolname: "< zpool_name >"
provisioner: zfs.csi.openebs.io
```
- To run this test of verification of shared mount support for zfspv, update the needed test specific values in run_litmus_test.yml file and create the kubernetes job.

Note: For running this experiment above storage-class should be present. This storage will be created as a part of zfs-localpv provisioner experiment. If zfs-localpv components are not deployed using e2e-test script located at `e2e-tests/providers/zfs-localpv-provisioiner` please make sure you create the storage class from above mentioned yaml.

## Steps performed in this experiment:

1. First deploy the busybox application using `shared: yes` enabled storage-class
2. Then we dump some dummy data into the application pod mount point.
3. Scale the busybox deployment replicas so that multiple pods (here replicas = 2) can share the volume.
4. After that data consistencty is verified from the scaled application pod in the way that data is accessible from both the pods and after restarting the application pod data consistency should be maintained.