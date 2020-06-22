echo "Sending precheck validation report of Servicenow Ticket which are currently in queue:"
#$(cd /var/lib/awx/projects/_46__fiserv_storage_expansion/reports/ ; cat RITM* > ./meregedreport.txt )
$(cd /var/lib/awx/projects/_24__storage_new/reports/ ; cat RITM* > ./meregedreport.txt )
mailx  -s "Precheck validation reports $i" -S smtp="mailhub.lss.emc.com" "h.shekhar@emc.com"</var/lib/awx/projects/_24__storage_new/reports/meregedreport.txt
