#!/bin/bash
V_ticket=`cat final_value.txt | awk -F "," '{print $1}' | awk -F ": " '{print $2}'`
for i in ${V_ticket[@]}
do
touch PRECHECK_${i}.txt
echo -e "Below are the validation report for $i :\n">>PRECHECK_${i}.txt
host=`cat final_value.txt | grep -w $i | awk -F "," '{print $3}' | awk -F ": '" '{print $2}' | awk -F "'" '{print $1}'`
if [ -z $host ]
then
   echo -e "\tTicket $i doesnot have host information , getting from config file \n">>PRECHECK_${i}.txt
   wWn=`cat final_value.txt | grep -w $i | awk -F "wwn':'" '{print $2}' | awk -F "'" '{print $1}'`
   host=`cat config.txt | grep -w $wWn | awk -F ':' '{print $1}'`
   echo -e "\tHOST server  in  action of $i : $host\n">>PRECHECK_${i}.txt
else
   echo -e "\tHOST server  in  action of $i : $host \n">>PRECHECK_${i}.txt
fi
echo -e "\tStorage group which is extended: ${host}_SG \n">>PRECHECK_${i}.txt
Lun_size=`cat final_value.txt | grep -w $i | awk -F "," '{print $2}' | awk -F ": '" '{ print $2}' | awk -F "GB'" '{print $1}'`
if [ -z $Lun_size ]
then
   echo -e "\tTicket $i doesnot have volume size information\n">>PRECHECK_${i}.txt
else
   echo -e "\tSize of each volume requested :  $Lun_size GB\n">>PRECHECK_${i}.txt
fi

Number_of_volume=`cat final_value.txt | grep -w $i | awk -F "," '{print $4}' | awk -F "'" '{print $4}'`
if [ -z $Number_of_volume ]
then
   echo -e "\tTicket $i doesnot have number of volume\n">>PRECHECK_${i}.txt
else
   echo -e "\tNumber of volume requested: $Number_of_volume\n">>PRECHECK_${i}.txt
fi


Wwn=`cat final_value.txt | grep -w $i | awk -F "wwn':'" '{print $2}' | awk -F "'" '{print $1}'`
if [ -z $Wwn ]
then
   echo -e "\tTicket $i doesnot have WWN information , getting from config file\n">>PRECHECK_${i}.txt
   wwn=`cat config.txt | grep -w $host | awk -F ":" '{print $2}'`
   echo -e "\tWWN for the host : $wwn\n">>PRECHECK_${i}.txt
else
   echo -e "\tWWN for the host : $Wwn\n">>PRECHECK_${i}.txt
fi

cat PRECHECK* > ./meregedreport.txt
mailx  -s "Precheck validation reports $i" -S smtp="mailhub.lss.emc.com" "Nishu.Prakash@emc.com"<meregedreport.txt

#rm -rf PRECHECK_${i}.txt
#rm -rf meregedreport.txt


done

