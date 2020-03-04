## Experiment Metadata

| Type  | Description                                                  | Storage | Applications | K8s Platform |
| ----- | ------------------------------------------------------------ | ------- | ------------ | ------------ |
| Chaos | Ensure that CSPC pool pod not getting evicted violating pod disruption budget. | OpenEBS | Any          | Any          |

## Entry-Criteria

- CSPC pool with specified three replicas should be created.
- CSI based cStor volumes should be created on CSPC pool, thus PDB would be created.

## Exit-Criteria

- The pool pod should not be evicted when there are more than allowed disruptions happened in the cluster.

## Procedure

- Drain one of the nodes where CSPC pool pod is created.

- Check it the corresponding pool pod is evicted.

- Drain another node where CSPC pool pod is scheduled. Pool pod should not be evicted because of pod disruption budget created.

- Pod disruption budget will be created during cStor volume provisioning. It will look similar to following snippet.

  ```
  NAME                        MIN AVAILABLE   MAX UNAVAILABLE   ALLOWED DISRUPTIONS   AGE
  cstor-cspc-disk-pooldwgg9   N/A             1                 1                     4m22s
  ```

## Environment Variables

| Parameters        | Description                                      |
| ----------------- | ------------------------------------------------ |
| OPENEBS_NAMESPACE | Namespace where OpenEBS components are deployed. |
| CSPC_NAME         | Name of CSPC for which PDB has to be validated   |