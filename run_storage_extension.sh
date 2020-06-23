#!/bin/bash
V_ticket=`cat final_value.txt | awk -F "," '{print $1}' | awk -F ": " '{print $2}'`
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
          echo "smtp_server: mailhub.lss.emc.com">>${i}.yaml
          echo "email_id: nishu.prakash@emc.com">>${i}.yaml

          ansible-playbook storage_expansion.yaml --extra-vars="myvarfile=${i}.yaml"
          mailx  -s "Update on Request  $i" -S smtp="mailhub.lss.emc.com" "Nishu.Prakash@emc.com"<success_report.txt
          rm -rf ${i}.yaml
          rm -rf success_report.txt

        done
