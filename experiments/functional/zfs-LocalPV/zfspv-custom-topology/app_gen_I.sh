#!/bin/bash
  
set -e

mkdir app_yamls_I

for i in $(seq 1 5)
do
        sed "s/pvc-custom-topology/pvc-custom-topology$i/g" busybox_I.yml > app_yamls_I/busybox$i.yml
        sed -i "s/busybox-custom-topology-test/busybox-custom-topology-test$i/g" app_yamls_I/busybox$i.yml
        sed -i "s/zfspv-custom-topology/zfspv-custom-topology-immediate/g" app_yamls_I/busybox$i.yml
done
