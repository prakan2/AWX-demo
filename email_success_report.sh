echo "Sending precheck validation report of Servicenow Ticket which are currently in queue:"
#$(cd var_file/ ; cat RITM* > ./meregedreport.txt )
#$(cd /var/lib/awx/projects/_46__fiserv_storage_expansion/reports/)
mailx  -s "Success Report" -S smtp="mailhub.lss.emc.com" "h.shekhar@emc.com"</var/lib/awx/projects/_18__git_expansion_demo/reports/var_file/success_report.txt
