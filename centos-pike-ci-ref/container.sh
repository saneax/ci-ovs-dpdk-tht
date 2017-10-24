#!/bin/bash

openstack overcloud container image prepare \
  --namespace 192.168.24.1:8787/master \
  --tag latest \
  --env-file ./docker_registry.yaml

echo "  DockerInsecureRegistryAddress: 192.168.24.1:8787" >>  ./docker_registry.yaml
