## Experiment Metadata

| Type       | Description                                                                              | Storage | K8s Platform |
| ---------- | ---------------------------------------------------------------------------------------- | ------- | ------------ |
| Functional | Scale to the cStor volume Replica and validates the applicatin and cstorvolume behaviour.| OpenEBS | Any          |

## Entry-Criteria

- K8s nodes should be ready.
- cStor SPC should be created.
- Application should be deployed and it has more than one replica.

## Exit-Criteria

- Volume should be scaled down successfully and application should be accessible seamlessly.
- cStor volume replica should be in Healthy state. Scale Down CVRs should be in OFFILNE state

## Notes

- This functional test checks if the cStor volume can be scaled down successfuly.
- This litmusbook accepts the parameters in form of job environmental variables.

## Associated Utils

- `scale_down_cstor_replica.yml`,`mysql_data_persistence.yml`,`busybox_data_persistence.yml`

### Procedure

This scenario validates the behaviour of application and OpenEBS cStor volumes when the volume replica is scale down.

Based on the value of env `DATA_PERSISTENCE`, the corresponding data consistency util will be executed. At present, only busybox and percona-mysql are supported. Along with specifying env in the litmus experiment, user needs to pass name for configmap and the data consistency specific parameters required via configmap in the format as follows:

```
    parameters.yml: |
      blocksize: 4k
      blockcount: 1024
      testfile: difiletest
```

It is recommended to pass test-name for configmap and mount the corresponding configmap as volume in the litmus pod. The above snippet holds the parameters required for validation data consistency in busybox application.

For percona-mysql, the following parameters are to be injected into configmap.

```
    parameters.yml: |
      dbuser: root
      dbpassword: k8sDem0
      dbname: tdb
```

The configmap data will be utilised by litmus experiments as its variables while executing the scenario.

Based on the data provided, litmus checks if the data is consistent after recovering from induced chaos.

## Litmusbook Environment Variables

| Parameters     | Description                                            |
| -------------  | ------------------------------------------------------ |
| APP_NAMESPACE  | Namespace where application and volume is deployed.    |
| PVC_NAME       | Name of PVC whose cvr has to be scaled down            |
| APP_LABEL      | Label of application pod                               |
| OPERATOR_NS    | Namespace where OpenEBS is deployed                    |
|DATA_PERSISTENCE| Specify the application name against which data consistency has to be ensured. Example: busybox |
