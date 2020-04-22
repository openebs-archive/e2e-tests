## Experiment Metadata

| Type       | Description                                                  | Storage | Applications | K8s Platform |
| ---------- | ------------------------------------------------------------ | ------- | ------------ | ------------ |
| Functional | Create the cleanup jobs for jiva volume and validate its completion even after adding taints to nodes. | OpenEBS | Any          | Any          |

## Entry-Criteria

- K8s nodes should be ready.
- OpenEBS >=1.9 should be installed to create storage classes with
```
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: "{{ storage_class }}"
  annotations:
    openebs.io/cas-type: jiva
    cas.openebs.io/config: |
      - name: ReplicaCount
        value: "3"
      - name: StoragePool
        value: default
      - name: ReplicaTolerations
        value: |
          t1:
            key: "{{ taint_key }}"
            operator: "Equal"
            value: "{{ taint_value }}"
            effect: "NoSchedule"
provisioner: openebs.io/provisioner-iscsi
```

## Exit-Criteria

- Jiva cleanup jobs should be created and completed successfully in openebs namespace.

## Notes

- This functional test checks if the Jiva volume cleanup jobs can be created successfully even after tainting the nodes.
- This litmusbook accepts the parameters in form of job environmental variables.
- This job adds the tolerations into the storage class spec itself.
- This job itself creates a pvc and deploys a busybox application on top of that. Later, it deletes the jiva volume to create volume cleanup jobs.

## Litmusbook Environment Variables

| Parameters    | Description                                            |
| ------------- | ------------------------------------------------------ |
| APP_NAMESPACE | Namespace where application and volume to be deployed  |
| APP_PVC       | Name of PVC to be created                              |
| APP_LABEL     | Label of application pod                               |
| PV_CAPACITY   | Storage capacity of volume to be created               |
| TAINT_KEY     | Key in the key-value pair of taints                    |
| TAINT_VALUE   | Value in the key-value pair of taints                  |
| OPERATOR_NS   | openebs                                                |
| PROVIDER_STORAGE_CLASS   | Name of storage class to be created               |
