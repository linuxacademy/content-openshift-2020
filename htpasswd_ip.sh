#!/bin/bash

### Setting up HTPasswd Identity Provider ###
wget https://raw.githubusercontent.com/linuxacademy/content-openshift-2020/master/lab_htpasswd_cr.yaml
htpasswd -c -B -b users.htpasswd admin doubletap
oc create secret generic htpass-secret --from-file=users.htpasswd> -n openshift-config
oc apply -f lab_htpasswd_cr.yaml


### Create install config ###
./openshift-install create install-config --dir=install/
