## Experiment Metadata

| Type  | Description                                                  | Storage | K8s Platform      |
| ----- | ------------------------------------------------------------ | ------- | ----------------- |
| Chaos | Power off any one of the node where cvr is hosted and migrate the cvr to other nodde where it has pool availabel | OpenEBS | on-premise-VMware |

## Entry-Criteria

- Application services are accessible & pods are healthy
- All the CVR's are healthy
- Pools have to be created in all the nodes.
- Application writes are successful

## Exit-Criteria

- Application and all the CVR's are healthy.
- Data written prior to chaos is successfully retrieved/read
- Database consistency is maintained as per db integrity check utils
- Storage target pods are healthy

## Associated Utils

- `vm_power_operations.yml`,`mysql_data_persistence.yml`,`busybox_data_persistence.yml`,`fetch_data_from_replica.yml`


### Procedure

This scenario validates the behaviour of cStor volume Replica have to be migrated to the new node where the pools availabel and that shoul be in healthy state. It is performed by shutting down the node(virtual machine) created on VMware hypervisor. After attaining podevictiontimeout(5 minutes by default).

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

ESX password has to updated through k8s secret created. The litmus runner can retrieve the password from secret as environmental variable and utilize it for performing admin operations on the server.


Note: To perform admin operatons on vmware, the VM display name in hypervisor should match its hostname.

## Litmus experiment Environment Variables

### Application

| Parameter        | Description                                                  |
| ---------------- | ------------------------------------------------------------ |
| APP_NAMESPACE    | Namespace in which application pods are deployed             |
| APP_LABEL        | Unique Labels in `key=value` format of application deployment|
| OPERATOR_NS      | Namespace in which openebs components are deployed           |
| TARGET_NAMESPACE | Namespace where OpenEBS is installed                         |
| DATA_PERSISTENCE | Specify the application name against which data consistency has to be ensured. Example: busybox |

### Chaos

| Parameter    | Description                                                  |
| ------------ | ------------------------------------------------------------ |
| PLATFORM     | The platform where k8s cluster is created. Currently, only 'vmware' is supported. |
| ESX_HOST_IP  | The IP address of ESX server where the virtual machines are hosted. |
| ESX_PASSWORD | To be passed as configmap data.                              |

