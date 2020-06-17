current_dir='/var/lib/awx/projects/_18__git_expansion_demo'
echo "Sending precheck validation report of Servicenow Ticket which are currently in queue:"
#$(cd /var/lib/awx/projects/_18__git_expansion_demo/reports/ ; cat RITM* > ./meregedreport.txt )
$(cd $current_dir/reports/ ; cat RITM* > $current_dir/meregedreport.txt )
mailx  -s "Precheck validation reports $i" -S smtp="mailhub.lss.emc.com" "Nishu.Prakash@emc.com"<reports/meregedreport.txt
