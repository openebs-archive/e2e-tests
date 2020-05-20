#!/bin/bash
  
set -e

mkdir app_yamls_W

for i in $(seq 1 5)
do
        sed "s/pvc-custom-topology/pvc-custom-topology$i/g" busybox_W.yml > app_yamls_W/busybox$i.yml
        sed -i "s/busybox-custom-topology-test/busybox-custom-topology-test$i/g" app_yamls_W/busybox$i.yml
        sed -i "s/zfspv-custom-topology/zfspv-custom-topology-wait/g" app_yamls_W/busybox$i.yml
done
