#!/bin/bash

echo "Build 1 has started."
oc new-project twinkies
oc new-build registry.access.redhat.com/ubi8/openjdk-11~https://github.com/monodot/simple-camel-spring-boot-app  --name=tw-tracer

sleep 20

echo "Build 2 has started"
oc start-build tw-tracer --follow=false
