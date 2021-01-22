oc new-project twinkies
oc new-build registry.access.redhat.com/ubi8/openjdk-11~https://github.com/monodot/simple-camel-spring-boot-app  --name=tw-tracer
