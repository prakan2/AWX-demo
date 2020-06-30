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
FILE="./meregedreport.txt"
cat $FILE

rm -rf PRECHECK_${i}.txt
rm -rf meregedreport.txt

done

V_ticket_up=`cat final_value.txt | awk -F "," '{print $1}' | awk -F ": " '{print $2}'`
       for i in ${V_ticket[@]}
        do
          V_host=`cat final_value.txt | grep -w $i | awk -F "," '{print $3}' | awk -F ": '" '{print $2}' | awk -F "'" '{print $1}'`
          Wwn=`cat final_value.txt | grep -w $i | awk -F "wwn':'" '{print $2}' | awk -F "'" '{print $1}'`
          if [ -z $V_host ]
          then
          V_host=`grep -w $Wwn config.txt | awk -F ':' '{print $1}'`
          fi
          if [ -z $Wwn ]
          then
          Wwn=`cat config.txt | grep -w $V_host | awk -F ":" '{print $2}'`
          fi

          touch ${i}.yaml
          echo "Ticket: $i">>${i}.yaml
          echo "hostname: $V_host">>${i}.yaml
          Lun_size=`cat final_value.txt | grep -w $i | awk -F "," '{print $2}' | awk -F ": '" '{ print $2}' | awk -F "GB'" '{print $1}'`
          echo "extension_volume_size: $Lun_size">>${i}.yaml
          Number_of_volume=`cat final_value.txt | grep -w $i | awk -F "," '{print $4}' | awk -F "'" '{print $4}'`
          echo "extension_volume_count: $Number_of_volume">>${i}.yaml
          echo "init: [$Wwn]">>${i}.yaml
          echo "hostId: ${V_host}_IG">>${i}.yaml
          echo "maskingViewId: ${V_host}_MV">>${i}.yaml
          echo "storageGroupId: ${V_host}_SG">>${i}.yaml
          echo "remote_storage_group: ${V_host}_SG">>${i}.yaml
          echo "Password: smc">>${i}.yaml
          echo "Username: smc">>${i}.yaml
          echo "unisphere_url: 'https://10.241.210.217:8443'">>${i}.yaml
          echo "sloId: Diamond">>${i}.yaml
          echo "srpId: SRP_1">>${i}.yaml
          echo "symmetrixId: 000197600361">>${i}.yaml
          echo "remoteSymmId: 000197600362">>${i}.yaml
          echo "portgroup: Unisphere_2_PG">>${i}.yaml

          ansible-playbook storage_expansion.yaml --extra-vars="myvarfile=${i}.yaml"
          FILE_S="success_report.txt"
	  cat $FILE_S
          rm -rf ${i}.yaml
          rm -rf success_report.txt
	done
