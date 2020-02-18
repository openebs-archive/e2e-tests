## Experiment Metadata

| Type       | Description                                                  | Storage | Applications | K8s Platform |
| ---------- | ------------------------------------------------------------ | ------- | ------------ | ------------ |
| Functional | Increase the storage capacity of jiva volumes. | OpenEBS | Any          | Any          |

## Entry-Criteria

- K8s nodes should be ready.
- K8s nodes should have ubuntu 18.04 installed.
- Application should be deployed using 'openebs jiva default' storage class.

## Exit-Criteria

- Volume should be resized successfully and application should be accessible seamlessly.
- Application should be able to use the new space.

## Notes

- This functional test checks if the Jiva volume can be resized.
- This litmusbook accepts the parameters in form of job environmental variables.
- This job updates the storage capacity of volume, you can verify the same by ssh into corresponding node on which application is deployed and use `lsblk`.
- After the volume expansion, size will not be reflected on `kubectl get pv` for the corresponding volume.
- It checks if the application is accessible and the corresponding file system is scaled up.

## Litmusbook Environment Variables

| Parameters    | Description                                            |
| ------------- | ------------------------------------------------------ |
| APP_NAMESPACE | Namespace where application and volume is deployed.    |
| APP_PVC       | Name of PVC whose storage capacity has to be increased |
| APP_LABEL     | Label of application pod                               |
| PV_CAPACITY   | Current storage capacity of volume                     |
| NEW_CAPACITY  | Desired storage capacity of volume                     |
| OPERATOR_NS   | Namespace where OpenEBS is deployed                    |

