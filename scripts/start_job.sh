#!/bin/bash

current_dir='/var/lib/awx/projects/_18__git_expansion_demo'

echo -e "\e[34mCreating variable file for each Ticket\e[0m"
$(cd $current_dir/scripts/ ; sh createvariablefile.sh)


V_ticket=`cat $current_dir/final_value.txt | awk -F "," '{print $1}' | awk -F ": " '{print $2}'`
for i in ${V_ticket[@]}
do

  ansible-playbook storage_expansion.yaml --extra-vars="myvarfile=$current_dir/var_file/${i}.yaml"

done
