echo "Sending precheck validation report of Servicenow Ticket which are currently in queue:"
<<<<<<< HEAD
#$(cd /var/lib/awx/projects/_18__git_expansion_demo/reports/ ; cat RITM* > ./meregedreport.txt )
mailx  -s "Precheck validation reports $i" -S smtp="mailhub.lss.emc.com" "nishu.prakash@emc.com"</var/lib/awx/projects/_18__git_expansion_demo/reports/*
#meregedreport.txt
=======
$(cd /var/lib/awx/projects/_18__git_expansion_demo/reports; cat RITM* > ./meregedreport.txt )
mailx  -s "Precheck validation reports $i" -S smtp="mailhub.lss.emc.com" "nishu.prakash@emc.com"</var/lib/awx/projects/_18__git_expansion_demo/reports/meregedreport.txt
>>>>>>> 74f38c55e6b7b5176706920c6c40fe682879fe0d
