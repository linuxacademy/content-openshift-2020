#!/bin/bash

echo "Lab setup is starting."
### Setting up HTPasswd Identity Provider ###
wget https://raw.githubusercontent.com/linuxacademy/content-openshift-2020/master/lab_htpasswd_cr.yaml
htpasswd -c -B -b users.htpasswd admin doubletap
oc create secret generic htpass-secret --from-file=htpasswd=users.htpasswd --dry-run=client -o yaml -n openshift-config | oc replace -f -
echo "Lab setup has finished."
