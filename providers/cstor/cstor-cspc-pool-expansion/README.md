## Experiment Metadata

| Type       | Description                | Storage | K8s Platform |
| -----------| -------------------------- | ------- | ------------ |
| Functional | Expand the cstor CSPC pool | OpenEBS | Any          |

## Entry-Criteria

- cstor CSPC pool pods services are accessible 

## Exit-Criteria

- cStor CSPC pool pods are healthy and are in Running state. CSPI should be ONLINE.
- Data written prior to expanding CSPC pool is successfully retrieved.
- Storage target pods are healthy

## Associated Utils 

- `blockdevice.j2`, `add_blockdevice.yml`, `expand-block-devices.j2`, `expand_blockdevice.yml`, `cspc.yml`

###Util description

   `blockdevice.j2` - Jinja template to append the blockdevices into cspc pool spec
   `add_blockdevice.yml` - Util to get the blockdevices and creates blockdevices.yaml manifest for each node
   `expand-block-devices.j2` - Jinja template to append the unclaimed blockdevices in cspc pool spec to expand the pool
   `expand_blockdevices.yml` - Util to get the unclaimed blockdevices and creates the spec to expand the pool
   `cspc.yml` - cspc pool pod spec to expand the pool

## Litmus experiment Environment Variables

### Application

| Parameter          | Description                                                              |
| ------------------ | ------------------------------------------------------------------------ |
| POOL_NAME          | Name of the pool that has to be expanded                                 |
| POOL_TYPE          | Type of the pool that has to be expanded [ stripe,mirror,raidz1,raidz2 ] |
| OPERATOR_NAMESPACE | Namespace where OpenEBS is installed                                     |
| ------------------ | ------------------------------------------------------------------------ |
