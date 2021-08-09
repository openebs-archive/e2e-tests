## Experiment Metadata

| Type       | Description                                                  | Storage | Applications | K8s Platform |
| ---------- | ------------------------------------------------------------ | ------- | ------------ | ------------ |
| Functional | Validate the enabling/disabling jiva logging. | OpenEBS | Any          | Any          |

## Entry-Criteria

- K8s nodes should be ready.
- OpenEBS version should be greater than 1.9 .
- Application should be deployed using 'jiva storage engine'.

## Exit-Criteria

- jiva replica pods should honour enabling/disabling jiva logging. 
- Application should be accessible seamlessly.

## Notes

- This functional test checks if the Jiva logging can be enabled/disabled.
- This e2ebook accepts the parameters in form of job environmental variables.
- This job validates the enabling/disabling jiva logging that can be achieved through jiva controller pod using `jivactl logtofile enable --maxLogFileSize 100 --retentionPeriod 180 --maxBackups 5`.
- After disabling the logging, log file content/size should not increase.

## Litmusbook Environment Variables

| Parameters    | Description                                            |
| ------------- | ------------------------------------------------------ |
| APP_NAMESPACE | Namespace where application and volume is deployed.    |
| APP_PVC       | Application pvc                                        |
| APP_LABEL     | Label of application pod                               |
| OPERATOR_NS   | openebs                                                |