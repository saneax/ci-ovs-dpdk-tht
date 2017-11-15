#!/bin/bash

set -eux

### --start_docs
## Prepare the undercloud for deploying the containerized compute node
## ===================================================================

## .. note:: In progress documentation is available at https://etherpad.openstack.org/p/tripleo-containers-work
## ::

## Prepare Your Environment
## ------------------------

## * Add an additional insecure registry if needed

## * get build id
## ::
BUILD_ID=latest

## * Populate the docker registry
## ::

openstack overcloud container image prepare \
    --images-file ./overcloud_containers.yaml \
    -e /usr/share/openstack-tripleo-heat-templates/environments/docker.yaml \
    --namespace docker.io/tripleoupstream \
    --tag $BUILD_ID \
    --push-destination 192.168.24.1:8787

openstack overcloud container image upload --verbose --config-file ./overcloud_containers.yaml


## * Configure the /home/stack/containers-default-parameters.yaml, this is done automatically.
## ::

openstack overcloud container image prepare \
    --env-file ./containers-default-parameters.yaml \
    -e /usr/share/openstack-tripleo-heat-templates/environments/docker.yaml \
    --namespace 192.168.24.1:8787/tripleoupstream \
    --tag $BUILD_ID

echo "============================="
echo "Containers default parameters:"
cat ./containers-default-parameters.yaml
echo "============================="

## * Get the journal logs for docker
## ::

sudo journalctl -u docker > docker_journalctl.log

### --stop_docs
