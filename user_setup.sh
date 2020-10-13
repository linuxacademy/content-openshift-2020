#!/bin/bash

echo "Lab setup is starting."

### Setting up HTPasswd Identity Provider ###
wget https://raw.githubusercontent.com/linuxacademy/content-openshift-2020/master/lab_htpasswd_cr.yaml
htpasswd -c -B -b users.htpasswd admin doubletap
oc create secret generic htpass-secret --from-file=users.htpasswd> -n openshift-config
oc apply -f lab_htpasswd_cr.yaml

### User setup ###
oc get secret htpass-secret -ojsonpath={.data.htpasswd} -n openshift-config | base64 -d > users.htpasswd
for users in columbus wichita littlerock tallahassee albuquerque flagstaff; do htpasswd -B -b users.htpasswd $users doubletap;done
oc create secret generic htpass-secret --from-file=htpasswd=users.htpasswd --dry-run -o yaml -n openshift-config | oc replace -f -

echo "Lab setup has finished."
