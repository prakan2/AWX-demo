#!/bin/bash
current_dir='/var/lib/awx/projects/_22__storage_new'
#current_dir='/var/lib/awx/projects/_46__fiserv_storage_expansion'
#current_dir='.'
V_ticket=`cat $current_dir/final_value.txt | awk -F "," '{print $1}' | awk -F ": " '{print $2}'`
for i in ${V_ticket[@]}
do
touch $current_dir/reports/${i}.txt
echo -e "Below are the validation report for $i :\n">>$current_dir/reports/${i}.txt
host=`cat $current_dir/final_value.txt | grep -w $i | awk -F "," '{print $3}' | awk -F ": '" '{print $2}' | awk -F "'" '{print $1}'`
if [ -z $host ]
then
   echo -e "\tTicket $i doesnot have host information , getting from config file \n">>$current_dir/reports/${i}.txt
   wWn=`cat $current_dir/final_value.txt | grep -w $i | awk -F "wwn':'" '{print $2}' | awk -F "'" '{print $1}'`
   host=`grep -w $wWn $current_dir/config/config.txt | awk -F ':' '{print $1}'`
   echo -e "\tHOST server  in  action of $i : $host\n">>$current_dir/reports/${i}.txt
else
   echo -e "\tHOST server  in  action of $i : $host \n">>$current_dir/reports/${i}.txt
fi
echo -e "\tStorage group which is extended: ${host}_SG \n">>$current_dir/reports/${i}.txt
Lun_size=`cat $current_dir/final_value.txt | grep -w $i | awk -F "," '{print $2}' | awk -F ": '" '{ print $2}' | awk -F "GB'" '{print $1}'`
if [ -z $Lun_size ]
then
   echo -e "\tTicket $i doesnot have volume size information\n">>$current_dir/reports/${i}.txt
else
   echo -e "\tSize of each volume requested :  $Lun_size GB\n">>$current_dir/reports/${i}.txt
fi

Number_of_volume=`cat $current_dir/final_value.txt | grep -w $i | awk -F "," '{print $4}' | awk -F "'" '{print $4}'`
if [ -z $Number_of_volume ]
then
   echo -e "\tTicket $i doesnot have number of volume\n">>$current_dir/reports/${i}.txt
else
   echo -e "\tNumber of volume requested: $Number_of_volume\n">>$current_dir/reports/${i}.txt
fi


Wwn=`cat $current_dir/final_value.txt | grep -w $i | awk -F "wwn':'" '{print $2}' | awk -F "'" '{print $1}'`
if [ -z $Wwn ]
then
   echo -e "\tTicket $i doesnot have WWN information , getting from config file\n">>$current_dir/reports/${i}.txt
   wwn=`cat $current_dir/config/config.txt | grep -w $host | awk -F ":" '{print $2}'`
   echo -e "\tWWN for the host : $wwn\n">>$current_dir/reports/${i}.txt
else
   echo -e "\tWWN for the host : $Wwn\n">>$current_dir/reports/${i}.txt
fi




done

