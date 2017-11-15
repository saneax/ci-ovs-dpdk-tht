#!/bin/bash

#source base.sh

openstack overcloud deploy \
    --templates \
    -r roles_data.yaml \
    --timeout 60 \
    -e /usr/share/openstack-tripleo-heat-templates/environments/host-config-and-reboot.yaml \
    -e /usr/share/openstack-tripleo-heat-templates/environments/neutron-ovs-dpdk.yaml \
    -e /usr/share/openstack-tripleo-heat-templates/environments/network-isolation.yaml \
    -e /usr/share/openstack-tripleo-heat-templates/environments/low-memory-usage.yaml \
    -e /usr/share/openstack-tripleo-heat-templates/environments/docker.yaml \
    -e containers-default-parameters.yaml \
    -e registry.yaml \
    -e dpdk-environment.yaml \
    -e common-environment.yaml \
    -e network-environment.yaml \
    -e temp-env.yaml

# Post Deploy Workarounds
# systemctl start virtlogd.socket

