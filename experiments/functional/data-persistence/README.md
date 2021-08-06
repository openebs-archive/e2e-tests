## Entry-Criteria

- Application services are accessible & pods are healthy

## Exit-Criteria

- Application services are accessible & pods are healthy
- Data written should be successfully verified by the md5sum check
- Storage target pods are healthy

## Associated Utils 

- `data_persistence.j2`,`mysql_data_persistence.yml`,`busybox_data_persistence.yml`

## Litmus experiment Environment Variables

### Application

| Parameter        | Description                                                  |
| ---------------- | ------------------------------------------------------------ |
| APP_NAMESPACE    | Namespace in which application pods are deployed             |
| APP_LABEL        | Unique Labels in `key=value` format of application deployment|
| STATUS           | For creating some data in application set value: "LOAD" and to
verify data set value: "VERIFY" and for deleting set value: "DELETE"              |
| DATA_PERSISTENCE | Data accessibility & integrity verification post recovery. To check against busybox set value: "busybox" and for percona, set value: "mysql"|


### Procedure

This Litmus experiment create some dummy data in application and create the md5sum for this data. Later it verifies for the data-persistence by checking md5sum.
Based on the value of env DATA_PERSISTENCE, the corresponding data consistency util will be executed. At present only busybox and percona-mysql are supported. Along with specifying env in the e2e experiment, user needs to pass name for configmap and the data consistency specific parameters required via configmap in the format as follows:

    parameters.yml: |
      blocksize: 4k
      blockcount: 1024
      testfile: difiletest
It is recommended to pass test-name for configmap and mount the corresponding configmap as volume in the e2e pod. The above snippet holds the parameters required for validation data consistency in busybox application.

For percona-mysql, the following parameters are to be injected into configmap.

    parameters.yml: |
      dbuser: root
      dbpassword: k8sDem0
      dbname: tdb
The configmap data will be utilised by e2e experiments as its variables while executing the scenario.

Based on the data provided, e2e checks if the data is consistent using md5sum checks.