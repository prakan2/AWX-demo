#!/bin/bash
#echo -e "\e[34mDoing validation of Servicenow request file\e[0m"
#$(cd scripts/ ; sh validate_servicenow_file.sh)


#echo -e "\e[34mSending validation report for Servicenow request file\e[0m"
#$(cd scripts/ ; sh email.sh)

#current_dir='/var/lib/awx/projects/_46__fiserv_storage_expansion'
#current_dir='.'
current_dir='/var/lib/awx/projects/_24__storage_new'

echo -e "\e[34mCreating variable file for each Ticket\e[0m"
#$(cd $current_dir/scripts/ ; sh createvariablefile.sh)
/bin/sh /var/lib/awx/projects/_24__storage_new/scripts/createvariablefile.sh

V_ticket=`cat final_value.txt | awk -F "," '{print $1}' | awk -F ": " '{print $2}'`
for i in ${V_ticket[@]}
do

  ansible-playbook storage_expansion.yaml --extra-vars="myvarfile=$current_dir/var_file/${i}.yaml"

done
