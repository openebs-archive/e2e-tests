## Experiment Metadata

Type  |     Description                             | Storage    |  Applications   | K8s Platform |     Tools       | 
------|---------------------------------------------|------------|-----------------|--------------|-----------------|
Chaos |Inject n/w delay on cStor storage pools| OpenEBS    | Percona MySQL   | Any          | tc, netem       | 

## Entry-Criteria

- CSPC pool and cStor volume should be provisioned
- Application services are accessible & pods are healthy
- Application writes are successful 

## Exit-Criteria

- Application services are accessible & pods are healthy
- Data written prior to chaos is successfully retrieved/read
- Database consistency is maintained as per db integrity check utils
- Storage pool pods are healthy and the volume should be remounted automatically and be accessible

## Notes

- Typically used as a disruptive test, to cause loss of access to storage by injecting complete network loss.

## Associated Utils 

- `inject_packet_loss_tc.yml`


## Litmus experiment Environment Variables

### Application

Parameter     | Description
--------------|------------
APP_NAMESPACE | Namespace in which application pods are deployed
APP_LABEL     | Unique Labels in `key=value` format of application deployment
APP_PVC       | Name of persistent volume claim used for app's volume mounts 
CSPC_NAME     | Name of CSPC 

### Health Checks 

Parameter             | Description
----------------------|------------
LIVENESS_APP_NAMESPACE| Namespace in which external liveness pods are deployed, if any
LIVENESS_APP_LABEL    | Unique Labels in `key=value` format for external liveness pod, if any
DATA_PERSISTENCE      | Data accessibility & integrity verification post recovery (enabled, disabled)


### Procedure

After injecting the chaos into the cstor pool pods, litmus experiment observes the behaviour of corresponding OpenEBS PV and the application which consumes the volume.

Based on the value of env DATA_PERSISTENCE, the corresponding data consistency util will be executed. At present only busybox and percona-mysql are supported. Along with specifying env in the litmus experiment, user needs to pass name for configmap and the data consistency specific parameters required via configmap in the format as follows:

    parameters.yml: |
      blocksize: 4k
      blockcount: 1024
      testfile: difiletest

It is recommended to pass test-name for configmap and mount the corresponding configmap as volume in the litmus pod. The above snippet holds the parameters required for validation data consistency in busybox application.

For percona-mysql, the following parameters are to be injected into configmap.

    parameters.yml: |
      dbuser: root
      dbpassword: k8sDem0
      dbname: tdb

The configmap data will be utilised by litmus experiments as its variables while executing the scenario. Based on the data provided, litmus checks if the data is consistent after recovering from induced chaos.

