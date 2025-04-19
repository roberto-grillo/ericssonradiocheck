#!/bin/bash

function menu_01 {
  activity="default_checks"
  assign_name_to_the_report
  #valorizzato custom_folder
  amosbatch_list
  create_checks
  append_checks
  advanced_options
  echo -e "\n\n#################  Amosbatch is starting to execute the following commands #################"
  cat $fullpath/cmd/${date}_cmds_auto_checks.mos
  echo -e "\n####################################################################################\n\n"
  logfile_amosbatch="$fullpath/temp/$custom_folder.log"
  $amosbatch_command -p $processes -t $timeout $jardir_command $LISTA $fullpath/cmd/${date}_cmds_auto_checks.mos |tee "$logfile_amosbatch"
  copy_amosbatch_log_folder
  delete_checks
  if [[ $autogeneration_xlsx == "1" ]]; then
    excel_report
  fi
}

function menu_CA {
  activity="changeall"
  assign_name_to_the_changeall
  amosbatch_list
  amosbatch_changeall
  advanced_options
  areyousure
  if [[ $mobatch_changeall =~ ".csv" ]]; then
    cat "$fullpath/changeall/$mobatch_changeall" | grep MO | grep Parameter | awk -F";" '{ for (i = 6; i <= NF; ++i) print "- " $i; exit }'
    read -e -p "Choose the Test Case: " test_case
    find_column=$(cat "$fullpath/changeall/$mobatch_changeall" | grep MO | grep Parameter | awk -F";" '{ for (i = 6; i <= NF; ++i) print i, $i; exit }' |grep "$test_case" |awk '{ print $1 }')
    echo -e "\n\nSCRIPT:\n"
    cat "$fullpath/changeall/$mobatch_changeall" |awk -F";" -v column="$find_column" '{print "set "$1" "$2" "$column}' |sed '1d' |grep -v ^$ |sed '1i lt all' |sed '1i gsg+' |sed '1i confbl+' |sed '$a gsg-' |sed '$a confbl-'
    echo -e "\n\n\n"
    cat "$fullpath/changeall/$mobatch_changeall" |awk -F";" -v column="$find_column" '{print "set "$1" "$2" "$column}' |sed '1d' |grep -v ^$ |sed '1i lt all' |sed '1i gsg+' |sed '1i confbl+' |sed '$a gsg-' |sed '$a confbl-' > $fullpath/changeall/$test_case.mos
    read -e -p "Do you want to proceed with the set? " sure_set
    
    if [[ $sure_set =~ "y" ]]; then
        logfile_amosbatch="$fullpath/temp/$custom_folder.log"
        $amosbatch_command -p $processes -t $timeout $jardir_command $LISTA $fullpath/changeall/$test_case.mos |tee "$logfile_amosbatch"
        copy_amosbatch_log_folder
    fi
  else
    logfile_amosbatch="$fullpath/temp/$custom_folder.log"
    $amosbatch_command -p $processes -t $timeout $jardir_command $LISTA $fullpath/changeall/$mobatch_changeall |tee "$logfile_amosbatch"
    copy_amosbatch_log_folder
  fi
}

function menu_02 {
  activity="custom_checks"
  assign_name_to_the_activity
  amosbatch_list
  create_checks
  append_custom_checks
  advanced_options
  echo -e "\n\n#################  Amosbatch will execute the following commands #################"
  cat $fullpath/cmd/${date}_cmds_auto_checks.mos
  echo -e "\n####################################################################################\n\n"
  logfile_amosbatch="$fullpath/temp/$custom_folder.log"
  $amosbatch_command -p $processes -t $timeout $jardir_command $LISTA $fullpath/cmd/${date}_cmds_auto_checks.mos |tee "$logfile_amosbatch"
  copy_amosbatch_log_folder
  delete_checks
}

function menu_03 {
  activity="default_custom_checks"
  assign_name_to_the_report
  amosbatch_list
  create_checks
  append_checks
  append_custom_checks
  advanced_options
  echo -e "\n\n#################  Amosbatch will execute the following commands #################"
  cat $fullpath/cmd/${date}_cmds_auto_checks.mos
  echo -e "\n####################################################################################\n\n"
  logfile_amosbatch="$fullpath/temp/$custom_folder.log"
  $amosbatch_command -p $processes -t $timeout $jardir_command $LISTA $fullpath/cmd/${date}_cmds_auto_checks.mos |tee "$logfile_amosbatch"
  copy_amosbatch_log_folder
  delete_checks
  if [[ $autogeneration_xlsx == "1" ]]; then
    excel_report
  fi
}

function menu_KD {
  activity="dump"
  assign_name_to_the_activity
  amosbatch_list
  create_checks
  append_checks
  advanced_options
  echo -e "\n\n###############################################################"
  echo -e "###                         WARNING                         ###"
  echo -e "###Amosbatch will collect the DUMP of every node of the list###"
  echo -e "###############################################################\n\n"
  logfile_amosbatch="$fullpath/temp/$custom_folder.log"
  $amosbatch_command -p $processes -t $timeout $jardir_command $LISTA "lt all;kget" |tee "$logfile_amosbatch"
  copy_amosbatch_log_folder
  zip_amosbatch_log_files
  rm $fullpath/log/$custom_folder/*.log
  chmod 777 $fullpath/log/$custom_folder/*.zip
  delete_checks
}

function menu_BC {
  activity="clean"
  assign_name_to_the_activity
  amosbatch_list
  create_checks
  append_checks
  advanced_options
  echo -e "\n\n###############################################################"
  echo -e "###                         WARNING                         ###"
  echo -e "###Amosbatch will clean the backup auto CV of every node of the list###"
  echo -e "###############################################################\n\n"
  logfile_amosbatch="$fullpath/temp/$custom_folder.log"
  $amosbatch_command -p $processes -t $timeout $jardir_command $LISTA $fullpath/cmd/safe_backup.mos |tee "$logfile_amosbatch"
  copy_amosbatch_log_folder
  delete_checks
}

function menu_mom {
  activity="dl_mom"
  assign_name_to_the_activity
  amosbatch_list
  advanced_options
  echo -e "\n\n#################  Amosbatch will execute the following commands #################"
  cat $fullpath/cmd/download_mom.mos
  echo -e "\n####################################################################################\n\n"
  shuf -n 100 "$LISTA" > $fullpath/lists/temp_mom_list_100_nodes
  chmod 777 $fullpath/lists/temp_mom_list_100_nodes
  logfile_amosbatch="$fullpath/temp/$custom_folder.log"
  $amosbatch_command -p $processes -t $timeout $jardir_command $fullpath/lists/temp_mom_list_100_nodes $fullpath/cmd/download_mom.mos |tee "$logfile_amosbatch"
  copy_amosbatch_log_folder
}

function menu_HC {
  activity="chkhwac_checks"
  assign_name_to_the_activity
  amosbatch_list
  advanced_options
  echo -e "\n\n###################################################\n"
  echo -e "Amosbatch will execute the following commands:"
  echo -e "run \$scripts/chkHwac.mos"
  echo -e "\n###################################################\n\n"
  logfile_amosbatch="$fullpath/temp/$custom_folder.log"
  $amosbatch_command -p $processes -t $timeout $jardir_command $LISTA 'run $scripts/chkHwac.mos' |tee "$logfile_amosbatch"
  copy_amosbatch_log_folder
  delete_checks
}

function menu_x {
  choose_folder
  export_file="$fullpath/report_xlsx/${cartella1}.xlsx"
  export_html_file="$fullpath/report_html/${cartella1}.html"
  echo -e "Processing..."
  aggregation_single_menu $cartella1  >/dev/null
  $python_command $fullpath/tools/create_xlsx.py "$export_file"
  $python_command $fullpath/tools/create_xlsx_single_report.py "$export_file" 1 2 3 4 5 6 7 "$input_file8" "$input_file9" "$input_file10" "$input_file11" "$input_file12" "$input_file13" "$input_file14" "$input_file15" "$input_file16" "$input_file17" "$input_file18"
  
  #new
  source $fullpath/tools/html.sh $input_file8 $input_file9 $input_file10 $input_file11 $input_file12 $input_file13 $input_file14 $input_file15 $input_file16 $input_file17 $input_file18 > ${export_html_file}
  ###
    
  rm $fullpath/temp/"${date_report}_${current_user}"*
  
  mv "$export_file" "$(echo "$export_file" | sed 's/_report_/_/g')"
  mv "$export_html_file" "$(echo "$export_html_file" | sed 's/_report_/_/g')"
  cp $fullpath/tools/main.html $fullpath/report_html/
  update_html_index
  echo -e "\nCompleted."
}

function menu_xm {
  choose_folders
  export_file="$fullpath/report_xlsx/merge_${cartella1}_${cartella2}.xlsx"
  export_html_file="$fullpath/report_html/merge_${cartella1}_${cartella2}.html"
  echo -e "Processing..."
  aggregation_menu $cartella1 $cartella2   >/dev/null
  $python_command $fullpath/tools/create_xlsx.py "$export_file"
  $python_command $fullpath/tools/create_xlsx_report.py "$export_file" "$input_file1" "$input_file2" "$input_file3" "$input_file4" "$input_file5" "$input_file6" "$input_file7" "$input_file8" "$input_file9" "$input_file10" "$input_file11" "$input_file12" "$input_file13" "$input_file14" "$input_file15" "$input_file16" "$input_file17" "$input_file18"
  
  
  ##new
  cat $fullpath/tools/html_create_first.html                                                                                                 >  ${export_html_file}
  ### inizio parte script per primo grafico
  cat $fullpath/tools/html_create_02.html                                                                                                    >> ${export_html_file}
  cat $input_file5 |grep -v PROBLEMTYPE |awk -F";" '{print "{ProblemType: \""       $2    "\",Amount: "    $3      "}," }'                   >> ${export_html_file}
  cat $fullpath/tools/html_create_04.html                                                                                                    >> ${export_html_file}
  ### fine   parte script per primo grafico
  
  ### inizio parte script per secondo grafico
  cat $fullpath/tools/html_create_12.html                                                                                                    >> ${export_html_file}
  cat $input_file6 |grep -v MANAGEDOBJECT |awk -F";" '{print "{ManagedObject: \""       $2    "\",Amount: "    $3      "}," }'               >> ${export_html_file}
  cat $fullpath/tools/html_create_14.html                                                                                                    >> ${export_html_file}
  ### fine   parte script per secondo grafico
  
  cat $fullpath/tools/html_create_last_n.html          |sed  "s/DATA_REPORT/${date_report}/g"   |sed  "s/UTENTE_CORRENTE/${current_user}/g"  >> ${export_html_file}
  source $fullpath/tools/html_delta.sh "$input_file1" "$input_file2" "$input_file3" "$input_file4" "$input_file5" "$input_file6" "$input_file7" "$input_file8" "$input_file9" "${input_file10}" "${input_file11}" "${input_file12}" "${input_file13}" "${input_file14}" "${input_file15}" "${input_file16}" "${input_file17}" "${input_file18}" >> ${export_html_file}
  cat $fullpath/tools/html_create_last.html                                                                                                  >> ${export_html_file}
########



  rm $fullpath/temp/"${date_report}_${current_user}"*
  mv "$export_file" "$(echo "$export_file" | sed 's/_report_/_/g')"
  mv "$export_html_file" "$(echo "$export_html_file" | sed 's/_report_/_/g')"

  cp $fullpath/tools/main.html $fullpath/report_html/
  update_html_index
  echo -e "\nCompleted."


}

function menu_xd {
  choose_folders
  export_file="$fullpath/report_xlsx/delta_${cartella1}_${cartella2}.xlsx"
  export_html_file="$fullpath/report_html/delta_${cartella1}_${cartella2}.html"
  echo -e "Processing..."
  aggregation_menu_delta $cartella1 $cartella2   >/dev/null
  $python_command $fullpath/tools/create_xlsx.py "$export_file"
  $python_command $fullpath/tools/create_xlsx_report.py "$export_file" "$input_file1" "$input_file2" "$input_file3" "$input_file4" "$input_file5" "$input_file6" "$input_file7" "$input_file8" "$input_file9" "$input_file10" "$input_file11" "$input_file12" "$input_file13" "$input_file14" "$input_file15" "$input_file16" "$input_file17" "$input_file18"


  ##new
  cat $fullpath/tools/html_create_first.html                                                                                                 >  ${export_html_file}
  ### inizio parte script per primo grafico
  cat $fullpath/tools/html_create_02.html                                                                                                    >> ${export_html_file}
  cat $input_file5 |grep -v PROBLEMTYPE |awk -F";" '{print "{ProblemType: \""       $2    "\",Amount: "    $3      "}," }'                   >> ${export_html_file}
  cat $fullpath/tools/html_create_04.html                                                                                                    >> ${export_html_file}
  ### fine   parte script per primo grafico
  
  ### inizio parte script per secondo grafico
  cat $fullpath/tools/html_create_12.html                                                                                                    >> ${export_html_file}
  cat $input_file6 |grep -v MANAGEDOBJECT |awk -F";" '{print "{ManagedObject: \""       $2    "\",Amount: "    $3      "}," }'               >> ${export_html_file}
  cat $fullpath/tools/html_create_14.html                                                                                                    >> ${export_html_file}
  ### fine   parte script per secondo grafico
  
  cat $fullpath/tools/html_create_last_n.html          |sed  "s/DATA_REPORT/${date_report}/g"   |sed  "s/UTENTE_CORRENTE/${current_user}/g"  >> ${export_html_file}
  source $fullpath/tools/html_delta.sh "$input_file1" "$input_file2" "$input_file3" "$input_file4" "$input_file5" "$input_file6" "$input_file7" "$input_file8" "$input_file9" "${input_file10}" "${input_file11}" "${input_file12}" "${input_file13}" "${input_file14}" "${input_file15}" "${input_file16}" "${input_file17}" "${input_file18}" >> ${export_html_file}
  cat $fullpath/tools/html_create_last.html                                                                                                  >> ${export_html_file}
  ##################
  
  
  
  rm $fullpath/temp/"${date_report}_${current_user}"*
  mv "$export_file" "$(echo "$export_file" | sed 's/_report_/_/g')"
  mv "$export_html_file" "$(echo "$export_html_file" | sed 's/_report_/_/g')"
  
  cp $fullpath/tools/main.html $fullpath/report_html/
  update_html_index
  echo -e "\nCompleted."
}





function menu_50() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  debug_report
}

function menu_51() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_change_all_errors.txt"
  echo -e "\nChangeAll Errors\n"
  grep -H "ERROR"              $fullpath/log/$cartella1/*.log |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/\t/g'   |sed "1i\\$separator" |sed "\$a\\$separator"
  echo -e "\n"
  grep -H "CORBA.COMM_FAILURE" $fullpath/log/$cartella1/*.log |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/\t/g'   |sed "1i\\$separator" |sed "\$a\\$separator"
}

function menu_52() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_change_all_nochange.txt"
  echo -e "\nChangeAll: Parameters - No Change\n"
  grep -H . $fullpath/log/$cartella1/*.log |grep -v "Last MO" |grep "no change" |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/ /g' |awk -F" " '{print $1,$(NF-1),$NF}' |sed 's/-$//g' |sed 's/ -/ /g' | sort | uniq -c | sort -n |awk '{print $2":", $1, $3, $4}'
}

function menu_53() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_change_all_set.txt"
  echo -e "\nChangeAll: Parameters - Set\n"
  grep -H . $fullpath/log/$cartella1/*.log |grep -v "Last MO" |grep " Set." |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/ /g' |awk -F" " '{print $1,$NF}' | sort | uniq -c | sort -n |awk '{print $2":", $1, $3}'
}

function menu_54() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_change_all_deleted.txt"
  echo -e "\nChangeAll: MO Deleted\n"
  grep -H . $fullpath/log/$cartella1/*.log |grep -v "Last MO" |grep " Mo deleted" |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/ /g' |awk -F" " '{print $1,$(NF-1),$NF}' |sed 's/-$//g' |sed 's/ -/ /g' | sort | uniq -c | sort -n |awk '{print $2":", $1, $3, $4}'
}

function menu_55() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_change_all_created.txt"
  echo -e "\nChangeAll: MO Created\n"
  grep -H . $fullpath/log/$cartella1/*.log |grep -v "Last MO" |grep "Proxy ID = " |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/ /g' |sed 's/>>>/;/' |sed 's/  *//'
}

function menu_60() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file0="${date_report}_${current_user}_lista_ok.txt"
  report_file1="${date_report}_${current_user}_change_all_nochange.txt"
  report_file2="${date_report}_${current_user}_change_all_set.txt"
  report_file3="${date_report}_${current_user}_change_all_deleted.txt"
  report_file01="${date_report}_${current_user}_lista_ok_nochange.txt"
  report_file012="${date_report}_${current_user}_lista_ok_nochange_set.txt"
  report_file0123="${date_report}_${current_user}_lista_ok_nochange_set_deleted.txt"
  report_file="${date_report}_${current_user}_change_all_actions_executed.txt"
  echo -e "NODE:N. No Change:N. Set:N. Deleted"   > $fullpath/temp/$report_file
  cat $fullpath/log/$cartella1/mobatch_result.txt |grep "OK  " |awk -F" " '{print $3}'    |sort                                                                                                                                                                            > $fullpath/temp/$report_file0
  grep -H . $fullpath/log/$cartella1/*.log |grep -v "Last MO" |grep "no change"   |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/ /g' |awk -F" " '{print $1,$(NF-1),$NF}' |sed 's/-$//g' |sed 's/ -/ /g' | sort | uniq -c | sort -n |awk '{print $2":", $1, $3, $4}' |sort > $fullpath/temp/$report_file1
  grep -H . $fullpath/log/$cartella1/*.log |grep -v "Last MO" |grep " Set."       |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/ /g' |awk -F" " '{print $1,$NF}'                                        | sort | uniq -c | sort -n |awk '{print $2":", $1, $3}'     |sort > $fullpath/temp/$report_file2
  grep -H . $fullpath/log/$cartella1/*.log |grep -v "Last MO" |grep " Mo deleted" |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/ /g' |awk -F" " '{print $1,$(NF-1),$NF}' |sed 's/-$//g' |sed 's/ -/ /g' | sort | uniq -c | sort -n |awk '{print $2":", $1, $3, $4}' |sort > $fullpath/temp/$report_file3
  join -t":" -a1 -a2 -e "na" -o 0,2.2            $fullpath/temp/$report_file0   $fullpath/temp/$report_file1   >   $fullpath/temp/$report_file01
  join -t":" -a1 -a2 -e "na" -o 0,1.2,2.2        $fullpath/temp/$report_file01  $fullpath/temp/$report_file2   >   $fullpath/temp/$report_file012
  join -t":" -a1 -a2 -e "na" -o 0,1.2,1.3,2.2    $fullpath/temp/$report_file012 $fullpath/temp/$report_file3   >   $fullpath/temp/$report_file0123
  cat $fullpath/temp/$report_file0123 >> $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s":" -t -o '        ' |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) BB"
}

function menu_40() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file1="${date_report}_${current_user}_rats.csv"
  report_file2="${date_report}_${current_user}_ratsconfig.csv"
  echo "NODE;RATS"  > $fullpath/temp/$report_file1
  chmod 777 $fullpath/temp/$report_file1
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'  |grep "\$rats = "       |sort   |sed 's/..(//g' |sed 's/)//g'  |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |sed 's/$rats = //g'               >> $fullpath/temp/$report_file1
  echo "NODE;RATSCONFIG"  > $fullpath/temp/$report_file2
  chmod 777 $fullpath/temp/$report_file2
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'  |grep "\$ratsconfig = " |sort   |sed 's/..(//g' |sed 's/)//g'  |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |sed 's/$ratsconfig = //g'         >> $fullpath/temp/$report_file2
  paste $fullpath/temp/$report_file1 $fullpath/temp/$report_file2 |column -s ';' -t |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo "Total: $(cat $fullpath/temp/$report_file1 |grep -c .) BB"
}


function menu_10() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  ls $fullpath/log/$cartella1/
  echo -e "\n"
  read -e -p "Choose the log file or node name: " nodelog

  # Check if $nodelog ends with .log
  if [[ $nodelog != *.log ]]; then
    nodelog="${nodelog}.log"
  fi
  
  cat $fullpath/log/$cartella1/$nodelog
}


function menu_10s() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  ls $fullpath/log/$cartella1/
  echo -e "\n"
  read -e -p "Choose the log file or node name: " nodelog

  # Check if $nodelog ends with .log
  if [[ $nodelog != *.log ]]; then
    nodelog="${nodelog}.log"
  fi


  echo -e "\n\nCELLS REPORT"
  grep -H . $fullpath/log/$cartella1/$nodelog |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |egrep "ABLED\)|LOCKED\)" |grep -v ";" |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's/NodeBLocalCellGroup=1,//g' |sort |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |column -s ';' -t  |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"

  echo -e "\n\nALARMS REPORT"
# grep -H . $fullpath/log/$cartella1/$nodelog |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |sed -n '/Date;Time;Severity/,/Total: /p' |grep -v "Date;Time;Severity" |grep -v "Total: "  |sort |sed 's/\//--SEP--/g' |sed 's/.log:/--SEP--/g' |awk -F"--SEP--" 'BEGIN {print "NODE;DATE;TIME;SEVERITY;OBJECT;PROBLEM;CAUSE;ADDITIONALSTATE;ACKSTATE;ALARMID;NOTIFICATIONID;"}{sub(/\r$/, ""); print $(NF-1)";"$NF}' |column -s ';' -t  |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  grep -H . $fullpath/log/$cartella1/$nodelog |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |sed -n '/Date;Time;Severity/,/Total: /p' |grep -v "Date;Time;Severity" |grep -v "Total: "  |sort |sed 's%.*/\([^/]*\.log\):%\1:%' |awk -F".log:" 'BEGIN {print "NODE;DATE;TIME;SEVERITY;OBJECT;PROBLEM;CAUSE;ADDITIONALSTATE;ACKSTATE;ALARMID;NOTIFICATIONID;"}{sub(/\r$/, ""); print $(NF-1)";"$NF}' |column -s ';' -t  |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo -e "\n"
}

function menu_10m() {
  if [ $# -ne 2 ]; then
    choose_folders
  else
    cartella1=$1
	cartella2=$2
  fi
  echo -e "\n\nLogs of both folders."
  echo -e "\nFolder 1:"
  ls $fullpath/log/$cartella1/
  echo -e "Folder 2:"
  ls $fullpath/log/$cartella2/
  read -e -p "Choose the log file or node name: " nodelog
  # Check if $nodelog ends with .log
  if [[ $nodelog != *.log ]]; then
    nodelog="${nodelog}.log"
  fi
  
  echo -e "\n\n******************************************************** CELLS REPORT ********************************************************\nFolder 1:"

  grep -H . $fullpath/log/$cartella1/$nodelog |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |egrep "ABLED\)|LOCKED\)" |grep -v ";" |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's/NodeBLocalCellGroup=1,//g' |sort |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |column -s ';' -t  |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo -e "\n\n\nFolder 2:"
  grep -H . $fullpath/log/$cartella2/$nodelog |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |egrep "ABLED\)|LOCKED\)" |grep -v ";" |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's/NodeBLocalCellGroup=1,//g' |sort |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |column -s ';' -t  |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo -e "******************************************************************************************************************************\n"

  echo -e "\n\n******************************************************** ALARMS REPORT ********************************************************\nFolder1:"

  grep -H . $fullpath/log/$cartella1/$nodelog |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |sed -n '/Date;Time;Severity/,/Total: /p' |grep -v "Date;Time;Severity" |grep -v "Total: "  |sort |sed 's%.*/\([^/]*\.log\):%\1:%' |awk -F".log:" 'BEGIN {print "NODE;DATE;TIME;SEVERITY;OBJECT;PROBLEM;CAUSE;ADDITIONALSTATE;ACKSTATE;ALARMID;NOTIFICATIONID;"}{sub(/\r$/, ""); print $(NF-1)";"$NF}' |column -s ';' -t  |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"

  echo -e "\n\n\nFolder 2:"
  grep -H . $fullpath/log/$cartella2/$nodelog |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |sed -n '/Date;Time;Severity/,/Total: /p' |grep -v "Date;Time;Severity" |grep -v "Total: "  |sort |sed 's%.*/\([^/]*\.log\):%\1:%' |awk -F".log:" 'BEGIN {print "NODE;DATE;TIME;SEVERITY;OBJECT;PROBLEM;CAUSE;ADDITIONALSTATE;ACKSTATE;ALARMID;NOTIFICATIONID;"}{sub(/\r$/, ""); print $(NF-1)";"$NF}' |column -s ';' -t  |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo -e "******************************************************************************************************************************\n"
}




function menu_11() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file1="${date_report}_${current_user}_cells.csv"
  report_file2="${date_report}_${current_user}_cell_sleep.csv"
  report_file_temp1="${date_report}_${current_user}_fddcomplete.tmp"
  report_file="${date_report}_${current_user}_fddcomplete.csv"
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |egrep "ABLED|LOCKED" |grep EUtranCell.DD      |grep -v ";"                    |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g'                                      > $fullpath/temp/$report_file1
  chmod 777 $fullpath/temp/$report_file1
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'                       |grep CellSleepFunction= |grep -v ";" |grep -v sleepMode |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g'  |sed 's/,CellSleepFunction=1;/;/g'  > $fullpath/temp/$report_file2
  chmod 777 $fullpath/temp/$report_file2

  echo "EUTRANCELL;NODE;ADMINISTRATIVE;OPERATIONAL;NODE;SLEEPMODE;SLEEPSTATE;"                                                                                                                                                                          > $fullpath/temp/$report_file_temp1
  awk -F ";" '{ key[$2]=key[$2] ";"$1";"$3";"$4} END { for (i in key) print i key[i]}' $fullpath/temp/$report_file1 $fullpath/temp/$report_file2        |sort                                                                                          >> $fullpath/temp/$report_file_temp1

  cat $fullpath/temp/$report_file_temp1 |awk -F";" '{print $2";"$1";"$3";"$4";"$6";"$7}' |sed 's/EUtranCell.DD=//g'                                                                                                                                     > $fullpath/temp/$report_file

  cat $fullpath/temp/$report_file |column -s ';' -t  |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo -e "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) MOs"
  
  rm $fullpath/temp/$report_file_temp1
  rm $fullpath/temp/$report_file1
  rm $fullpath/temp/$report_file2
}

function menu_12() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file1="${date_report}_${current_user}_cells.csv"
  report_file2="${date_report}_${current_user}_cell_sleep.csv"
  report_file_temp1="${date_report}_${current_user}_fddcomplete.tmp"
  report_file="${date_report}_${current_user}_fddcomplete_on.csv"
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |egrep "ABLED|LOCKED" |grep EUtranCell.DD      |grep -v ";"                    |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' >> $fullpath/temp/$report_file1
  chmod 777 $fullpath/temp/$report_file1

  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'                       |grep CellSleepFunction= |grep -v ";" |grep -v sleepMode |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g'  |sed 's/,CellSleepFunction=1;/;/g'  >> $fullpath/temp/$report_file2
  chmod 777 $fullpath/temp/$report_file2

 echo "EUTRANCELL;NODE;ADMINISTRATIVE;OPERATIONAL;NODE;SLEEPMODE;SLEEPSTATE;"                                                                                                                                                                                                           > $fullpath/temp/$report_file_temp1
  awk -F ";" '{ key[$2]=key[$2] ";"$1";"$3";"$4} END { for (i in key) print i key[i]}' $fullpath/temp/$report_file1 $fullpath/temp/$report_file2           |sort                                                                                                                       >> $fullpath/temp/$report_file_temp1
  cat $fullpath/temp/$report_file_temp1 |awk -F";" '{ print $2";"$1";"$3";"$4";"$6";"$7}' |sed 's/EUtranCell.DD=//g'                                                                                                                                                                    > $fullpath/temp/$report_file
  
  cat $fullpath/temp/$report_file |awk -F";" '{if (($4=="ENABLED") || ($4=="OPERATIONAL" && $6=="SLEEPSTATE")) print $1";"$2";"$3";"$4";"$5";"$6";"$7";"}' |sed 's/;/\t/g' |expand -t16   |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo -e "Total: $(cat $fullpath/temp/$report_file |awk -F";" '{if ($4=="ENABLED") print $1";"$2";"$3";"$4";"$5";"$6";"$7";"}' |grep -v NODE |grep -c .) MOs"
  rm $fullpath/temp/$report_file_temp1
  rm $fullpath/temp/$report_file1
  rm $fullpath/temp/$report_file2

}

function menu_13() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file1="${date_report}_${current_user}_cells.csv"
  report_file2="${date_report}_${current_user}_cell_sleep.csv"
  report_file_temp1="${date_report}_${current_user}_fddcomplete.tmp"
  report_file="${date_report}_${current_user}_fddcomplete_off.csv"
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |egrep "ABLED|LOCKED" |grep EUtranCell.DD      |grep -v ";"                    |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g'                                       >> $fullpath/temp/$report_file1
  chmod 777 $fullpath/temp/$report_file1

  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'                       |grep CellSleepFunction= |grep -v ";" |grep -v sleepMode |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g'  |sed 's/,CellSleepFunction=1;/;/g'  >> $fullpath/temp/$report_file2
  chmod 777 $fullpath/temp/$report_file2

  echo "EUTRANCELL;NODE;ADMINISTRATIVE;OPERATIONAL;NODE;SLEEPMODE;SLEEPSTATE;"                                                                                                                                                                                                                                       > $fullpath/temp/$report_file_temp1
  awk -F ";" '{ key[$2]=key[$2] ";"$1";"$3";"$4} END { for (i in key) print i key[i]}' $fullpath/temp/$report_file1 $fullpath/temp/$report_file2         |sort                                                                                                                                                     >> $fullpath/temp/$report_file_temp1
  cat $fullpath/temp/$report_file_temp1 |awk -F";" '{ print $2";"$1";"$3";"$4";"$6";"$7}' |sed 's/EUtranCell.DD=//g'                                                                                                                                                                                                > $fullpath/temp/$report_file
  
  cat $fullpath/temp/$report_file |awk -F";" '{if (($4=="DISABLED" && $6=="DEACTIVATED") || ($4=="OPERATIONAL" && $6=="SLEEPSTATE")) print $1";"$2";"$3";"$4";"$5";"$6";"$7";"}' |sed 's/;/\t/g' |expand -t16   |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo -e "Total: $(cat $fullpath/temp/$report_file |awk -F";" '{if ($4=="DISABLED" && $6=="DEACTIVATED") print $1";"$2";"$3";"$4";"$5";"$6";"$7";"}' |grep -v NODE |grep -c .) MOs"
  rm $fullpath/temp/$report_file_temp1
  rm $fullpath/temp/$report_file1
  rm $fullpath/temp/$report_file2
}

function menu_14() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file1="${date_report}_${current_user}_cells.csv"
  report_file2="${date_report}_${current_user}_cell_sleep.csv"
  report_file_temp1="${date_report}_${current_user}_fddcomplete.tmp"
  report_file="${date_report}_${current_user}_fddcomplete_sleeping.csv"
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |egrep "ABLED|LOCKED" |grep EUtranCell.DD      |grep -v ";"                    |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g'                                   >> $fullpath/temp/$report_file1
  chmod 777 $fullpath/temp/$report_file1

  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'                       |grep CellSleepFunction= |grep -v ";" |grep -v sleepMode |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g'  |sed 's/,CellSleepFunction=1;/;/g'          >> $fullpath/temp/$report_file2
  chmod 777 $fullpath/temp/$report_file2

 echo "EUTRANCELL;NODE;ADMINISTRATIVE;OPERATIONAL;NODE;SLEEPMODE;SLEEPSTATE;"                                                                                                                                                                                                                                                > $fullpath/temp/$report_file_temp1
  awk -F ";" '{ key[$2]=key[$2] ";"$1";"$3";"$4} END { for (i in key) print i key[i]}' $fullpath/temp/$report_file1 $fullpath/temp/$report_file2              |sort                                                                                                                                                         >> $fullpath/temp/$report_file_temp1
  cat $fullpath/temp/$report_file_temp1 |awk -F";" '{ print $2";"$1";"$3";"$4";"$6";"$7}' |sed 's/EUtranCell.DD=//g'                                                                                                                                                                                                         > $fullpath/temp/$report_file
  
  cat $fullpath/temp/$report_file |awk -F";" '{if (($4=="DISABLED" && $6=="ACTIVATED") || ($4=="OPERATIONAL" && $6=="SLEEPSTATE")) print $1";"$2";"$3";"$4";"$5";"$6";"$7";"}' |sed 's/;/\t/g' |expand -t16   |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo -e "Total: $(cat $fullpath/temp/$report_file |awk -F";" '{if ($4=="DISABLED" && $6=="ACTIVATED") print $1";"$2";"$3";"$4";"$5";"$6";"$7";"}' |grep -v NODE |grep -c .) MOs"
  rm $fullpath/temp/$report_file_temp1
  rm $fullpath/temp/$report_file1
  rm $fullpath/temp/$report_file2
}

function _menu_11m {
  N1report_file1="${date_report}_${current_user}_1cells.csv"
  N1report_file2="${date_report}_${current_user}_1cell_sleep.csv"
  N1report_file_temp1="${date_report}_${current_user}_${cartella1}_1fddcomplete.tmp"
  N1report_file="${date_report}_${current_user}_${cartella1}_1fddcomplete.csv"
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |egrep "ABLED|LOCKED" |grep EUtranCell.DD      |grep -v ";"                    |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g'                                       > $fullpath/temp/$N1report_file1
  chmod 777 $fullpath/temp/$N1report_file1
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'                       |grep CellSleepFunction= |grep -v ";" |grep -v sleepMode |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g'  |sed 's/,CellSleepFunction=1;/;/g'   > $fullpath/temp/$N1report_file2
  chmod 777 $fullpath/temp/$N1report_file2
  awk -F ";" '{ key[$2]=key[$2] ";"$1";"$3";"$4} END { for (i in key) print i key[i]}' $fullpath/temp/$N1report_file1 $fullpath/temp/$N1report_file2           |sort                                                                                                                                                        > $fullpath/temp/$N1report_file_temp1
  cat $fullpath/temp/$N1report_file_temp1 |awk -v OFS=";" -F";" '{sub(/\r$/, ""); print $1,$2,$3,$4,$6,$7,"na;na;na;na;na"}' |sed 's/EUtranCell.DD=//g'        |sort -t ';' -k1,1                                                                                                                                           > $fullpath/temp/$N1report_file

  N2report_file1="${date_report}_${current_user}_2cells.csv"
  N2report_file2="${date_report}_${current_user}_2cell_sleep.csv"
  N2report_file_temp1="${date_report}_${current_user}_${cartella2}_2fddcomplete.tmp"
  N2report_file="${date_report}_${current_user}_${cartella2}_2fddcomplete.csv"
  grep -H . $fullpath/log/$cartella2/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |egrep "ABLED|LOCKED" |grep EUtranCell.DD      |grep -v ";"                    |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g'                                         > $fullpath/temp/$N2report_file1
  chmod 777 $fullpath/temp/$N2report_file1
  grep -H . $fullpath/log/$cartella2/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'                       |grep CellSleepFunction= |grep -v ";" |grep -v sleepMode |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g'  |sed 's/,CellSleepFunction=1;/;/g'     > $fullpath/temp/$N2report_file2
  chmod 777 $fullpath/temp/$N2report_file2
  awk -F ";" '{ key[$2]=key[$2] ";"$1";"$3";"$4} END { for (i in key) print i key[i]}' $fullpath/temp/$N2report_file1 $fullpath/temp/$N2report_file2            |sort                                                                                                                                                         > $fullpath/temp/$N2report_file_temp1
  cat $fullpath/temp/$N2report_file_temp1 |awk -v OFS=";" -F";" '{sub(/\r$/, ""); print $1,"na;na;na;na;na",$2,$3,$4,$6,$7}' |sed 's/EUtranCell.DD=//g'         |sort -t ';' -k1,1                                                                                                                                            > $fullpath/temp/$N2report_file

  echo "EUTRANCELL;NODE;ADMINISTR;OPERATIONAL;SLEEPMODE;SLEEPSTATE;NODE;ADMINISTR;OPERATIONAL;SLEEPMODE;SLEEPSTATE"                                                                                                                                                                                                           > $fullpath/temp/$report_unfiltered_file
  join -t";" -a1 -a2 -e "na" -o 0,1.2,1.3,1.4,1.5,1.6,2.7,2.8,2.9,2.10,2.11 $fullpath/temp/$N1report_file $fullpath/temp/$N2report_file                                                                                                                                                                                      >> $fullpath/temp/$report_unfiltered_file

  rm $fullpath/temp/$N1report_file1
  rm $fullpath/temp/$N1report_file2
  rm $fullpath/temp/$N1report_file_temp1
  rm $fullpath/temp/$N1report_file
  
  rm $fullpath/temp/$N2report_file1
  rm $fullpath/temp/$N2report_file2
  rm $fullpath/temp/$N2report_file_temp1
  rm $fullpath/temp/$N2report_file
}




function menu_11m() {
  if [ $# -ne 2 ]; then
    choose_folders
  else
    cartella1=$1
	cartella2=$2
  fi
  report_unfiltered_file="${date_report}_${current_user}_${cartella1}_${cartella2}_dcells_unfiltered.csv"
  report_file="${date_report}_${current_user}_${cartella1}_${cartella2}_dcells.csv"
  _menu_11m
  cat $fullpath/temp/$report_unfiltered_file                                                                                                                                              >  $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file                            |sed 's/;/\t/g' |expand -t14   |sed "1a\\$separator2" |sed "1i\\$separator2" |sed "\$a\\$separator2"
  echo -e "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) MOs"
  rm $fullpath/temp/$report_unfiltered_file
}

function menu_11md() {
  if [ $# -ne 2 ]; then
    choose_folders
  else
    cartella1=$1
	cartella2=$2
  fi
  report_unfiltered_file="${date_report}_${current_user}_${cartella1}_${cartella2}_dcells_delta_unfiltered.csv"
  report_file="${date_report}_${current_user}_${cartella1}_${cartella2}_dcells_delta.csv"
  _menu_11m
  cat $fullpath/temp/$report_unfiltered_file                 |awk -F";" '{if (NR==1 || $3!=$8 || ($4!=$9 && $9=="DISABLED" )) print $all}'                                                          >  $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file                            |sed 's/;/\t/g' |expand -t14   |sed "1a\\$separator2" |sed "1i\\$separator2" |sed "\$a\\$separator2"
  echo -e "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) MOs"
}
rm $fullpath/temp/$report_unfiltered_file


function menu_11d() {
  if [ $# -ne 2 ]; then
    choose_folders
  else
    cartella1=$1
	cartella2=$2
  fi
  report_unfiltered_file="${date_report}_${current_user}_${cartella1}_${cartella2}_dcells_delta_filtered.csv"
  report_file="${date_report}_${current_user}_${cartella1}_${cartella2}_dcells_delta_filt.csv"
  _menu_11m
  cat $fullpath/temp/$report_unfiltered_file                 |awk -F";" '{if (NR==1 || $3!=$8 || ($4!=$9 && $9=="DISABLED" && $11=="DEACTIVATED")) print $all}'                                                          >  $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file                            |sed 's/;/\t/g' |expand -t14   |sed "1a\\$separator2" |sed "1i\\$separator2" |sed "\$a\\$separator2"
  echo -e "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) MOs"
  rm $fullpath/temp/$report_unfiltered_file
}

function menu_16() {
  if [ $# -eq 0 ]; then
  choose_folder
  else
  cartella1=$1
  fi
  report_file1="${date_report}_${current_user}_nrcelldu.csv"
  report_file2="${date_report}_${current_user}_nrcellcu.csv"
  report_file_temp1="${date_report}_${current_user}_cu_du.tmp"
  report_file="${date_report}_${current_user}_cu_du.csv"
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |egrep "ABLED|LOCKED" |grep NRCellDU= |sed 's/NRCell.U=//g' |grep -v ";"                    |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g'       > $fullpath/temp/$report_file1
  chmod 777 $fullpath/temp/$report_file1
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'                       |grep NRCellCU= |sed 's/NRCell.U=//g' |grep -v ";" |grep -v cellState |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g'       > $fullpath/temp/$report_file2
  chmod 777 $fullpath/temp/$report_file2
  echo "NRCELL;NODE;DU_ADMINISTR;DU_OPERATIONAL;NODE;CU_CELLSTATE;CU_SERVICESTATE"                                                                                                                                                                                                 > $fullpath/temp/$report_file_temp1
  awk -F ";" '{ key[$2]=key[$2] ";"$1";"$3";"$4} END { for (i in key) print i key[i]}' $fullpath/temp/$report_file1  $fullpath/temp/$report_file2                                    |sort                                                                                        >> $fullpath/temp/$report_file_temp1
  cat $fullpath/temp/$report_file_temp1 |awk -F";" '{print $2";"$1";"$3";"$4";"$6";"$7}'                                                                                                                                                                                           > $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |sed 's/;/\t/g' |expand -t15   |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo -e "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) MOs"
  echo -e "     - $(cat $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |egrep "ABLED|LOCKED" |grep NRCellDU=  |grep -v ";"                       |grep -c .) NRCellDU"
  echo -e "     - $(cat $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'                       |grep NRCellCU=  |grep -v ";" |grep -v cellState    |grep -c .) NRCellCU"
  rm $fullpath/temp/$report_file_temp1
}

function menu_17() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file1="${date_report}_${current_user}_nrcelldu.csv"
  report_file2="${date_report}_${current_user}_nrcellcu.csv"
  report_file_temp1="${date_report}_${current_user}_cu_du.tmp"
  report_file="${date_report}_${current_user}_cu_du_on.csv"
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |egrep "ABLED|LOCKED" |grep NRCellDU= |sed 's/NRCell.U=//g' |grep -v ";"                    |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g'       > $fullpath/temp/$report_file1
  chmod 777 $fullpath/temp/$report_file1
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'                       |grep NRCellCU= |sed 's/NRCell.U=//g' |grep -v ";" |grep -v cellState |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g'       > $fullpath/temp/$report_file2
  chmod 777 $fullpath/temp/$report_file2
  echo "NRCELL;NODE;DU_ADMINISTRATIVE;DU_OPERATIONAL;NODE;CU_CELLSTATE;CU_SERVICESTATE"                                                                                                                                                                                            > $fullpath/temp/$report_file_temp1
  awk -F ";" '{ key[$2]=key[$2] ";"$1";"$3";"$4} END { for (i in key) print i key[i]}' $fullpath/temp/$report_file1  $fullpath/temp/$report_file2                                    |sort                                                                                        >> $fullpath/temp/$report_file_temp1
  cat $fullpath/temp/$report_file_temp1 |awk -F";" '{print $2";"$1";"$3";"$4";"$6";"$7}'  |awk -F";" '{if (($4=="ENABLED" && $6=="IN_SERVICE") || ($4=="DU_OPERATIONAL" && $6=="CU_SERVICESTATE")) print $1";"$2";"$3";"$4";"$5";"$6";"}'                                          > $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ';' -t   |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo -e "Total: $(cat $fullpath/temp/$report_file |awk -F";" '{if ($4=="ENABLED" && $6=="IN_SERVICE" ) print $1";"$2";"$3";"$4";"$5";"$6";"}'  |grep -v NODE |grep -c .) MOs"
  echo -e "     - $(cat $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |egrep "ABLED|LOCKED" |grep NRCellDU=  |grep -v ";"                       |grep -c .) NRCellDU"
  echo -e "     - $(cat $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'                       |grep NRCellCU=  |grep -v ";" |grep -v cellState    |grep -c .) NRCellCU"
  rm $fullpath/temp/$report_file_temp1
}

function menu_18() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file1="${date_report}_${current_user}_nrcelldu.csv"
  report_file2="${date_report}_${current_user}_nrcellcu.csv"
  report_file_temp1="${date_report}_${current_user}_cu_du.tmp"
  report_file="${date_report}_${current_user}_cu_du_off.csv"
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |egrep "ABLED|LOCKED" |grep NRCellDU= |sed 's/NRCell.U=//g' |grep -v ";"                    |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g'       > $fullpath/temp/$report_file1
  chmod 777 $fullpath/temp/$report_file1
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'                       |grep NRCellCU= |sed 's/NRCell.U=//g' |grep -v ";" |grep -v cellState |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g'       > $fullpath/temp/$report_file2
  chmod 777 $fullpath/temp/$report_file2
  echo "NRCELL;NODE;DU_ADMINISTRATIVE;DU_OPERATIONAL;NODE;CU_CELLSTATE;CU_SERVICESTATE"                                                                                                                                                                                            > $fullpath/temp/$report_file_temp1
  awk -F ";" '{ key[$2]=key[$2] ";"$1";"$3";"$4} END { for (i in key) print i key[i]}' $fullpath/temp/$report_file1  $fullpath/temp/$report_file2                                    |sort                                                                                        >> $fullpath/temp/$report_file_temp1
  cat $fullpath/temp/$report_file_temp1 |awk -F";" '{print $2";"$1";"$3";"$4";"$6";"$7}'  |awk -F";" '{if (($4=="DISABLED" || $6!="IN_SERVICE") || ($4=="DU_OPERATIONAL" && $6=="CU_SERVICESTATE")) print $1";"$2";"$3";"$4";"$5";"$6";"}'                                         > $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file       |column -s ';' -t   |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo -e "Total: $(cat $fullpath/temp/$report_file |awk -F";" '{if ($4=="DISABLED" || $6!="IN_SERVICE" ) print $1";"$2";"$3";"$4";"$5";"$6";"}'  |grep -v NODE |grep -c .) MOs"
  echo -e "     - $(cat $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |egrep "ABLED|LOCKED" |grep NRCellDU=  |grep -v ";"                       |grep -c .) NRCellDU"
  echo -e "     - $(cat $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'                       |grep NRCellCU=  |grep -v ";" |grep -v cellState    |grep -c .) NRCellCU"
  rm $fullpath/temp/$report_file_temp1
}


function _menu_16m {
  N1report_file1="${date_report}_${current_user}_1nrcelldu.csv"
  N1report_file2="${date_report}_${current_user}_1nrcellcu.csv"
  N1report_file_temp1="${date_report}_${current_user}_1cu_du.tmp"
  N1report_file="${date_report}_${current_user}_1cu_du.csv"
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |egrep "ABLED|LOCKED" |grep NRCellDU= |sed 's/NRCell.U=//g' |grep -v ";" |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g'  |awk -v OFS=";" -F";" '{if($3=="") $3="na"; if($4=="") $4="na"; print}'         > $fullpath/temp/$N1report_file1
  chmod 777                                                                                                                                                                                                                                                                                                                                                     $fullpath/temp/$N1report_file1
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'                       |grep NRCellCU= |sed 's/NRCell.U=//g' |grep -v ";" |grep -v cellState |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g'        |awk -v OFS=";" -F";" '{if($3=="") $3="na"; if($4=="") $4="na"; print}'         > $fullpath/temp/$N1report_file2
  chmod 777                                                                                                                                                                                                                                                                                                                                                     $fullpath/temp/$N1report_file2
  awk -F ";" '{ key[$2]=key[$2] ";"$1";"$3";"$4} END { for (i in key) print i key[i]}' $fullpath/temp/$N1report_file1  $fullpath/temp/$N1report_file2      |awk -v OFS=";" -F";" '{if($5=="") $5="na"; if($6=="") $6="na"; if($7=="") $7="na"; print}'   |sort                                                                      > $fullpath/temp/$N1report_file_temp1
  cat $fullpath/temp/$N1report_file_temp1 |awk -v OFS=";" -F";" '{sub(/\r$/, ""); print $1,$2,$3,$4,$6,$7,"na;na;na;na;na"}'  |sort -t ";" -k1,1                                                                                                                                                                                                                              > $fullpath/temp/$N1report_file

  N2report_file1="${date_report}_${current_user}_2nrcelldu.csv"
  N2report_file2="${date_report}_${current_user}_2nrcellcu.csv"
  N2report_file_temp1="${date_report}_${current_user}_2cu_du.tmp"
  N2report_file="${date_report}_${current_user}_2cu_du.csv"
  grep -H . $fullpath/log/$cartella2/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |egrep "ABLED|LOCKED" |grep NRCellDU= |sed 's/NRCell.U=//g' |grep -v ";" |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g'   |awk -v OFS=";" -F";" '{if($3=="") $3="na"; if($4=="") $4="na"; print}'        > $fullpath/temp/$N2report_file1
  chmod 777                                                                                                                                                                                                                                                                                                                                                     $fullpath/temp/$N2report_file1
  grep -H . $fullpath/log/$cartella2/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'                       |grep NRCellCU= |sed 's/NRCell.U=//g' |grep -v ";" |grep -v cellState |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g'          |awk -v OFS=";" -F";" '{if($3=="") $3="na"; if($4=="") $4="na"; print}'       > $fullpath/temp/$N2report_file2
  chmod 777                                                                                                                                                                                                                                                                                                                                                     $fullpath/temp/$N2report_file2
  awk -F ";" '{ key[$2]=key[$2] ";"$1";"$3";"$4} END { for (i in key) print i key[i]}' $fullpath/temp/$N2report_file1  $fullpath/temp/$N2report_file2      |awk -v OFS=";" -F";" '{if($5=="") $5="na"; if($6=="") $6="na"; if($7=="") $7="na"; print}'   |sort                                                                      > $fullpath/temp/$N2report_file_temp1
  cat $fullpath/temp/$N2report_file_temp1 |awk -v OFS=";" -F";" '{sub(/\r$/, ""); print $1,"na;na;na;na;na",$2,$3,$4,$6,$7}'  |sort -t ";" -k1,1                                                                                                                                                                                                                              > $fullpath/temp/$N2report_file
  
  echo "NRCELL;NODE;DU_ADM;DU_OP;CU_CELLST;CU_SERVST;NODE;DU_ADM;DU_OP;CU_CELLST;CU_SERVST"                                                                                                                                                                                                                                                                   > $fullpath/temp/$report_unfiltered_file
  join -t";" -a1 -a2 -e "na" -o 0,1.2,1.3,1.4,1.5,1.6,2.7,2.8,2.9,2.10,2.11 $fullpath/temp/$N1report_file $fullpath/temp/$N2report_file                                                                                                                                                                                                                      >> $fullpath/temp/$report_unfiltered_file
  rm $fullpath/temp/$N1report_file_temp1
}

function menu_16m() {
  if [ $# -ne 2 ]; then
    choose_folders
  else
    cartella1=$1
	cartella2=$2
  fi
  report_unfiltered_file="${date_report}_${current_user}_${cartella1}_${cartella2}_dnrcells_unfiltered.csv"
  report_file="${date_report}_${current_user}_${cartella1}_${cartella2}_dnrcells.csv"
  _menu_16m
  cat $fullpath/temp/$report_unfiltered_file                                                                                                                       >  $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ';' -t   |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo -e "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) MOs"
}

function menu_16d() {
  if [ $# -ne 2 ]; then
    choose_folders
  else
    cartella1=$1
	cartella2=$2
  fi
  report_unfiltered_file="${date_report}_${current_user}_${cartella1}_${cartella2}_dnrcells_delta_unfiltered.csv"
  report_file="${date_report}_${current_user}_${cartella1}_${cartella2}_dnrcells_delta.csv"
  _menu_16m
  cat $fullpath/temp/$report_unfiltered_file           |awk -F";" '{if (NR==1 || $3!=$8 || $4!=$9 || $5!=$10 || $6!=$11) print $all}'                               >  $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ';' -t   |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo -e "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) MOs"
}
#####################

function menu_21() {
  if [ $# -eq 0 ]; then
    choose_folder
    echo -e "\n"
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_cells.csv"
  echo "NODE;CELL;ADMINISTRATIVE;OPERATIONAL"  > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |egrep "ABLED\)|LOCKED\)" |egrep "Trx=|NodeBLocalCell=|EUtranCellFDD=|EUtranCellTDD=|NbIotCell=|NRCellDU=" |sed 's/NodeBLocalCellGroup=1,//g' |grep -v ";" |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |sort       >> $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) MOs"
}

function menu_24() {
  if [ $# -eq 0 ]; then
    choose_folder
    echo -e "\n"
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_cells_trx.csv"
  echo "NODE;CELL;ADMINISTRATIVE;OPERATIONAL;"  > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |egrep "ABLED\)|LOCKED\)" |egrep "Trx=|NodeBLocalCell=|EUtranCellFDD=|EUtranCellTDD=|NbIotCell=|NRCellDU=" |grep GsmSector= |grep Trx= |grep -v ";" |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |sort       >> $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) MOs"
}

function menu_26() {
  if [ $# -eq 0 ]; then
    choose_folder
    echo -e "\n"
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_cells_nbiot.csv"
  echo "NODE;CELL;ADMINISTRATIVE;OPERATIONAL;"  > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |egrep "ABLED\)|LOCKED\)" |egrep "Trx=|NodeBLocalCell=|EUtranCellFDD=|EUtranCellTDD=|NbIotCell=|NRCellDU=" |grep NbIotCell= |grep -v ";" |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |sort       >> $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) MOs"
}

function menu_29() {
  if [ $# -eq 0 ]; then
    choose_folder
    echo -e "\n"
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_cells_nodeblocalcell.csv"
  echo "NODE;CELL;ADMINISTRATIVE;OPERATIONAL;"  > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |egrep "ABLED\)|LOCKED\)" |egrep "Trx=|NodeBLocalCell=|EUtranCellFDD=|EUtranCellTDD=|NbIotCell=|NRCellDU=" |grep NodeBLocalCell= |sed 's/NodeBLocalCellGroup=1,//g' |grep -v ";" |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |sort       >> $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) MOs"
}

function menu_21m() {
  if [ $# -ne 2 ]; then
    choose_folders
  else
    cartella1=$1
	cartella2=$2
  fi
  report_file1="${date_report}_${current_user}_${cartella1}_cell.csv"
  report_file2="${date_report}_${current_user}_${cartella2}_cell.csv"
  report_file="${date_report}_${current_user}_${cartella1}_${cartella2}_cell_merge.csv"
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'  |egrep "ABLED\)|LOCKED\)" |egrep "NodeBLocalCell=|NbIotCell=|Trx=|EUtranCellFDD=|EUtranCellTDD|NRCellDU=" |sed 's/NodeBLocalCellGroup=1,//g' |grep -v ";" |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |awk -v OFS=";" -F";" '{print $2,$1,$3,$4}' |sort           > $fullpath/temp/$report_file1
  grep -H . $fullpath/log/$cartella2/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'  |egrep "ABLED\)|LOCKED\)" |egrep "NodeBLocalCell=|NbIotCell=|Trx=|EUtranCellFDD=|EUtranCellTDD|NRCellDU=" |sed 's/NodeBLocalCellGroup=1,//g' |grep -v ";" |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |awk -v OFS=";" -F";" '{print $2,$1,$3,$4}' |sort           > $fullpath/temp/$report_file2
  chmod 777 $fullpath/temp/$report_file1
  chmod 777 $fullpath/temp/$report_file2
  echo "CELL;NODE;ADMINISTRATIVE;OPERATIONAL;NODE;ADMINISTRATIVE;OPERATIONAL"                                                                                                                           > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  join -t";" -a1 -a2 -e "" -o 0,1.2,1.3,1.4,2.2,2.3,2.4 $fullpath/temp/$report_file1 $fullpath/temp/$report_file2                                                                                      >> $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) MOs"
}

function menu_21d() {
  if [ $# -ne 2 ]; then
    choose_folders
  else
    cartella1=$1
	cartella2=$2
  fi
  report_file1="${date_report}_${current_user}_${cartella1}_cell.csv"
  report_file2="${date_report}_${current_user}_${cartella2}_cell.csv"
  report_file="${date_report}_${current_user}_${cartella1}_${cartella2}_cell_delta.csv"
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'  |egrep "ABLED\)|LOCKED\)" |egrep "NodeBLocalCell=|NbIotCell=|Trx=|EUtranCellFDD=|EUtranCellTDD|NRCellDU=" |sed 's/NodeBLocalCellGroup=1,//g' |grep -v ";" |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |awk -v OFS=";" -F";" '{print $2,$1,$3,$4}' |sort           > $fullpath/temp/$report_file1
  grep -H . $fullpath/log/$cartella2/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'  |egrep "ABLED\)|LOCKED\)" |egrep "NodeBLocalCell=|NbIotCell=|Trx=|EUtranCellFDD=|EUtranCellTDD|NRCellDU=" |sed 's/NodeBLocalCellGroup=1,//g' |grep -v ";" |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |awk -v OFS=";" -F";" '{print $2,$1,$3,$4}' |sort           > $fullpath/temp/$report_file2
  chmod 777 $fullpath/temp/$report_file1
  chmod 777 $fullpath/temp/$report_file2
  echo "CELL;NODE;ADMINISTRATIVE;OPERATIONAL;NODE;ADMINISTRATIVE;OPERATIONAL"                                                                                                                           > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  join -t";" -a1 -a2 -e "" -o 0,1.2,1.3,1.4,2.2,2.3,2.4 $fullpath/temp/$report_file1 $fullpath/temp/$report_file2            |awk -v OFS=";" -F";" '{if ($4!=$7) print $all}'                                                                              >> $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) MOs"
}

function menu_24m() {
  if [ $# -ne 2 ]; then
    choose_folders
  else
    cartella1=$1
	cartella2=$2
  fi
  report_file1="${date_report}_${current_user}_${cartella1}_trx.csv"
  report_file2="${date_report}_${current_user}_${cartella2}_trx.csv"
  report_file="${date_report}_${current_user}_${cartella1}_${cartella2}_trx_merge.csv"
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'  |egrep "ABLED\)|LOCKED\)" |egrep "NodeBLocalCell=|NbIotCell=|Trx=|EUtranCellFDD=|EUtranCellTDD|NRCellDU=" |sed 's/NodeBLocalCellGroup=1,//g' |grep GsmSector= |grep Trx= |grep -v ";" |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |awk -v OFS=";" -F";" '{print $2,$1,$3,$4}' |sort           > $fullpath/temp/$report_file1
  grep -H . $fullpath/log/$cartella2/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'  |egrep "ABLED\)|LOCKED\)" |egrep "NodeBLocalCell=|NbIotCell=|Trx=|EUtranCellFDD=|EUtranCellTDD|NRCellDU=" |sed 's/NodeBLocalCellGroup=1,//g' |grep GsmSector= |grep Trx= |grep -v ";" |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |awk -v OFS=";" -F";" '{print $2,$1,$3,$4}' |sort           > $fullpath/temp/$report_file2
  chmod 777 $fullpath/temp/$report_file1
  chmod 777 $fullpath/temp/$report_file2
  echo "CELL;NODE;ADMINISTRATIVE;OPERATIONAL;NODE;ADMINISTRATIVE;OPERATIONAL"                                                                                                                           > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  join -t";" -a1 -a2 -e "" -o 0,1.2,1.3,1.4,2.2,2.3,2.4 $fullpath/temp/$report_file1 $fullpath/temp/$report_file2                                                                                      >> $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) MOs"
}

function menu_24d() {
  if [ $# -ne 2 ]; then
    choose_folders
  else
    cartella1=$1
	cartella2=$2
  fi
  report_file1="${date_report}_${current_user}_${cartella1}_trx.csv"
  report_file2="${date_report}_${current_user}_${cartella2}_trx.csv"
  report_file="${date_report}_${current_user}_${cartella1}_${cartella2}_trx_delta.csv"
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'  |egrep "ABLED\)|LOCKED\)" |egrep "NodeBLocalCell=|NbIotCell=|Trx=|EUtranCellFDD=|EUtranCellTDD|NRCellDU=" |sed 's/NodeBLocalCellGroup=1,//g' |grep GsmSector= |grep Trx= |grep -v ";" |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |awk -v OFS=";" -F";" '{print $2,$1,$3,$4}' |sort           > $fullpath/temp/$report_file1
  grep -H . $fullpath/log/$cartella2/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'  |egrep "ABLED\)|LOCKED\)" |egrep "NodeBLocalCell=|NbIotCell=|Trx=|EUtranCellFDD=|EUtranCellTDD|NRCellDU=" |sed 's/NodeBLocalCellGroup=1,//g' |grep GsmSector= |grep Trx= |grep -v ";" |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |awk -v OFS=";" -F";" '{print $2,$1,$3,$4}' |sort           > $fullpath/temp/$report_file2
  chmod 777 $fullpath/temp/$report_file1
  chmod 777 $fullpath/temp/$report_file2
  echo "CELL;NODE;ADMINISTRATIVE;OPERATIONAL;NODE;ADMINISTRATIVE;OPERATIONAL"                                                                                                                           > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  join -t";" -a1 -a2 -e "" -o 0,1.2,1.3,1.4,2.2,2.3,2.4 $fullpath/temp/$report_file1 $fullpath/temp/$report_file2          |awk -v OFS=";" -F";" '{if ($4!=$7) print $all}'                   >> $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) MOs"
}

function menu_26m() {
  if [ $# -ne 2 ]; then
    choose_folders
  else
    cartella1=$1
	cartella2=$2
  fi
  report_file1="${date_report}_${current_user}_${cartella1}_nbiot.csv"
  report_file2="${date_report}_${current_user}_${cartella2}_nbiot.csv"
  report_file="${date_report}_${current_user}_${cartella1}_${cartella2}_nbiot_merge.csv"
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'  |egrep "ABLED\)|LOCKED\)" |egrep "NodeBLocalCell=|NbIotCell=|Trx=|EUtranCellFDD=|EUtranCellTDD|NRCellDU=" |sed 's/NodeBLocalCellGroup=1,//g' |grep NbIotCell= |grep -v ";" |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |awk -v OFS=";" -F";" '{print $2,$1,$3,$4}' |sort           > $fullpath/temp/$report_file1
  grep -H . $fullpath/log/$cartella2/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'  |egrep "ABLED\)|LOCKED\)" |egrep "NodeBLocalCell=|NbIotCell=|Trx=|EUtranCellFDD=|EUtranCellTDD|NRCellDU=" |sed 's/NodeBLocalCellGroup=1,//g' |grep NbIotCell= |grep -v ";" |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |awk -v OFS=";" -F";" '{print $2,$1,$3,$4}' |sort           > $fullpath/temp/$report_file2
  chmod 777 $fullpath/temp/$report_file1
  chmod 777 $fullpath/temp/$report_file2
  echo "CELL;NODE;ADMINISTRATIVE;OPERATIONAL;NODE;ADMINISTRATIVE;OPERATIONAL"                                                                                                                           > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  join -t";" -a1 -a2 -e "" -o 0,1.2,1.3,1.4,2.2,2.3,2.4 $fullpath/temp/$report_file1 $fullpath/temp/$report_file2                                                                                      >> $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) MOs"
}


function menu_26d() {
  if [ $# -ne 2 ]; then
    choose_folders
  else
    cartella1=$1
	cartella2=$2
  fi
  report_file1="${date_report}_${current_user}_${cartella1}_nbiot.csv"
  report_file2="${date_report}_${current_user}_${cartella2}_nbiot.csv"
  report_file="${date_report}_${current_user}_${cartella1}_${cartella2}_nbiot_delta.csv"
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'  |egrep "ABLED\)|LOCKED\)" |egrep "NodeBLocalCell=|NbIotCell=|Trx=|EUtranCellFDD=|EUtranCellTDD|NRCellDU=" |sed 's/NodeBLocalCellGroup=1,//g' |grep NbIotCell= |grep -v ";" |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |awk -v OFS=";" -F";" '{print $2,$1,$3,$4}' |sort           > $fullpath/temp/$report_file1
  grep -H . $fullpath/log/$cartella2/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'  |egrep "ABLED\)|LOCKED\)" |egrep "NodeBLocalCell=|NbIotCell=|Trx=|EUtranCellFDD=|EUtranCellTDD|NRCellDU=" |sed 's/NodeBLocalCellGroup=1,//g' |grep NbIotCell= |grep -v ";" |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |awk -v OFS=";" -F";" '{print $2,$1,$3,$4}' |sort           > $fullpath/temp/$report_file2
  chmod 777 $fullpath/temp/$report_file1
  chmod 777 $fullpath/temp/$report_file2
  echo "CELL;NODE;ADMINISTRATIVE;OPERATIONAL;NODE;ADMINISTRATIVE;OPERATIONAL"                                                                                                                           > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  join -t";" -a1 -a2 -e "" -o 0,1.2,1.3,1.4,2.2,2.3,2.4 $fullpath/temp/$report_file1 $fullpath/temp/$report_file2                 |awk -v OFS=";" -F";" '{if ($4!=$7) print $all}'                            >> $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) MOs"
}


function menu_29m() {
  if [ $# -ne 2 ]; then
    choose_folders
  else
    cartella1=$1
	cartella2=$2
  fi
  report_file1="${date_report}_${current_user}_${cartella1}_nodeblocalcell.csv"
  report_file2="${date_report}_${current_user}_${cartella2}_nodeblocalcell.csv"
  report_file="${date_report}_${current_user}_${cartella1}_${cartella2}_nodeblocalcell_merge.csv"
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'  |egrep "ABLED\)|LOCKED\)" |egrep "NodeBLocalCell=|NbIotCell=|Trx=|EUtranCellFDD=|EUtranCellTDD|NRCellDU=" |sed 's/NodeBLocalCellGroup=1,//g' |grep NodeBLocalCell= |grep -v ";" |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |awk -v OFS=";" -F";" '{print $2,$1,$3,$4}' |sort           > $fullpath/temp/$report_file1
  grep -H . $fullpath/log/$cartella2/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'  |egrep "ABLED\)|LOCKED\)" |egrep "NodeBLocalCell=|NbIotCell=|Trx=|EUtranCellFDD=|EUtranCellTDD|NRCellDU=" |sed 's/NodeBLocalCellGroup=1,//g' |grep NodeBLocalCell= |grep -v ";" |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |awk -v OFS=";" -F";" '{print $2,$1,$3,$4}' |sort           > $fullpath/temp/$report_file2
  chmod 777 $fullpath/temp/$report_file1
  chmod 777 $fullpath/temp/$report_file2
  echo "CELL;NODE;ADMINISTRATIVE;OPERATIONAL;NODE;ADMINISTRATIVE;OPERATIONAL"                                                                                                                           > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  join -t";" -a1 -a2 -e "" -o 0,1.2,1.3,1.4,2.2,2.3,2.4 $fullpath/temp/$report_file1 $fullpath/temp/$report_file2                                                                                      >> $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) MOs"
}

function menu_29d() {
  if [ $# -ne 2 ]; then
    choose_folders
  else
    cartella1=$1
	cartella2=$2
  fi
  report_file1="${date_report}_${current_user}_${cartella1}_nodeblocalcell.csv"
  report_file2="${date_report}_${current_user}_${cartella2}_nodeblocalcell.csv"
  report_file="${date_report}_${current_user}_${cartella1}_${cartella2}_nodeblocalcell_delta.csv"
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'  |egrep "ABLED\)|LOCKED\)" |egrep "NodeBLocalCell=|NbIotCell=|Trx=|EUtranCellFDD=|EUtranCellTDD|NRCellDU=" |sed 's/NodeBLocalCellGroup=1,//g' |grep NodeBLocalCell= |grep -v ";" |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |awk -v OFS=";" -F";" '{print $2,$1,$3,$4}' |sort           > $fullpath/temp/$report_file1
  grep -H . $fullpath/log/$cartella2/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'  |egrep "ABLED\)|LOCKED\)" |egrep "NodeBLocalCell=|NbIotCell=|Trx=|EUtranCellFDD=|EUtranCellTDD|NRCellDU=" |sed 's/NodeBLocalCellGroup=1,//g' |grep NodeBLocalCell= |grep -v ";" |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |awk -v OFS=";" -F";" '{print $2,$1,$3,$4}' |sort           > $fullpath/temp/$report_file2
  chmod 777 $fullpath/temp/$report_file1
  chmod 777 $fullpath/temp/$report_file2
  echo "CELL;NODE;ADMINISTRATIVE;OPERATIONAL;NODE;ADMINISTRATIVE;OPERATIONAL"                                                                                                                           > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  join -t";" -a1 -a2 -e "" -o 0,1.2,1.3,1.4,2.2,2.3,2.4 $fullpath/temp/$report_file1 $fullpath/temp/$report_file2               |awk -v OFS=";" -F";" '{if ($4!=$7) print $all}'                             >> $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) MOs"
}

function menu_27() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_nrcellcu.csv"
  echo "NODE;CELL;CELLSTATE;SERVICESTATE;"  > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'  |grep NRCellCU= |grep -v ";" |grep -v cellState  |sort   |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' >> $fullpath/temp/$report_file
  
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) MOs"
}

function menu_28() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_cell_sleep.csv"
  echo "NODE;CELL;SLEEPMODE;SLEEPSTATE;"  > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'  |grep CellSleepFunction= |grep -v ";" |grep -v sleepMode  |sort  |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' >> $fullpath/temp/$report_file
  
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) MOs"
}

function menu_31() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_alarms_complete.csv"
  echo "NODE;DATE;TIME;SEVERITY;OBJECT;PROBLEM;CAUSE;ADDITIONALSTATE;ACKSTATE;ALARMID;NOTIFICATIONID"  > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |sed -n '/Date;Time;Severity/,/Total: /p' |grep -v "Date;Time;Severity" |grep -v "Total: " |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' >> $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file  |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) Alarms"
}

function menu_33() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_alarms_C_M_m.csv"
  echo "NODE;DATE;TIME;SEVERITY;OBJECT;PROBLEM;CAUSE;ADDITIONALSTATE;ACKSTATE;ALARMID;NOTIFICATIONID"                                                                                                                                                                                                                                                                 > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |sed -n '/Date;Time;Severity/,/Total: /p' |grep -v "Date;Time;Severity" |grep -v "Total: " |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |awk -F";" '{if ($4~"Critical" || $4~"Major" || $4~"Minor") print $all}'             >> $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file  |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) Alarms"
}

function menu_31d() {
  if [ $# -ne 2 ]; then
    choose_folders
  else
    cartella1=$1
	cartella2=$2
  fi
  report_file1="${date_report}_${current_user}_${cartella1}_alarms.csv"
  report_file2="${date_report}_${current_user}_${cartella2}_alarms.csv"
  report_file="${date_report}_${current_user}_${cartella1}_${cartella2}_alarms_merge_all.csv"
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |sed -n '/Date;Time;Severity/,/Total: /p' |grep -v "Date;Time;Severity" |grep -v "Total: " |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |awk -F";" '{OFS=";";$2="";$3="";$NF="";$(NF-1)="";$(NF-2)="";$(NF-3)="";print $0}' > $fullpath/temp/$report_file1
  grep -H . $fullpath/log/$cartella2/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |sed -n '/Date;Time;Severity/,/Total: /p' |grep -v "Date;Time;Severity" |grep -v "Total: " |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |awk -F";" '{OFS=";";$2="";$3="";$NF="";$(NF-1)="";$(NF-2)="";$(NF-3)="";print $0}' > $fullpath/temp/$report_file2
  echo "NODE;DATE;TIME;SEVERITY;OBJECT;PROBLEM;CAUSE;ADDITIONALSTATE;ACKSTATE;ALARMID;NOTIFICATIONID"                                                                                                                                                                                                                                                                > $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file2 |grep -v -F -f $fullpath/temp/$report_file1                                                                                                                                                                                                                                                                                        >> $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) Alarms"
}

function menu_33d() {
  if [ $# -ne 2 ]; then
    choose_folders
  else
    cartella1=$1
	cartella2=$2
  fi
  report_file1="${date_report}_${current_user}_${cartella1}_alarms.csv"
  report_file2="${date_report}_${current_user}_${cartella2}_alarms.csv"
  report_file="${date_report}_${current_user}_${cartella1}_${cartella2}_alarms_merge_C_M_m_reduced.csv"
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |sed -n '/Date;Time;Severity/,/Total: /p' |grep -v "Date;Time;Severity" |grep -v "Total: " |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |awk -F";" '{OFS=";";$2="";$3="";$NF="";$(NF-1)="";$(NF-2)="";$(NF-3)="";print $0}' |sed 's/ExternalENodeBFunction=[^;]*;/ExternalENodeBFunction=;/g' > $fullpath/temp/$report_file1
  grep -H . $fullpath/log/$cartella2/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |sed -n '/Date;Time;Severity/,/Total: /p' |grep -v "Date;Time;Severity" |grep -v "Total: " |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |awk -F";" '{OFS=";";$2="";$3="";$NF="";$(NF-1)="";$(NF-2)="";$(NF-3)="";print $0}' |sed 's/ExternalENodeBFunction=[^;]*;/ExternalENodeBFunction=;/g' > $fullpath/temp/$report_file2
  echo "NODE;DATE;TIME;SEVERITY;OBJECT;PROBLEM;CAUSE;ADDITIONALSTATE;ACKSTATE;ALARMID;NOTIFICATIONID"                                                                                                                                                                                                                                                                           > $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file2 |grep -v -F -f $fullpath/temp/$report_file1 |egrep ";Critical;|;Major;|;Minor;"                                                                                                                                                                                                                                                              >> $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) Alarms"
}

function menu_35() {
  if [ $# -ne 2 ]; then
    choose_folders
  else
    cartella1=$1
	cartella2=$2
  fi
  report_file1="${date_report}_${current_user}_${cartella1}_alarms.csv"
  report_file2="${date_report}_${current_user}_${cartella2}_alarms.csv"
  report_file="${date_report}_${current_user}_${cartella1}_${cartella2}_alarms_merge_C_M_m.csv"
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |sed -n '/Date;Time;Severity/,/Total: /p' |grep -v "Date;Time;Severity" |grep -v "Total: " |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |awk -F";" '{OFS=";";$2="";$3="";$NF="";$(NF-1)="";$(NF-2)="";print $0}'              > $fullpath/temp/$report_file1
  grep -H . $fullpath/log/$cartella2/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |sed -n '/Date;Time;Severity/,/Total: /p' |grep -v "Date;Time;Severity" |grep -v "Total: " |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |awk -F";" '{OFS=";";$2="";$3="";$NF="";$(NF-1)="";$(NF-2)="";print $0}'              > $fullpath/temp/$report_file2
  echo "NODE;DATE;TIME;SEVERITY;OBJECT;PROBLEM;CAUSE;ADDITIONALSTATE;ACKSTATE;ALARMID;NOTIFICATIONID"                                                                                                                                                                                                                                                                             > $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file2 |grep -v -F -f $fullpath/temp/$report_file1 |egrep ";Critical;|;Major;|;Minor;"                                                                                                                                                                                                                                                                >> $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) Alarms"
}

function menu_36() {
  if [ $# -ne 2 ]; then
    choose_folders
  else
    cartella1=$1
	cartella2=$2
  fi
  report_file1="${date_report}_${current_user}_${cartella1}_alarms.csv"
  report_file2="${date_report}_${current_user}_${cartella2}_alarms.csv"
  report_file="${date_report}_${current_user}_${cartella1}_${cartella2}_alarms_merge_problem_type.csv"
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |sed -n '/Date;Time;Severity/,/Total: /p' |grep -v "Date;Time;Severity" |grep -v "Total: " |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |awk -F";" '{OFS=";";$2="";$3="";$NF="";$(NF-1)="";$(NF-2)="";$(NF-3)="";print $0}'           > $fullpath/temp/$report_file1
  grep -H . $fullpath/log/$cartella2/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |sed -n '/Date;Time;Severity/,/Total: /p' |grep -v "Date;Time;Severity" |grep -v "Total: " |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |awk -F";" '{OFS=";";$2="";$3="";$NF="";$(NF-1)="";$(NF-2)="";$(NF-3)="";print $0}'           > $fullpath/temp/$report_file2
  
  #Total:
  tot_problem_type=$(cat $fullpath/temp/$report_file2 |grep -v -F -f $fullpath/temp/$report_file1 |awk -F";" '{print $6}' | sort | uniq -c | sort -nr |sed 's/  *//' |sed 's/ /;/' |awk -F ";" 'BEGIN {total=0} {if ($1 ~ /^[0-9]+$/) {total += $1; }} END {print total}')
  echo "N;PROBLEMTYPE;%"                                                                                                                                                                                                                                                                                                                                                             > $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file2 |grep -v -F -f $fullpath/temp/$report_file1 |awk -F";" '{print $6}' | sort | uniq -c | sort -nr |sed 's/  *//' |sed 's/ /;/'   |awk -v tot_problem_type=$tot_problem_type -F";" '{print $1";"$2";"$1*100/tot_problem_type}'                                                                                    >> $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v PROBLEMTYPE |grep -c .)"
}

function menu_38() {
  if [ $# -ne 2 ]; then
    choose_folders
  else
    cartella1=$1
	cartella2=$2
  fi
  report_file1="${date_report}_${current_user}_${cartella1}_alarms.csv"
  report_file2="${date_report}_${current_user}_${cartella2}_alarms.csv"
  report_file="${date_report}_${current_user}_${cartella1}_${cartella2}_alarms_merge_mo.csv"
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |sed -n '/Date;Time;Severity/,/Total: /p' |grep -v "Date;Time;Severity" |grep -v "Total: " |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |awk -F";" '{OFS=";";$2="";$3="";$NF="";$(NF-1)="";$(NF-2)="";$(NF-3)="";print $0}'            > $fullpath/temp/$report_file1
  grep -H . $fullpath/log/$cartella2/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |sed -n '/Date;Time;Severity/,/Total: /p' |grep -v "Date;Time;Severity" |grep -v "Total: " |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |awk -F";" '{OFS=";";$2="";$3="";$NF="";$(NF-1)="";$(NF-2)="";$(NF-3)="";print $0}'            > $fullpath/temp/$report_file2
  
  #Total:
  tot_managedobject=$(cat $fullpath/temp/$report_file2 |grep -v -F -f $fullpath/temp/$report_file1 |awk -F";" '{print $5}' |sed 's/.*ManagedElement=1,//g' |sed 's/=.*,/,/g' |sed 's/=.*$//g' | sort | uniq -c | sort -nr |sed 's/  *//' |sed 's/ /;/'  |awk -F ";" 'BEGIN {total=0} {if ($1 ~ /^[0-9]+$/) {total += $1; }} END {print total}')
  echo "N;MANAGEDOBJECT;%"                                                                                                                                                                                                                                                                                                                                                            > $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file2 |grep -v -F -f $fullpath/temp/$report_file1 |awk -F";" '{print $5}' |sed 's/.*ManagedElement=1,//g' |sed 's/=.*,/,/g' |sed 's/=.*$//g' | sort | uniq -c | sort -nr |sed 's/  *//' |sed 's/ /;/'  |awk -v tot_managedobject=$tot_managedobject -F";" '{print $1";"$2";"$1*100/tot_managedobject}'                  >> $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v "MANAGEDOBJECT" |grep -c .)"
}

function menu_41() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_upg_package.csv"
  echo "NODE;CURRENT_UPGRADEPACKAGE"                                                                                                                                                                                                                                                                                                                                        > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'  |grep "currentUP" |sed 's/$currentUP = //g' |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g'                                                                                             >> $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) MOs"
}


function menu_41f() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_upg_package_full.csv"
  echo "NODE;UPGRADEPACKAGE;STATE"                                                                                                                                                                                                                                                                                                                                                     > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'                          |grep -v ";" |grep UpgradePackage= |grep -v "Current UpgradePkg" |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |sed 's/SwM=1,UpgradePackage=//g' |sed 's/UpgradePackage=//g'      >> $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) MOs"
}

function menu_41c() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_upg_package_count.csv"
  echo "   N_UP Node"                                                                                                                                                                                                                                                                                                                                                                                                 > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'                          |grep -v ";" |grep UpgradePackage= |grep -v "Current UpgradePkg" |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |sed 's/SwM=1,UpgradePackage=//g' |sed 's/UpgradePackage=//g' |awk -F";" '{print $1}' |sort |uniq -c |sort     >> $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v N_UP |grep -c .) MOs"
}

function menu_41m() {
  if [ $# -ne 2 ]; then
    choose_folders
  else
    cartella1=$1
	cartella2=$2
  fi
  report_file1="${date_report}_${current_user}_${cartella1}_upg_package.csv"
  report_file2="${date_report}_${current_user}_${cartella2}_upg_package.csv"
  report_file="${date_report}_${current_user}_${cartella1}_${cartella2}_upg_package_merge.csv"
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'  |grep "currentUP" |sed 's/$currentUP = //g' |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g'  |sort                          >> $fullpath/temp/$report_file1
  grep -H . $fullpath/log/$cartella2/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'  |grep "currentUP" |sed 's/$currentUP = //g' |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g'  |sort                          >> $fullpath/temp/$report_file2
  chmod 777 $fullpath/temp/$report_file1
  chmod 777 $fullpath/temp/$report_file2
  echo "NODE;UPGRADEPACKAGE;UPGRADEPACKAGE"                                                                                                                                             > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  join -t";" -a1 -a2 -e "" -o 0,1.2,2.2 $fullpath/temp/$report_file1 $fullpath/temp/$report_file2                                                                                      >> $fullpath/temp/$report_file
  #awk -F ";" '{ key[$1]=key[$1] ";"$2} END { for (i in key) print i key[i]}' $fullpath/temp/$report_file1 $fullpath/temp/$report_file2                                                 >> $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) MOs"
}

function menu_41d() {
  if [ $# -ne 2 ]; then
    choose_folders
  else
    cartella1=$1
	cartella2=$2
  fi
  report_file1="${date_report}_${current_user}_${cartella1}_upg_package.csv"
  report_file2="${date_report}_${current_user}_${cartella2}_upg_package.csv"
  report_file="${date_report}_${current_user}_${cartella1}_${cartella2}_upg_package_notchange.csv"
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'  |grep "currentUP" |sed 's/$currentUP = //g' |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g'  |sort                      >> $fullpath/temp/$report_file1
  grep -H . $fullpath/log/$cartella2/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'  |grep "currentUP" |sed 's/$currentUP = //g' |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g'  |sort                      >> $fullpath/temp/$report_file2
  chmod 777 $fullpath/temp/$report_file1
  chmod 777 $fullpath/temp/$report_file2
  echo "NODE;UPGRADEPACKAGE;UPGRADEPACKAGE"                                                                                                                                              > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  join -t";" -a1 -a2 -e "" -o 0,1.2,2.2 $fullpath/temp/$report_file1 $fullpath/temp/$report_file2 |awk -F";" '{sub(/\r$/, ""); if ($2==$3) print $all}'                                  >> $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) MOs"
}

function menu_44() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_brmbackup.csv"
  echo "" > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  echo "NODE;LAST_CV;SW"  > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |grep LastCreatedBackup |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log://g' |sed 's/LastCreatedBackup://g' |sed 's/  */;/g' >> $fullpath/temp/$report_file
  
  cat $fullpath/temp/$report_file |column -s";" -t |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) MOs"
}

function menu_45() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_license.csv"
  echo "NODE;KeyFileInformation;INSTALLATION TIME;KeyFileInformationID;LOCATABLE;PRODUCT TYPE;SEQUENCE NUMBER;"                                                                                                                                                                                                                                                              > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |grep "Lm=1,KeyFileManagement=1,KeyFileInformation=1" |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |sed 's/  */;/g'                                                                                         >> $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |awk -F";" '{print $1";"$3";"$6";"$7";"}' |sed 's/;/\t/g' |expand -t25 |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) MOs"
}

function menu_46() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_emergency.csv"
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |egrep "Lm=1,EmergencyUnlock=1|activationState" |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |awk -F";" '{if ((NR==1) || ($2 ~ "EmergencyUnlock")) print}' |grep ";" |sed 's/^.*;MO/NODE ;MO/g'                                                          > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |sed 's/;/\t/g' |expand -t25  |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) MOs"
}

function menu_47() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_erbs_lic.csv"
  echo "" > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
}

function menu_48() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_license_cxc.csv"
  echo "" > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |sed -n '/FeatureName   /,/Total: /p' |grep ";CXC" |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |awk -v OFS=";" -F";" '{print $3,$4,$5,$6,$7,$2,$10}' |sort |uniq -c |sort -n -r  |sed 's/^  *//g' |sed 's/ /;/' |sed '1i N;CXC;FAJ;LicenseState;FeatureState;ServiceState;FeatureName;Description'        > $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator2" |sed "1i\\$separator2" |sed "\$a\\$separator2"
  rm $fullpath/temp/$report_file
}


function menu_63() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_momversion.csv"
  echo "NODE;MOMVERSION"  > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'  |grep "\$momversion = " |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |sed 's/ = /;/g' |awk -F";" '{print $1";"$3}' >> $fullpath/temp/$report_file
  
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v MOMVERSION |grep -c .) MOs"
  
  echo -e "\n MOMVERSION SUMMARY"
  cat $fullpath/temp/$report_file |awk -F";" '{print $2}' |grep -v MOMVERSION | sort | uniq -c | sort -n  |sed 's/  *//' |sed 's/ /;/' |column -s ';' -t  |sed "1i\\$separator" |sed "\$a\\$separator"
 
}


function menu_49() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_sync.csv"
  echo "NODE;MO;encapsulation;operQualityLevel;priority;referenceStatus;syncRefType "  > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'  |grep ",RadioEquipmentClockReference=" |grep -v Warning |grep -v Minor |grep -v Major |grep -v Critical |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |sed 's/  *//g' >> $fullpath/temp/$report_file
  
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v encapsulation |grep -c .) RadioEquipmentClockReferences"
}





function menu_61() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file_scg="${date_report}_${current_user}_scg.csv"
  report_file_rats="${date_report}_${current_user}_scg_rats1.csv"
  report_file="${date_report}_${current_user}_rats_scg.csv"
  
  echo "00NODE;DEFAULT;SYSTEMCONSTANTS"  > $fullpath/temp/$report_file_scg
  chmod 777 $fullpath/temp/$report_file_scg
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'  |sed -n '/Namespace  SystemConstants/,+2p'          |grep default |sed 's/default/default[BB]/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |sed 's/  */;/g'            >> $fullpath/temp/$report_file_scg
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |sed -n '/All: /p'  |sed 's/All:/default[DU]   /g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |sed 's/  */;/g'                                                           >> $fullpath/temp/$report_file_scg
  
  #new
  echo "00NODE;RATS"  > $fullpath/temp/$report_file_rats
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'  |grep "\$rats = "       |sort   |sed 's/..(//g' |sed 's/)//g'  |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |sed 's/$rats = //g'                                          >> $fullpath/temp/$report_file_rats
  
  join -t';' -1 1 -2 1 -a 1 -a 2 -e "na" -o '0,2.2,1.2,1.3' <(sort -t';' -k1 $fullpath/temp/$report_file_scg) <(sort -t';' -k1 $fullpath/temp/$report_file_rats) | sed 's/na/ /g' |sed 's/00NODE/NODE/g'                                                                               > $fullpath/temp/$report_file
  
  cat $fullpath/temp/$report_file | column -t -s ';'  |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) MOs"
  rm $fullpath/temp/$report_file_rats
  rm $fullpath/temp/$report_file_scg

}

function menu_62() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_restart.csv"
  echo "NODE;NUMBER;REASON;TIME;PROGRAM;PID;RANK;SIGNAL;PMD;EXTRA"  > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  ##########################################################################
  ############## DA SISTEMARE e VERIFICARE PER ERBS E RADIONODE
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'  |grep -v _HEALTH_CHECK_START |sed -n '/llog -l 1/,/_HEALTH_CHECK_END/p' |grep -v _HEALTH_CHECK_END |grep -v "\-----" |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |sed ':a;N;$! ba;s/\n/;/g' |sed 's/llog -l 1/\n/g' |awk -v OFS=";" -F";" '{print $2,$3,$5,$7,$9,$11,$13,$15,$17,$19,$21,$23}' |sed 's/coli.*//g' >> $fullpath/temp/$report_file
  ############## DA SISTEMARE e VERIFICARE PER ERBS E RADIONODE
  ##########################################################################
  cat $fullpath/temp/$report_file |column -s ";" -t |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) MOs"
}


function menu_stzlte() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_stz_lte.csv"
  echo "" > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  grep -H . $fullpath/log/$cartella1/*.log   |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |sed -n '/;LTECell/,/Total: /p' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |grep -v "=====" |grep -v "Total: " |grep -v "\----------------" |awk -F";" '{if ((NR==1) || ($3 !~ "LTECell")) print}' |awk -v OFS=";" -F";" '{if (NR==1) $1="NODE "; print}'                   > $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator2" |sed "1i\\$separator2" |sed "\$a\\$separator2"
  cp $fullpath/temp/$report_file $fullpath/report_xlsx/$report_file
  rm $fullpath/temp/$report_file
}

function menu_stznr() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_stz_nr.csv"
  echo "" > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  grep -H . $fullpath/log/$cartella1/*.log   |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |sed -n '/;NRCell/,/Total: /p' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |grep -v "=====" |grep -v "Total: " |grep -v "\----------------" |awk -F";" '{if ((NR==1) || ($3 !~ "NRCell")) print}' |awk -v OFS=";" -F";" '{if (NR==1) $1="NODE "; print}'                   > $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator2" |sed "1i\\$separator2" |sed "\$a\\$separator2"
  cp $fullpath/temp/$report_file $fullpath/report_xlsx/$report_file
  rm $fullpath/temp/$report_file
}



function menu_mfc() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_mfc.csv"
  echo "" > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  grep -H . $fullpath/log/$cartella1/*.log   |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |sed -n '/FreqMHz/,/---------------/p' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |grep -v "=====" |grep -v "Total: " |grep -v "\----------------"  |awk -F";" '{if ((NR==1) || ($10 !~ "FreqMHz")) print}' |awk -v OFS=";" -F";" '{if (NR==1) $1="NODE "; print}'          > $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator2" |sed "1i\\$separator2" |sed "\$a\\$separator2"
  cp $fullpath/temp/$report_file $fullpath/report_xlsx/$report_file
  rm $fullpath/temp/$report_file
}


function menu_result() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_result.csv"
  echo "" > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  grep -H . $fullpath/log/$cartella1/*.log   |grep "RESULT:" |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g'          > $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator2" |sed "1i\\$separator2" |sed "\$a\\$separator2"
  cp $fullpath/temp/$report_file $fullpath/report_xlsx/$report_file
  rm $fullpath/temp/$report_file
}

function menu_82() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_custom.csv"

  echo -e "List of the MOs included in the Log"
  echo -e "---------------------------------------------------"
  grep -H . $fullpath/log/$cartella1/*.log  |sed -n '/_OTHER_CHECKS_START> /,/_OTHER_CHECKS_END> /p' |grep -v "\========" |grep -v prompt= |grep -v "Total: " |grep -v " Attribute " |grep -v " get " |grep -v RBS_NODE_MODEL |grep "=" |grep -v "\-----" |grep -v stopfile |grep -v SubNetwork |grep "=" |grep -v " = " |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |sed 's/    */;/g' |awk -F";" '{print $2}' |sed 's/=/;/g' |awk -F";" '{print $1}' |sort |uniq |sort
  echo -e "---------------------------------------------------\n"
  read -e -p "Insert a MO (included in the customized checks file) to check [type . to see all the MOs]: " MONAME
  read -e -p "Insert an Attribute to check (included in the customized checks file) [type . to see all the Attributes] [use | to include multiple Attributes]: " ATTRIBUTE
  read -e -p "Insert an Attribute Value to check [type . to see all the Values]: " VALUE
  if [ "$MONAME" = "." ]; then
    grep -H . $fullpath/log/$cartella1/*.log  |sed -n '/_OTHER_CHECKS_START> /,/_OTHER_CHECKS_END> /p' |grep -v "\========" |grep -v prompt= |grep -v "Total: " |grep -v " Attribute " |grep -v " get " |grep -v RBS_NODE_MODEL |grep "=" |grep -v "\-----" |grep -v stopfile |grep -v SubNetwork |grep "=" |grep -v " = " |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |sed 's/    */;/g'                                         |egrep -i "$ATTRIBUTE" |grep -i "$VALUE"        > $fullpath/temp/$report_file
  else
    grep -H . $fullpath/log/$cartella1/*.log  |sed -n '/_OTHER_CHECKS_START> /,/_OTHER_CHECKS_END> /p' |grep -v "\========" |grep -v prompt= |grep -v "Total: " |grep -v " Attribute " |grep -v " get " |grep -v RBS_NODE_MODEL |grep "=" |grep -v "\-----" |grep -v stopfile |grep -v SubNetwork |grep "=" |grep -v " = " |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |sed 's/    */;/g' |grep -i "$MONAME" |grep -v "$MONAME"\$ |egrep -i "$ATTRIBUTE" |grep -i "$VALUE"        > $fullpath/temp/$report_file
  fi
  chmod 777 $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |sed "1i\\$separator" |sed "\$a\\$separator" |sed "1i\\\n\\n\\n* * *  R E P O R T  * * * \\n\\nBB    MO:Attribute:Value"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .)"
  echo "BB;MO;Attribute;Value"                        > $fullpath/report_xlsx/$report_file
  cat $fullpath/temp/$report_file |sed 's/  */;/g'  >>  $fullpath/report_xlsx/$report_file
  chmod 777 $fullpath/report_xlsx/$report_file
  rm $fullpath/temp/$report_file
}

function menu_85() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file_nr_rel_full_log="${date_report}_${current_user}_nr_relations_full.txt"
  report_file_nr_gnb_id="${date_report}_${current_user}_nr_gnb_id.txt"
  report_file_cu_id="${date_report}_${current_user}_nr_cu_id.txt"
  report_file_nr_gnb_cu_id="${date_report}_${current_user}_nr_gnb_cu_id.txt"
  report_file_nr_summary="${date_report}_${current_user}_nr_summary.txt"
  report_file_rel="${date_report}_${current_user}_nr_relations.txt"
  report_file_final="${date_report}_${current_user}_nr_relations_report.txt"
  report_file_nr_test_summary="${date_report}_${current_user}_nr_test_summary.txt"

  grep -H . $fullpath/log/$cartella1/*.log               |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |egrep "NRCellRelation=|NRCellCU=|NRCellDU=|GNBCUUPFunction="  > $fullpath/temp/$report_file_nr_rel_full_log

  cat $fullpath/temp/$report_file_nr_rel_full_log |grep GNBCUUPFunction |sed 's/.log:/;/g' |sed 's/GNBCUUPFunction=1;//g' |awk -F";" '{print $1";"$2}'                                                                                                      > $fullpath/temp/$report_file_nr_gnb_id
  cat $fullpath/temp/$report_file_nr_rel_full_log |grep NRCellCU |grep -v NRCellRelation |sed 's/.log:/;/g' |sed 's/NRCellCU=//g' |awk -F";" '{print $1";"$3";"$2}' |sed 's/  *//g'                                                                         > $fullpath/temp/$report_file_cu_id

  join -t ';' -1 1 -2 1 -o '1.1 1.2 1.3 2.1 2.2' <(sort -t ';' -k1,1 $fullpath/temp/$report_file_cu_id) <(sort -t ';' -k1,1 $fullpath/temp/$report_file_nr_gnb_id)  >   $fullpath/temp/$report_file_nr_gnb_cu_id
  cat $fullpath/temp/$report_file_nr_gnb_cu_id |awk -v OFS=";" -F";" '{print $5"-"$2,$1,$4,$3}' > $fullpath/temp/$report_file_nr_test_summary
  cat $fullpath/temp/$report_file_nr_rel_full_log |grep NRCellRelation |sed 's/=/;/g' |sed 's/,/;/g' |sed 's/-/;/g' |awk -F";" '{print $6"-"$7";"$1";"$3";"$5";"$11}' |sed 's/^0*//'  > $fullpath/temp/$report_file_nr_summary
  join -t ';' -1 1 -2 1 -o '1.2 1.3 2.2 2.4 1.1 1.4 1.5' <(sort -t ';' -k1,1 $fullpath/temp/$report_file_nr_summary) <(sort -t ';' -k1,1 $fullpath/temp/$report_file_nr_test_summary) > $fullpath/temp/$report_file_final
  cat $fullpath/temp/$report_file_final |awk -F";" 'BEGIN{print "from_node;from_cell;to_node;to_cell;to_node-cell_id;to_plmn;to_freq"}{print}'  |sort |column -s ';' -t  |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo -e "Total: $(cat $fullpath/temp/$report_file_final |grep -v from_node |grep -c .) Relations"
}

function debug_report {
  debug_report="${date_report}_${current_user}_main.log"
  echo -e "---------------------------------------WARNING-----------------------------------------\n"                                                                                                                                                                                                                                                              >  $fullpath/temp/$debug_report
  echo -e "-------------------------------------Fragmented----------------------------------------"                                                                                                                                                                                                                                                                >> $fullpath/temp/$debug_report
  grep -H . $fullpath/log/$cartella1/*.log    |sed -n '/_LOADING_START> /,/_LOADING_END> /p' |grep "cannot create regular file"            |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g'                                                                                                                                                                     >> $fullpath/temp/$debug_report
  grep -H . $fullpath/log/$cartella1/*.log    |sed -n '/_LOADING_START> /,/_LOADING_END> /p' |grep ERROR                                   |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g'                                                                                                                                                                     >> $fullpath/temp/$debug_report
  echo -e "---------------------------------------------------------------------------------------\n"                                                                                                                                                                                                                                                              >> $fullpath/temp/$debug_report
  echo -e "----------------------------Wrong Username or Password---------------------------------"                                                                                                                                                                                                                                                                >> $fullpath/temp/$debug_report
  grep -H -i "wrong username" $fullpath/log/$cartella1/*.log             |sed -n '/_LOADING_START> /,/_LOADING_END> /p'                    |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g'                                                                                                                                                                     >> $fullpath/temp/$debug_report
  echo -e "---------------------------------------------------------------------------------------\n"                                                                                                                                                                                                                                                              >> $fullpath/temp/$debug_report
  echo -e "------------------------No Contact (from Mobatch result)-------------------------------"                                                                                                                                                                                                                                                                >> $fullpath/temp/$debug_report
  cat $fullpath/log/$cartella1/mobatch_result.txt |grep "no contact" |grep -v ":" |awk '{print $4}'                                                                                                                                                                                                                                                                 > $fullpath/temp/"${debug_report}_mobatch_nodes_no_contact.txt"
  cat $fullpath/log/$cartella1/mobatch_result.txt |grep "no contact" |grep -v ":" |awk '{print $4}'                                                                                                                                                                                                                                                                >> $fullpath/temp/$debug_report
  echo -e "---------------------------------------------------------------------------------------\n"                                                                                                                                                                                                                                                              >> $fullpath/temp/$debug_report
  echo -e "------------------------------CORBA.COMM_FAILURE---------------------------------------"                                                                                                                                                                                                                                                                >> $fullpath/temp/$debug_report
  grep -H "CORBA.COMM_FAILURE" $fullpath/log/$cartella1/*.log                                                                              |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g'                                                                                                                                                                     >> $fullpath/temp/$debug_report
  echo -e "---------------------------------------------------------------------------------------\n"                                                                                                                                                                                                                                                              >> $fullpath/temp/$debug_report
  echo -e "-----------------------------Unable to connect to--------------------------------------"                                                                                                                                                                                                                                                                >> $fullpath/temp/$debug_report
  grep -H "Unable to connect to" $fullpath/log/$cartella1/*.log                                                                            |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g'                                                                                                                                                                     >> $fullpath/temp/$debug_report
  echo -e "---------------------------------------------------------------------------------------\n"                                                                                                                                                                                                                                                              >> $fullpath/temp/$debug_report
  echo -e "--------------------------Nodes without cells in the log-------------------------------"                                                                                                                                                                                                                                                                >> $fullpath/temp/$debug_report
  ls $fullpath/log/$cartella1/*.log | xargs basename -s .log                                                                                                                                                                                                                                                                                                        > $fullpath/temp/"${debug_report}_mobatch_nodes_executed_list.txt"
  egrep -H "EUtranCell.DD=|NRCellDU=|Trx=|NodeBLocalCell=" $fullpath/log/$cartella1/*.log |grep -v CellSleepFunction |grep -v hget |grep -v ";" |awk -F":" '{print $1}' |sort |uniq | xargs basename -s .log                                                                                                                                                        > $fullpath/temp/"${debug_report}_nodes_with_cells.txt"
  cat $fullpath/temp/"${debug_report}_mobatch_nodes_executed_list.txt" |grep -v -f $fullpath/temp/"${debug_report}_nodes_with_cells.txt"   |grep -v -f $fullpath/temp/"${debug_report}_mobatch_nodes_no_contact.txt"                                                                                                                                               >> $fullpath/temp/$debug_report
  echo -e "---------------------------------------------------------------------------------------\n"                                                                                                                                                                                                                                                              >> $fullpath/temp/$debug_report
  echo -e "----------------------------------Log Format-------------------------------------------"                                                                                                                                                                                                                                                                >> $fullpath/temp/$debug_report
  if cat -vte $fullpath/log/$cartella1/*.log | grep -q '\^M'; then
    echo -e "Your Log files don't have the correct encoding.\nThey seems to be converted or modified in DOS format.\nSome checks could generate anomalies in the reports."                                                                                                                                                                                         >> $fullpath/temp/$debug_report
  fi
  echo -e "---------------------------------------------------------------------------------------"                                                                                                                                                                                                                                                                >> $fullpath/temp/$debug_report
  echo -e "---------------------------------------------------------------------------------------"                                                                                                                                                                                                                                                                >> $fullpath/temp/$debug_report

  cat $fullpath/temp/$debug_report
  rm $fullpath/temp/"${debug_report}_mobatch_nodes_no_contact.txt"
  rm $fullpath/temp/"${debug_report}_mobatch_nodes_executed_list.txt"
  rm $fullpath/temp/"${debug_report}_nodes_with_cells.txt"
  rm $fullpath/temp/$debug_report
}
