#!/bin/bash
current_dir='/var/lib/awx/projects/_24__storage_new'
#current_dir='/var/lib/awx/projects/_46__fiserv_storage_expansion'
#current_dir='.'
V_ticket=`cat "$current_dir/final_value.txt" | awk -F "," '{print $1}' | awk -F ": " '{print $2}'`
        for i in ${V_ticket[@]}
        do
          V_host=`cat "$current_dir/final_value.txt" | grep -w $i | awk -F "," '{print $3}' | awk -F ": '" '{print $2}' | awk -F "'" '{print $1}'`
          Wwn=`cat "$current_dir/final_value.txt" | grep -w $i | awk -F "wwn':'" '{print $2}' | awk -F "'" '{print $1}'`
          if [ -z $V_host ]
          then
          V_host=`grep -w $Wwn $current_dir/config/config.txt | awk -F ':' '{print $1}'`
          fi
          if [ -z $Wwn ]
          then
          Wwn=`cat "$current_dir/config/config.txt" | grep -w $V_host | awk -F ":" '{print $2}'`
          fi

          touch "$current_dir/var_file/${i}.yaml"
          echo "Ticket: $i">>$current_dir/var_file/${i}.yaml
        #  V_host=`cat ../final_value.txt | grep -w $i | awk -F "," '{print $3}' | awk -F ": '" '{print $2}' | awk -F "'" '{print $1}'`
          echo "hostname: $V_host">>$current_dir/var_file/${i}.yaml
          Lun_size=`cat "$current_dir/final_value.txt" | grep -w $i | awk -F "," '{print $2}' | awk -F ": '" '{ print $2}' | awk -F "GB'" '{print $1}'`
          echo "extension_volume_size: $Lun_size">>$current_dir/var_file/${i}.yaml
          Number_of_volume=`cat "$current_dir/final_value.txt" | grep -w $i | awk -F "," '{print $4}' | awk -F "'" '{print $4}'`
          echo "extension_volume_count: $Number_of_volume">>$current_dir/var_file/${i}.yaml
        #  Wwn=`cat ../final_value.txt | grep -w $i | awk -F "wwn':'" '{print $2}' | awk -F "'" '{print $1}'`
          echo "init: [$Wwn]">>$current_dir/var_file/${i}.yaml
          echo "hostId: ${V_host}_IG">>$current_dir/var_file/${i}.yaml
          echo "maskingViewId: ${V_host}_MV">>$current_dir/var_file/${i}.yaml
          echo "storageGroupId: ${V_host}_SG">>$current_dir/var_file/${i}.yaml
          echo "remote_storage_group: ${V_host}_SG">>$current_dir/var_file/${i}.yaml
          echo "Password: smc">>$current_dir/var_file/${i}.yaml
          echo "Username: smc">>$current_dir/var_file/${i}.yaml
          echo "unisphere_url: 'https://10.241.210.217:8443'">>$current_dir/var_file/${i}.yaml
          echo "sloId: Diamond">>$current_dir/var_file/${i}.yaml
          echo "srpId: SRP_1">>$current_dir/var_file/${i}.yaml
          echo "symmetrixId: 000197600361">>$current_dir/var_file/${i}.yaml
          echo "remoteSymmId: 000197600362">>$current_dir/var_file/${i}.yaml
          echo "portgroup: Unisphere_2_PG">>$current_dir/var_file/${i}.yaml
          echo "smtp_server: mailhub.lss.emc.com">>$current_dir/var_file/${i}.yaml
          echo "email_id: nishu.prakash@emc.com">>$current_dir/var_file/${i}.yaml

        done

