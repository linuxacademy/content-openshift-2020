#!/bin/bash

echo "Lab setup is starting."

### Setting up HTPasswd Identity Provider ###
#htpasswd -c -B -b users.htpasswd admin doubletap
wget https://raw.githubusercontent.com/linuxacademy/content-openshift-2020/master/users.htpasswd
oc create secret generic htpass-secret --from-file=htpasswd=users.htpasswd --dry-run=client -o yaml -n openshift-config | oc replace -f -

sleep 20

### Log in users ###
for users in admin columbus wichita littlerock tallahassee albuquerque flagstaff;
do oc login -u $users -p doubletap;
done

sleep 5

### Log back in as kubeadmin ###
crc console --credentials
echo "Log in as kubeadmin."
oc login -u kubeadmin

sleep 5

### Adding projects ###
oc new-project doubletap
oc new-project doubletapui
oc project default

sleep 5

### User Permissions ###
oc adm policy add-role-to-user admin columbus -n doubletap
oc adm policy add-role-to-user edit wichita -n doubletap
oc adm policy add-role-to-user view littlerock -n doubletap
oc adm policy add-role-to-user basic-user tallahassee -n doubletap
oc adm policy add-cluster-role-to-user cluster-admin admin

sleep 5

### Remove kubeadmin login ###
oc login -u admin -p doubletap
oc delete secrets kubeadmin -n kube-system

#sleep 5

### Adding Groups ###
#oc adm groups new admin columbus
#oc adm groups new dev columbus wichita
#oc adm groups new project_manager littlerock flagstaff
#oc adm groups new testers tallahassee albuquerque

#sleep 5

### Group Permissions ###
#oc adm policy add-role-to-group admin admin -n doubletapui
#oc adm policy add-role-to-group edit dev -n doubletapui
#oc adm policy add-role-to-group view project_manager -n doubletapui
#oc adm policy add-role-to-group basic-user testers -n doubletapui

#sleep 5

### Creating the Service Account ###
#oc project doubletap
#oc create sa homer
#oc policy add-role-to-user edit system:serviceaccount:doubletap:homer

echo "Lab setup has finished."
