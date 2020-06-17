#!/bin/bash
#echo -e "\e[34mDoing validation of Servicenow request file\e[0m"
#$(cd scripts/ ; sh validate_servicenow_file.sh)


#echo -e "\e[34mSending validation report for Servicenow request file\e[0m"
#$(cd scripts/ ; sh email.sh)

echo -e "\e[34mCreating variable file for each Ticket\e[0m"
$(cd /var/lib/awx/projects/_18__git_expansion_demo/scripts/ ; sh createvariablefile.sh)


V_ticket=`cat /var/lib/awx/projects/_18__git_expansion_demo/final_value.txt | awk -F "," '{print $1}' | awk -F ": " '{print $2}'`
for i in ${V_ticket[@]}
do

  ansible-playbook storage_expansion.yaml --extra-vars="myvarfile=/var/lib/awx/projects/_18__git_expansion_demo/var_file/${i}.yaml"

done
