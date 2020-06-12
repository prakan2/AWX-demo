echo "Sending precheck validation report of Servicenow Ticket which are currently in queue:"
$(cd reports/ ; cat RITM* > ./meregedreport.txt )
mailx  -s "Precheck validation reports $i" -S smtp="mailhub.lss.emc.com" "Nishu.Prakash@emc.com"</var/lib/awx/projects/_18__git_expansion_demo/reports/meregedreport.txt
