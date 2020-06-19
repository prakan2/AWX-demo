echo "Sending precheck validation report of Servicenow Ticket which are currently in queue:"
mailx  -s "Precheck validation reports $i" -S smtp="mailhub.lss.emc.com" "nishu.prakash@emc.com"<meregedreport.txt
