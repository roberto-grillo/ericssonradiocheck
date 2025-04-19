#!/bin/bash

#source $fullpath/functions/menu_functions.sh
#source $fullpath/functions/selection_menu.sh
#source $fullpath/functions/selection_menu_auto.sh

function aggregation_single_menu() {
  menu_11 $1
  input_file8="$fullpath/temp/$report_file"
  menu_16 $1
  input_file9="$fullpath/temp/$report_file"
  menu_21 $1
  input_file10="$fullpath/temp/$report_file"
  menu_27 $1
  input_file11="$fullpath/temp/$report_file"
  menu_28 $1
  input_file12="$fullpath/temp/$report_file"
  menu_31 $1
  input_file13="$fullpath/temp/$report_file"
  menu_41 $1
  input_file14="$fullpath/temp/$report_file"
  menu_44 $1
  input_file15="$fullpath/temp/$report_file"
  menu_45 $1
  input_file16="$fullpath/temp/$report_file"
  menu_46 $1
  input_file17="$fullpath/temp/$report_file"
  menu_47 $1
  input_file18="$fullpath/temp/$report_file"
}

function aggregation_menu() {
  menu_11m $1 $2
  input_file1="$fullpath/temp/$report_file"
  menu_16m $1 $2
  input_file2="$fullpath/temp/$report_file"
  menu_21m $1 $2
  input_file3="$fullpath/temp/$report_file"
  menu_31d $1 $2
  input_file4="$fullpath/temp/$report_file"
  menu_36 $1 $2
  input_file5="$fullpath/temp/$report_file"
  menu_38 $1 $2
  input_file6="$fullpath/temp/$report_file"
  menu_41m $1 $2
  input_file7="$fullpath/temp/$report_file"
  
  menu_11 $2
  input_file8="$fullpath/temp/$report_file"
  menu_16 $2
  input_file9="$fullpath/temp/$report_file"
  menu_21 $2
  input_file10="$fullpath/temp/$report_file"
  menu_27 $2
  input_file11="$fullpath/temp/$report_file"
  menu_28 $2
  input_file12="$fullpath/temp/$report_file"
  menu_31 $2
  input_file13="$fullpath/temp/$report_file"
  menu_41 $2
  input_file14="$fullpath/temp/$report_file"
  menu_44 $2
  input_file15="$fullpath/temp/$report_file"
  menu_45 $2
  input_file16="$fullpath/temp/$report_file"
  menu_46 $2
  input_file17="$fullpath/temp/$report_file"
  menu_47 $2
  input_file18="$fullpath/temp/$report_file"
}

function aggregation_menu_delta() {
  menu_11d $1 $2
  input_file1="$fullpath/temp/$report_file"
  menu_16d $1 $2
  input_file2="$fullpath/temp/$report_file"
  menu_21d $1 $2
  input_file3="$fullpath/temp/$report_file"
  menu_31d $1 $2
  input_file4="$fullpath/temp/$report_file"
  menu_36 $1 $2
  input_file5="$fullpath/temp/$report_file"
  menu_38 $1 $2
  input_file6="$fullpath/temp/$report_file"
  menu_41d $1 $2
  input_file7="$fullpath/temp/$report_file"
  
  menu_11 $2
  input_file8="$fullpath/temp/$report_file"
  menu_16 $2
  input_file9="$fullpath/temp/$report_file"
  menu_21 $2
  input_file10="$fullpath/temp/$report_file"
  menu_27 $2
  input_file11="$fullpath/temp/$report_file"
  menu_28 $2
  input_file12="$fullpath/temp/$report_file"
  menu_31 $2
  input_file13="$fullpath/temp/$report_file"
  menu_41 $2
  input_file14="$fullpath/temp/$report_file"
  menu_44 $2
  input_file15="$fullpath/temp/$report_file"
  menu_45 $2
  input_file16="$fullpath/temp/$report_file"
  menu_46 $2
  input_file17="$fullpath/temp/$report_file"
  menu_47 $2
  input_file18="$fullpath/temp/$report_file"
}

function print_header {
cat $fullpath/txt/header.txt
}

function print_help {
  cat $fullpath/txt/help.txt
}



function menu_s1 {
  choose_folder
  static_folder1=$cartella1
}

function menu_s2 {
  choose_folders
  static_folder1=$cartella1
  static_folder2=$cartella2
}

function menu_su {
  unset static_folder1
  unset static_folder2
}

function create_checks {
  echo ""                                                                                                             >  $fullpath/cmd/${date}_cmds_auto_checks.mos
  chmod 777 $fullpath/cmd/${date}_cmds_auto_checks.mos
}

function append_checks {
  if [[ $short_report == "1" ]]; then
    cat $fullpath/cmd/cmds_def_checks_short.mos                                                                       >> $fullpath/cmd/${date}_cmds_auto_checks.mos
  else
    cat $fullpath/cmd/cmds_def_checks.mos                                                                             >> $fullpath/cmd/${date}_cmds_auto_checks.mos
  fi
}

function append_custom_checks {
  echo -e "\n"                                                                                                        >> $fullpath/cmd/${date}_cmds_auto_checks.mos
  echo -e "uv prompt=\$nodename_OTHER_CHECKS_START"                                                                   >> $fullpath/cmd/${date}_cmds_auto_checks.mos
  echo -e "\nChoose the custom checks file"
  ls $fullpath/cmd/ |sed "1i\\$separator" |sed "\$a\\$separator"
  read -e -p "Choice: " OTHER_CHECKS_FILE
  cat $fullpath/cmd/$OTHER_CHECKS_FILE                                                                                >> $fullpath/cmd/${date}_cmds_auto_checks.mos
  echo -e "\n"                                                                                                        >> $fullpath/cmd/${date}_cmds_auto_checks.mos
  echo -e "uv prompt=\$nodename_OTHER_CHECKS_END"                                                                     >> $fullpath/cmd/${date}_cmds_auto_checks.mos
  echo -e "uv prompt=\$nodename"                                                                                      >> $fullpath/cmd/${date}_cmds_auto_checks.mos
}

function delete_checks {
  rm $fullpath/cmd/${date}_cmds_auto_checks.mos
}

function advanced_options {
  if [[ ! $processes =~ ^[0-9]+$ ]]; then
    amosbatch_n_processes
  fi
  if [[ ! $timeout =~ ^[0-9]+$ ]]; then
    amosbatch_time
  fi
  amosbatch_jar_folder
}

function amosbatch_jar_folder {
  if [[ $jardir_option == "1" ]]; then
    mkdir -p  $jarxmlfolder                 ; chmod 777 $jarxmlfolder
    mkdir -p  $jarxmlfolder/momfragments    ; chmod 777 $jarxmlfolder/momfragments
    mkdir -p  $jarxmlfolder/momversioncache ; chmod 777 $jarxmlfolder/momversioncache
    jardir_command="-v jarxmldir=${jarxmlfolder}"
  else
    jardir_command=""
  fi
}

function assign_name_to_the_report {
  date=`date +%Y%m%d_%H%M%S`
  if [[ $CRON != "1" ]]; then
    echo -e "\n"
    read -e -p "Assign a name to the report activity [if left empty, a default name is chosen]: " activity_name
    activity_name=$(echo "$activity_name" | sed 's/[^[:alnum:]_-]//g')
    if [ "$activity_name" = "" ]; then
      custom_folder="${date}_${current_user}_report_${activity}"
    else
      custom_folder="${date}_${current_user}_report_${activity_name}"
    fi
  fi
  if [[ $CRON == "1" ]]; then
      custom_folder="${date}_${current_user}_report_${activity}"
  fi
}


function assign_name_to_the_changeall {
  date=`date +%Y%m%d_%H%M%S`
  if [[ $CRON != "1" ]]; then
    echo -e "\n"
    read -e -p "Assign a name to the change all activity [if left empty, a default name is chosen]: " activity_name
    activity_name=$(echo "$activity_name" | sed 's/[^[:alnum:]_-]//g')
    if [ "$activity_name" = "" ]; then
    custom_folder="${date}_${current_user}_changeall_${activity}"
    else
    custom_folder="${date}_${current_user}_changeall_${activity_name}"
    fi
  fi
  if [[ $CRON == "1" ]]; then
    custom_folder="${date}_${current_user}_changeall_${activity}"
  fi
}


function assign_name_to_the_activity {
  date=`date +%Y%m%d_%H%M%S`
  if [[ $CRON != "1" ]]; then
    echo -e "\n"
    read -e -p "Assign a name to the activity [if left empty, a default name is chosen]: " activity_name
    activity_name=$(echo "$activity_name" | sed 's/[^[:alnum:]_-]//g')
    if [ "$activity_name" = "" ]; then
    custom_folder="${date}_${current_user}_${activity}"
    else
    custom_folder="${date}_${current_user}_${activity_name}"
    fi
  fi
  if [[ $CRON == "1" ]]; then
    custom_folder="${date}_${current_user}_${activity}"
  fi
}

function copy_amosbatch_log_folder {
  mkdir $fullpath/log/$custom_folder && chmod 777 $fullpath/log/$custom_folder
  temporary_mobatch_folder=`cat $fullpath/temp/$custom_folder.log |grep "Logfiles stored in" |uniq |sed -n '1p' |awk -F" " '{print $NF}'`
  ###############################
  if [ -z "$temporary_mobatch_folder" ]; then
      echo "empty"
  else
      #echo "ok"
      cp -r $temporary_mobatch_folder/* $fullpath/log/$custom_folder && chmod 777 $fullpath/log/$custom_folder/*
      echo -e "\nLogfiles also stored in $fullpath/log/$custom_folder/"
      
      #cp -r $temporary_mobatch_folder/* /home/XXXXXXXX/CHECK/sharedlog/$custom_folder && chmod 777 /home/XXXXXXXX/CHECK/sharedlog/$custom_folder/*
      #echo -e "\nLogfiles also copied in XXXXXXXX folder"
  fi
  ###############################
}

function update_html_index {
  cat $fullpath/tools/index_create_01.html                                                                                                                         > $fullpath/report_html/index.html
  ls $fullpath/report_html/ |grep -v index.html |grep -v main.html    |awk '{print "<li><a href=\""$1"\" target=\"content-frame\">- "$1"</a></li>"}'              >> $fullpath/report_html/index.html
  cat $fullpath/tools/index_create_03.html                                                                                                                        >> $fullpath/report_html/index.html
}


function excel_report {
  date_report=`date +%Y%m%d_%H%M%S`
  export_file="$fullpath/report_xlsx/${custom_folder}.xlsx"
  export_html_file="$fullpath/report_html/${custom_folder}.html"
  echo -e "\n\nXLSX Reports creation:"
  echo -e "Processing..."

  aggregation_single_menu $custom_folder  >/dev/null
  $python_command $fullpath/tools/create_xlsx.py "$export_file"
  $python_command $fullpath/tools/create_xlsx_single_report.py "$export_file" 1 2 3 4 5 6 7 "$input_file8" "$input_file9" "$input_file10" "$input_file11" "$input_file12" "$input_file13" "$input_file14" "$input_file15" "$input_file16" "$input_file17" "$input_file18"
  source $fullpath/tools/html.sh $input_file8 $input_file9 $input_file10 $input_file11 $input_file12 $input_file13 $input_file14 $input_file15 $input_file16 $input_file17 $input_file18 > ${export_html_file}
  mv "$export_file" "$(echo "$export_file" | sed 's/_report_/_/g')"
  mv "$export_html_file" "$(echo "$export_html_file" | sed 's/_report_/_/g')"
  rm $fullpath/temp/"${date_report}_${current_user}"*
  

  
  count_report_folders=$(find "$fullpath/log" -maxdepth 1 -type d -name "*_report_*" | wc -l)

  echo -e "\n\nXLSX Merge Reports creation.\n"
  echo -e "Processing..."
  folder1=$(find "$fullpath/log" -maxdepth 1 -name "*_report_*"  | sort -n |tail -n 1 | head -n 1 | rev | cut -d '/' -f1 | rev)
  echo -e "\nCurrent report:"
  echo -e $folder1
  echo -e "\n"

  if [[ $count_report_folders -gt 1 && $autogeneration_delta_xlsx -gt 0 ]]; then
  echo -e "\nPrevious reports:"
  folder2=$(find "$fullpath/log" -maxdepth 1 -name "*_report_*"  | sort -n |tail -n 2 | head -n 1 | rev | cut -d '/' -f1 | rev)
  echo -e $folder2
  export_file="$fullpath/report_xlsx/${folder1}_${folder2}.xlsx"
  export_html_file="$fullpath/report_html/${folder1}_${folder2}.html"
  echo -e "\nProcessing (1-2)..."
  aggregation_menu $folder2 $folder1   >/dev/null
  excel_html_report_creation
  mv "$export_file" "$(echo "$export_file" | sed 's/_report_/_/g')"
  mv "$export_html_file" "$(echo "$export_html_file" | sed 's/_report_/_/g')"
  fi

  if [[ $count_report_folders -gt 2 && $autogeneration_delta_xlsx -gt 1 ]]; then
  folder3=$(find "$fullpath/log" -maxdepth 1 -name "*_report_*"  | sort -n |tail -n 3 | head -n 1 | rev | cut -d '/' -f1 | rev)
  echo -e $folder3
  export_file="$fullpath/report_xlsx/${folder1}_${folder3}.xlsx"
  export_html_file="$fullpath/report_html/${folder1}_${folder3}.html"
  echo -e "\nProcessing (1-3)..."
  aggregation_menu $folder3 $folder1   >/dev/null
  excel_html_report_creation
  mv "$export_file" "$(echo "$export_file" | sed 's/_report_/_/g')"
  mv "$export_html_file" "$(echo "$export_html_file" | sed 's/_report_/_/g')"
  fi

  if [[ $count_report_folders -gt 3 && $autogeneration_delta_xlsx -gt 2 ]]; then
  folder4=$(find "$fullpath/log" -maxdepth 1 -name "*_report_*"  | sort -n |tail -n 4 | head -n 1 | rev | cut -d '/' -f1 | rev)
  echo -e $folder4
  export_file="$fullpath/report_xlsx/${folder1}_${folder4}.xlsx"
  export_html_file="$fullpath/report_html/${folder1}_${folder4}.html"
  echo -e "\nProcessing (1-4)..."
  aggregation_menu $folder4 $folder1   >/dev/null
  excel_html_report_creation
  mv "$export_file" "$(echo "$export_file" | sed 's/_report_/_/g')"
  mv "$export_html_file" "$(echo "$export_html_file" | sed 's/_report_/_/g')"
  fi
  
  cp $fullpath/tools/main.html $fullpath/report_html/
  update_html_index
  echo -e "\nCompleted."
}

function excel_html_report_creation {
  $python_command $fullpath/tools/create_xlsx.py "$export_file"
  $python_command $fullpath/tools/create_xlsx_report.py "$export_file" "$input_file1" "$input_file2" "$input_file3" "$input_file4" "$input_file5" "$input_file6" "$input_file7" "$input_file8" "$input_file9" "$input_file10" "$input_file11" "$input_file12" "$input_file13" "$input_file14" "$input_file15" "$input_file16" "$input_file17" "$input_file18"
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

  rm $fullpath/temp/"${date_report}_${current_user}"*
}


function zip_amosbatch_log_files {
  find $fullpath/log/$custom_folder -name "*.log" -exec zip -j '{}.zip' '{}' \;
  echo -e "\nLogfiles zipped."
}

function installation {
if [ -d $fullpath/changeall ] || [ -d $fullpath/lists ] || [ -d $fullpath/log ] || [ -d $fullpath/report_xlsx ] || [ -d $fullpath/temp ] || [ -d $fullpath/cmd ] || [ -d $fullpath/settings ] || [ -d $fullpath/functions ] ; then
    #echo -e "\nNecessary directories exist. The script will be executed."
    echo -e " "
else
    echo -e "\nNecessary directories don't exist. The script cannot be executed."
    exit 1
fi
}

function permessi {
    chmod a+x $fullpath/..
    chmod a+x $fullpath
    chmod a+rwx $fullpath/log
    chmod a+rwx $fullpath/temp
}

function print_lists {
  echo -e "\nNode list files:"
  ls $fullpath/lists/ |sed "1i\\$separator" |sed "\$a\\$separator"
  echo -e "\nChange all files:"
  ls $fullpath/changeall/ |grep -v cmds_auto_checks.mos |sed "1i\\$separator" |sed "\$a\\$separator"
  echo -e "\nExecuted activities:"
  ls $fullpath/log/ |sed "1i\\$separator" |sed "\$a\\$separator"
  echo -e "\n"
}

function areyousure {

if [[ $CRON == "1" ]]; then
  echo " "
fi

if [[ $CRON != "1" ]]; then

  echo -e "\n"
  read -e -p "Are you sure you want to proceed? [y]: " areyousure
  if [ "$areyousure" = "y" ]; then
    echo " "
  else
    echo -e "\nExiting script."
    exit 1
  fi

fi



}

#function amosbatch_n_processes {
#min_n_processes=1
#max_n_processes=100
#while true; do
#    echo -e "\nMaximum number of parallel processes"
#    echo -e "default: 10; minimum: $min_n_processes; maximum: $max_n_processes."
#    read -e -p "Choice: " processes
#    if [[ $processes =~ ^[0-9]+$ ]]; then
#        if (($processes >= $min_n_processes && $processes <= $max_n_processes)); then
#            break
#        fi
#    fi
#    echo "Invalid input. Please enter a number of processes between $min_n_processes and $max_n_processes."
#done
#}


function amosbatch_n_processes {
    min_n_processes=1
    max_n_processes=100
    attempts=0
    max_attempts=3

    while (( attempts < max_attempts )); do
        echo -e "\nMaximum number of parallel processes"
        echo -e "default: 10; minimum: $min_n_processes; maximum: $max_n_processes."
        read -e -p "Choice: " processes
        if [[ $processes =~ ^[0-9]+$ ]]; then
            if (( processes >= min_n_processes && processes <= max_n_processes )); then
                break
            fi
        fi
        echo "Invalid input. Please enter a number of processes between $min_n_processes and $max_n_processes."
        ((attempts++))
    done

    if (( attempts == max_attempts )); then
        echo "Maximum number of attempts reached."
        processes=10
        echo "Max number of processes set to 10"
        return 1
    fi
}








#function amosbatch_time {
#min_timeout=5
#max_timeout=50
#echo -e "\nTime out [minutes]"
#echo -e "default: 10 minutes; minimum: $min_timeout; maximum: $max_timeout."
#while true; do
#    read -e -p "Choice: " timeout
#    if [[ $timeout =~ ^[0-9]+$ ]]; then
#        if (($timeout >= $min_timeout && $timeout <= $max_timeout)); then
#            break
#        fi
#    fi
#    echo "Invalid input. Please enter a timeout between $min_timeout and $max_timeout."
#done
#}

function amosbatch_time {
    min_timeout=5
    max_timeout=50
    attempts=0
    max_attempts=3

    echo -e "\nTime out [minutes]"
    echo -e "default: 10 minutes; minimum: $min_timeout; maximum: $max_timeout."
    
    while (( attempts < max_attempts )); do
        read -e -p "Choice: " timeout
        if [[ $timeout =~ ^[0-9]+$ ]]; then
            if (( timeout >= min_timeout && timeout <= max_timeout )); then
                break
            fi
        fi
        echo "Invalid input. Please enter a timeout between $min_timeout and $max_timeout."
        ((attempts++))
    done

    if (( attempts == max_attempts )); then
        echo "Maximum number of attempts reached."
        timeout=10
        echo "Timeout set to 10"
        return 1
    fi
}











# if [[ -n "$static_folder1" && -z "$static_folder2" ]]; then

function amosbatch_list {
if [[ $CRON == "1" && -z $LIST ]]; then
  LISTA="${fullpath}/lists/lista_nodi_crontab"
fi

if [[ $CRON == "1" && -n $LIST ]]; then
  LISTA=$LIST
fi

if [[ $CRON != "1" ]]; then
    echo -e "\nChoose the List (or insert the RBSs separated by ,)"
    ls $fullpath/lists/ |sed "1i\\$separator" |sed "\$a\\$separator"
    read -e -p "Choice: " mobatch_list
    if [ "$mobatch_list" = "" ]; then
      echo -e "\nExiting script."
      exit 1
    fi
    LISTA="${fullpath}/lists/${mobatch_list}"
    
    #questo di seguito dovrebbe servire per lavorare su una serie di nodi separati da virgola
    if [[ ! -f $fullpath/lists/$mobatch_list ]]; then
      LISTA="${mobatch_list}"
    fi
fi
}

function amosbatch_changeall {
if [[ $CRON == "1" && -z $CHANGEALL ]]; then
  CHANGEALL_SCRIPT="${fullpath}/changeall/changeall_crontab.mos"
fi

if [[ $CRON == "1" && -n $CHANGEALL ]]; then
  CHANGEALL_SCRIPT=$CHANGEALL
fi

if [[ $CRON != "1" ]]; then
  echo -e "\nChoose the ChangeAll"
  ls $fullpath/changeall/ |grep -v ${date}_cmds_auto_checks.mos |sed "1i\\$separator" |sed "\$a\\$separator"
  read -e -p "Choice: " mobatch_changeall
  if [ "$mobatch_changeall" = "" ]; then
  echo -e "\nExiting script."
  exit 1
  fi
  CHANGEALL_SCRIPT="${fullpath}/changeall/${mobatch_changeall}"
fi
}

function choose_folder {
  date_report=`date +%Y%m%d_%H%M%S`
  if [[ $see_backup_folder == "1" ]]; then
    echo -e "Backup Folders:"
    ls $fullpath/log/backup/ |sed "1i\\$separator" |sed "\$a\\$separator"
  fi
  echo -e "\nChoose from the following folders"
  ls $fullpath/log/ |sed "1i\\$separator" |sed "\$a\\$separator"
  echo -e "\n"
  read -e -p "Choice: "  cartella1
  if [ -d "$fullpath/log/$cartella1" ]; then
    echo ""
  else
    echo "The folder doesn't exist."
    echo -e "\nExiting script."
    exit 1
  fi
  echo -e "\n"
  if cat -vte $fullpath/log/$cartella1/*.log | grep -q '\^M'; then
    echo -e "\n********************************************************************************************************\nWARNING.\nIt seems that your log files have been converted or modified in DOS format.\nSome checks could generate anomalies in the reports.\n********************************************************************************************************\n\n"
  fi
}

function choose_folders {
  date_report=`date +%Y%m%d_%H%M%S`
  if [[ $see_backup_folder == "1" ]]; then
    echo -e "Backup Folders:"
    ls $fullpath/log/backup/ |sed "1i\\$separator" |sed "\$a\\$separator"
  fi
  echo -e "\nInsert the folders in chronological order.\nFirst insert the older folder, than the latest Folders.\nThe merge and delta report is the result of the rows of the latest Folder minus the rows of the oldest one.\nChoose from the following folders.\n"
  ls $fullpath/log/ |sed "1i\\$separator" |sed "\$a\\$separator"
  read -e -p "First Activity Folder:  " cartella1
  read -e -p "Second Activity Folder: " cartella2
  if [ -d "$fullpath/log/$cartella1" ]; then
    echo ""
  else
    echo "The first folder doesn't exist."
    echo -e "\nExiting script."
    exit 1
  fi
  if [ -d "$fullpath/log/$cartella2" ]; then
    echo ""
  else
    echo "The second folder doesn't exist."
    echo -e "\nExiting script."
    exit 1
  fi
  echo -e "\n"
  if cat -vte $fullpath/log/$cartella1/*.log $fullpath/log/$cartella2/*.log | grep -q '\^M'; then
    echo -e "\n********************************************************************************************************\nWARNING.\nIt seems that your log files have been converted or modified in DOS format.\nSome checks could generate anomalies in the reports.\n********************************************************************************************************\n\n"
  fi
}


######################



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
  $amosbatch_command -p $processes -t $timeout $jardir_command $LISTA $fullpath/cmd/${date}_cmds_auto_checks.mos 2>&1 |tee "$logfile_amosbatch"
  #echo "TEST"
  #cat $logfile_amosbatch |grep "Unauthorized call" |sed "s/'//g" |awk '{print $NF}'
  #echo "-------------------"
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
  if [[ $CHANGEALL_SCRIPT =~ ".csv" ]]; then
    cat $CHANGEALL_SCRIPT | grep MO | grep Attribute | awk -F";" '{ for (i = 6; i <= NF; ++i) print "- " $i; exit }'
    read -e -p "Choose the Test Case: " test_case
    find_column=$(cat "$CHANGEALL_SCRIPT" | grep MO | grep Attribute | awk -F";" '{ for (i = 6; i <= NF; ++i) print i, $i; exit }' |grep "$test_case" |awk '{ print $1 }')
    echo -e "\n\n"

    # la parte con gsub sostituisce tutto quello che c'è tra le parentesi tonde in $column
    cat "$CHANGEALL_SCRIPT" |awk -F";" -v column="$find_column" '{ gsub(/\([^\)]*\)/, "", $column); if ($1 ~ /^#/) { print "#set "substr($1, 2)" "$2" "$column; } else { print "set "$1" "$2" "$column; } }' |sed '1d' |grep -v ^$ |sed "1i cvms pre_${activity_name}_${test_case}" |sed '1i lt all' |sed '1i gsg+' |sed '1i confbdl+' |sed "\$a cvms post_${activity_name}_${test_case}" |sed '$a gsg-' |sed '$a confbdl-' > $fullpath/changeall/script_${activity_name}_${test_case}.mos
    cat $fullpath/changeall/script_${activity_name}_${test_case}.mos
    TEST_CASE="${fullpath}/changeall/script_${activity_name}_${test_case}.mos"
    echo -e "\n\n"
    echo -e "\n\nSCRIPT created in changeall folder:"
    echo $TEST_CASE
    echo -e "\n"
    read -e -p "Do you want to proceed NOW with the set on the nodes? [y/n] " sure_set
    
    if [[ $sure_set =~ "y" ]]; then
        logfile_amosbatch="$fullpath/temp/$custom_folder.log"
        $amosbatch_command -p $processes -t $timeout $jardir_command $LISTA $TEST_CASE 2>&1 |tee "$logfile_amosbatch"
        echo "amosbatch errno: $?"
        copy_amosbatch_log_folder
        echo "copy folder errno: $?"
    fi
  else
    logfile_amosbatch="$fullpath/temp/$custom_folder.log"
    $amosbatch_command -p $processes -t $timeout $jardir_command $LISTA $CHANGEALL_SCRIPT 2>&1 |tee "$logfile_amosbatch"
    echo "amosbatch errno: $?"
    copy_amosbatch_log_folder
    echo "copy folder errno: $?"
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
  $amosbatch_command -p $processes -t $timeout $jardir_command $LISTA $fullpath/cmd/${date}_cmds_auto_checks.mos 2>&1 |tee "$logfile_amosbatch"
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
  $amosbatch_command -p $processes -t $timeout $jardir_command $LISTA $fullpath/cmd/${date}_cmds_auto_checks.mos 2>&1 |tee "$logfile_amosbatch"
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
  $amosbatch_command -p $processes -t $timeout $jardir_command $LISTA "lt all;kget" 2>&1 |tee "$logfile_amosbatch"
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
  $amosbatch_command -p $processes -t $timeout $jardir_command $LISTA $fullpath/cmd/safe_backup.mos 2>&1 |tee "$logfile_amosbatch"
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
  $amosbatch_command -p $processes -t $timeout $jardir_command $fullpath/lists/temp_mom_list_100_nodes $fullpath/cmd/download_mom.mos 2>&1 |tee "$logfile_amosbatch"
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
  $amosbatch_command -p $processes -t $timeout $jardir_command $LISTA 'run $scripts/chkHwac.mos' 2>&1 |tee "$logfile_amosbatch"
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

function menu_52l() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_change_all_nochange.txt"
  echo -e "\nChangeAll: Parameters - No Change\n"
  grep -H . $fullpath/log/$cartella1/*.log |grep -v "Last MO" |grep "no change" |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/ /g' |awk -F" " '{$2=""; print}' |sed 's/  /;/g' |sed 's/ /;/g'
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

function menu_53l() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_change_all_set.txt"
  echo -e "\nChangeAll: Parameters - Set\n"
  grep -H . $fullpath/log/$cartella1/*.log |grep -v "Last MO" |grep " Set." |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/ /g' |awk -F" " '{$2=""; print}' |sed 's/  /;/g' |sed 's/ /;/g'
}

function menu_60s() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_change_all_set.txt"
  echo -e "\nChangeAll: Parameters - Set - No change\n"
  grep -H . $fullpath/log/$cartella1/*.log |egrep " Set.|Result|no change" |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/ /g' |awk '{$2=""; sub(/^ /, ""); print}' | awk '/Result/ {last=$3; next} (/Set\./ || /no change/) {printf "%s %s %s", $1, $2, last; for(i=3;i<=NF;i++){printf " %s", $i}; print ""}' |sed 's/>>> Set./(SET)/g' |sed 's/-no change-/(NO_CHANGE)/g' |column -t
}

function menu_54() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_change_all_deleted.txt"
  echo -e "\nChangeAll: MO Deleted\n"
  echo "NODE;N OF DELETED"                                                                                                                                                                                                                                                        > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  grep -H . $fullpath/log/$cartella1/*.log |grep -v "Last MO" |grep " Mo deleted" |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/ /g' |awk -F" " '{print $1,$(NF-1),$NF}' |sed 's/-$//g' |sed 's/ -/ /g' | sort | uniq -c | sort -n |awk -v OFS=";" '{print $2, $1, $3, $4}'     >> $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator2" |sed "1i\\$separator2" |sed "\$a\\$separator2"
  rm $fullpath/temp/$report_file
}

function menu_54l() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_change_all_deleted_list.txt"
  echo -e "\nChangeAll: MO Deleted\n"
  echo "NODE MONAME"                                                                                                                                                > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  grep -H . $fullpath/log/$cartella1/*.log |grep -v "Last MO" |grep " Mo deleted" |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/ /g' |awk -F" " '{print $1,$3}'   >> $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ' ' -t |sed "1a\\$separator2" |sed "1i\\$separator2" |sed "\$a\\$separator2"
  rm $fullpath/temp/$report_file
}

function menu_54s() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_change_all_deleted_summary.txt"
  echo -e "\nChangeAll: MO Deleted\n"
  echo "N MONAME"                                                                                                                                                                                                                                     > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  grep -H . $fullpath/log/$cartella1/*.log |grep -v "Last MO" |grep " Mo deleted" |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/ /g' |awk -F" " '{print $3}' |awk -F"," '{print $NF}' |sort |uniq -c |sort -n -r  |sed 's/^  *//g'                                      >> $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ' ' -t |sed "1a\\$separator2" |sed "1i\\$separator2" |sed "\$a\\$separator2"
  rm $fullpath/temp/$report_file
}

function menu_55() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_change_all_created.csv"
  echo -e "\nChangeAll: MO Created\n"
  echo "NODE;PROXY;MONAME"                                                                                                                                                                                                                                                            > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  grep -H . $fullpath/log/$cartella1/*.log |grep "Proxy ID = " |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/ /g' |sed 's/>>>/;/' |sed 's/  *//' |sed 's/MO name :/;MO name ;/g' |awk -v OFS=";" -F";" '{print $1}' |sort |uniq -c |sort -n -r |awk '{print $2, $1, "MO Created"}'   >> $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator2" |sed "1i\\$separator2" |sed "\$a\\$separator2"
  cp $fullpath/temp/$report_file $fullpath/report_xlsx/$report_file
  rm $fullpath/temp/$report_file
}

function menu_55l() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_change_all_created_list.csv"
  echo -e "\nChangeAll: MO Created\n"
  echo "NODE;PROXY;MONAME"                                                                                                                                                                                                                    > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  grep -H . $fullpath/log/$cartella1/*.log |grep "Proxy ID = " |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/ /g' |sed 's/>>>/;/' |sed 's/  *//' |sed 's/MO name :/;MO name ;/g' |awk -v OFS=";" -F";" '{print $1,$2,$4}' |sed 's/  *//g'   >> $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator2" |sed "1i\\$separator2" |sed "\$a\\$separator2"
  cp $fullpath/temp/$report_file $fullpath/report_xlsx/$report_file
  rm $fullpath/temp/$report_file
}

function menu_55s() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_change_all_created_summary.csv"
  echo -e "\nChangeAll: MO Created\n"
  echo "N MONAME"                                                                                                                                                                                                                                                                           > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  grep -H . $fullpath/log/$cartella1/*.log |grep "Proxy ID = " |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/ /g' |sed 's/>>>/;/' |sed 's/  *//' |sed 's/MO name :/;MO name ;/g' |awk -v OFS=";" -F";" '{print $1,$2,$4}' |sed 's/  *//g' |awk -F"," '{print $NF}' |sort |uniq -c |sort -n -r |sed 's/^  *//g'  >> $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ' ' -t |sed "1a\\$separator2" |sed "1i\\$separator2" |sed "\$a\\$separator2"
  cp $fullpath/temp/$report_file $fullpath/report_xlsx/$report_file
  rm $fullpath/temp/$report_file
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
  rm $fullpath/temp/$report_unfiltered_file
}


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

function menu_16E() {
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

function menu_16D() {
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


function menu_tp44() {
  if [ $# -eq 0 ]; then
    choose_folder
    echo -e "\n"
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_tp44.csv"
  report_file_tmp="${date_report}_${current_user}_tp_temporary.csv"
  echo "NODE;ADMINISTRATIVE;OPERATIONAL;TERMINATIONPOINT;REMOTE"  > $fullpath/temp/$report_file_tmp
  chmod 777 $fullpath/temp/$report_file_tmp
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |egrep "ABLED\)|LOCKED\)" |egrep "TermPointToENB=" |grep -v TermPointToLbm |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |sort |awk -F"-" '{print $all";"$3}' |awk -v OFS=";" -F";" '{print $1,$4,$5,$6,$7}'      >> $fullpath/temp/$report_file_tmp

  if [ -f "$fullpath/import/enbid.csv" ]; then
    echo ""
  else
    echo -e "enbid.csv file not found or empty. Association enbid -> nodename not done."
    echo "" > $fullpath/import/enbid.csv
    chmod 777 $fullpath/import/enbid.csv
  fi

  awk -F";" 'NR==FNR {m[$1]=$2; next} {for (i=1; i<=NF; i++) if ($i in m) $i=m[$i]} 1' $fullpath/import/enbid.csv $fullpath/temp/$report_file_tmp |sed 's/ /;/g' > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator2" |sed "1i\\$separator2" |sed "\$a\\$separator2"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) MOs"
  echo -e "\n"
  cat $fullpath/temp/$report_file |egrep "DISABLED|NODE" |column -s ';' -t |sed "1a\\$separator2" |sed "1i\\$separator2" |sed "\$a\\$separator2"
  echo "Disabled: $(cat $fullpath/temp/$report_file |grep DISABLED |grep -v NODE |grep -c .) MOs"
  rm $fullpath/temp/$report_file_tmp
}

function menu_tp45() {
  if [ $# -eq 0 ]; then
    choose_folder
    echo -e "\n"
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_tp45.csv"
  report_file_tmp="${date_report}_${current_user}_tp_temporary.csv"
  echo "NODE;ADMINISTRATIVE;OPERATIONAL;TERMINATIONPOINT;REMOTE"  > $fullpath/temp/$report_file_tmp
  chmod 777 $fullpath/temp/$report_file_tmp
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |egrep "ABLED\)|LOCKED\)" |egrep "TermPointToGNB="  |sed 's/0000000000/0000000000-/g' |awk -F"-" '{print $all,"( "$5" )"}' |sed 's/0000000000-/0000000000/g'    |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |sort |awk -F"-" '{print $all";"$3}' |awk -v OFS=";" -F";" '{print $1,$4,$5,$6,$7}'      >> $fullpath/temp/$report_file_tmp
  
  if [ -f "$fullpath/import/gnbid.csv" ]; then
    echo ""
  else
    echo -e "gnbid.csv file not found or empty. Association gnbid -> nodename not done."
    echo "" > $fullpath/import/gnbid.csv
    chmod 777 $fullpath/import/gnbid.csv
  fi
  
  awk -F";" 'NR==FNR {m[$1]=$2; next} {for (i=1; i<=NF; i++) if ($i in m) $i=m[$i]} 1' $fullpath/import/gnbid.csv $fullpath/temp/$report_file_tmp |sed 's/ /;/g' > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator2" |sed "1i\\$separator2" |sed "\$a\\$separator2"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) MOs"
  echo -e "\n"
  cat $fullpath/temp/$report_file |egrep "DISABLED|NODE" |column -s ';' -t |sed "1a\\$separator2" |sed "1i\\$separator2" |sed "\$a\\$separator2"
  echo "Disabled: $(cat $fullpath/temp/$report_file |grep DISABLED |grep -v NODE |grep -c .) MOs"
  rm $fullpath/temp/$report_file_tmp
}


function menu_tp54() {
  if [ $# -eq 0 ]; then
    choose_folder
    echo -e "\n"
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_tp54.csv"
  report_file_tmp="${date_report}_${current_user}_tp_temporary.csv"
  echo "NODE;ADMINISTRATIVE;OPERATIONAL;TERMINATIONPOINT;REMOTE"  > $fullpath/temp/$report_file_tmp
  chmod 777 $fullpath/temp/$report_file_tmp
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |egrep "ABLED\)|LOCKED\)" |egrep "TermPointToENodeB="  |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |sed 's/,TermPoint/_TermPoint/g' |awk -F"_" '{print $all";"$4}' |sed 's/_TermPoint/,TermPoint/g' |sort |awk -v OFS=";" -F";" '{print $1,$4,$5,$6,$7}'       >> $fullpath/temp/$report_file_tmp
  
  if [ -f "$fullpath/import/enbid.csv" ]; then
    echo ""
  else
    echo -e "enbid.csv file not found or empty. Association enbid -> nodename not done."
    echo "" > $fullpath/import/enbid.csv
    chmod 777 $fullpath/import/enbid.csv
  fi
  
  awk -F";" 'NR==FNR {m[$1]=$2; next} {for (i=1; i<=NF; i++) if ($i in m) $i=m[$i]} 1' $fullpath/import/enbid.csv $fullpath/temp/$report_file_tmp |sed 's/ /;/g' > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator2" |sed "1i\\$separator2" |sed "\$a\\$separator2"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) MOs"
  echo -e "\n"
  cat $fullpath/temp/$report_file |egrep "DISABLED|NODE" |column -s ';' -t |sed "1a\\$separator2" |sed "1i\\$separator2" |sed "\$a\\$separator2"
  echo "Disabled: $(cat $fullpath/temp/$report_file |grep DISABLED |grep -v NODE |grep -c .) MOs"
  rm $fullpath/temp/$report_file_tmp
}

function menu_tp55() {
  if [ $# -eq 0 ]; then
    choose_folder
    echo -e "\n"
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_tp55.csv"
  report_file_tmp="${date_report}_${current_user}_tp_temporary.csv"
  echo "NODE;ADMINISTRATIVE;OPERATIONAL;TERMINATIONPOINT;REMOTE"  > $fullpath/temp/$report_file_tmp
  chmod 777 $fullpath/temp/$report_file_tmp
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |egrep "ABLED\)|LOCKED\)" |egrep "TermPointToGNodeB="  |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |sed 's/,TermPoint/_TermPoint/g' |awk -F"_" '{print $all";"$4}' |sed 's/_TermPoint/,TermPoint/g' |sort |awk -v OFS=";" -F";" '{print $1,$4,$5,$6,$7}'      >> $fullpath/temp/$report_file_tmp
  
  if [ -f "$fullpath/import/gnbid.csv" ]; then
    echo ""
  else
    echo -e "gnbid.csv file not found or empty. Association enbid -> nodename not done."
    echo "" > $fullpath/import/gnbid.csv
    chmod 777 $fullpath/import/gnbid.csv
  fi
  
  awk -F";" 'NR==FNR {m[$1]=$2; next} {for (i=1; i<=NF; i++) if ($i in m) $i=m[$i]} 1' $fullpath/import/gnbid.csv $fullpath/temp/$report_file_tmp |sed 's/ /;/g' > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator2" |sed "1i\\$separator2" |sed "\$a\\$separator2"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) MOs"
  echo -e "\n"
  cat $fullpath/temp/$report_file |egrep "DISABLED|NODE" |column -s ';' -t |sed "1a\\$separator2" |sed "1i\\$separator2" |sed "\$a\\$separator2"
  echo "Disabled: $(cat $fullpath/temp/$report_file |grep DISABLED |grep -v NODE |grep -c .) MOs"
  rm $fullpath/temp/$report_file_tmp
}



function menu_temp_summary() {
  if [ $# -eq 0 ]; then
    choose_folder
    echo -e "\n"
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_summary_temp.csv"
  echo -e "BB;DATE;RATS;REALRATS;5GObj;AddressIPv4 Creato;Formato Corretto Indirizzi IP;IPSEC;N MO IPSEC in conf Switch off;N MO IPSEC MO in conf Switch on;AddressIPV4 presente prima della configurazione;AddressIPV4 presente dopo la configurazione;IP;IP/SUB;NEXTHOP;FDD OFF PRE;FDD OFF POST;NRCell OFF PRE;NRCell OFF POST;TP_5G_4G_tot;TP_5G_4G_dis_pre;TP_5G_4G_dis_post;TP_5G_5G_tot;TP_5G_5G_dis_pre;TP_5G_5G_dis_post;TP_4G_5G_tot;TP_4G_5G_dis_pre;TP_4G_5G_dis_post;TP_4G_4G_tot;TP_4G_4G_dis_pre;TP_4G_4G_dis_post;alert_nexthop;old_nexthop"  > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  grep -H . $fullpath/log/$cartella1/*.log |grep SUMMARY |sed 's/..(//g' |sed 's/)//g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:SUMMARY:/;/g' |sed 's/:;/;/g' |grep -v echo >> $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file
}




function menu_temp_tp() {
  if [ $# -eq 0 ]; then
    choose_folder
    echo -e "\n"
  else
    cartella1=$1
  fi
  report_file1="${date_report}_${current_user}_tp_pre_temp.csv"
  report_file2="${date_report}_${current_user}_tp_pos_temp.csv"
  report_file3="${date_report}_${current_user}_tp_temporary.csv"
  report_file_col="${date_report}_${current_user}_tp_pre_temp_col6.csv"
  report_file="${date_report}_${current_user}_tp_delta.csv"
  echo "NODE;A;ADMINISTRATIVE;O;OPERATIONAL;TERMINATIONPOINT;REMOTE"  > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_PRECHECK_START> /,/_PRECHECK_STOP> /p'   |egrep "ABLED\)|LOCKED\)" |egrep "TermPointToENodeB=|TermPointToGNodeB=|TermPointToGNB=|TermPointToENB=" |grep -v lst |sed 's/ (//g' |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |sed 's/  */;/g' |awk -F";" '{$2=""; print}' |sed 's/  */;/g'   |sed 's/(/;/g'    >> $fullpath/temp/$report_file1
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_POSTCHECK_START> /,/_POSTCHECK_STOP> /p' |egrep "ABLED\)|LOCKED\)" |egrep "TermPointToENodeB=|TermPointToGNodeB=|TermPointToGNB=|TermPointToENB=" |grep -v lst |sed 's/ (//g' |sed 's/..(//g' |sed 's/)//g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |sed 's/  */;/g' |awk -F";" '{$2=""; print}' |sed 's/  */;/g'   |sed 's/(/;/g'    >> $fullpath/temp/$report_file2
  cat $fullpath/temp/$report_file2 |grep -v -F -f $fullpath/temp/$report_file1  > $fullpath/temp/$report_file3
  
  cut -d';' -f6 $fullpath/temp/$report_file1 | grep -v '^$' |grep -v ADMINISTRATIVE > $fullpath/temp/$report_file_col
  
  grep -F -f $fullpath/temp/$report_file_col $fullpath/temp/$report_file3 >> $fullpath/temp/$report_file
  
  cat $fullpath/temp/$report_file
  echo -e "\n\n"
  
  echo -e "Delta New TerminationPoint:"
  cat $fullpath/temp/$report_file3 |grep -v -F -f $fullpath/temp/$report_file
  echo -e "----\n\n"
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator" |sed "1i\\$separator" |sed "\$a\\$separator"
  echo "Total: $(cat $fullpath/temp/$report_file |grep -v NODE |grep -c .) MOs"
}

function menu_temp_celle() {
  if [ $# -eq 0 ]; then
    choose_folder
    echo -e "\n"
  else
    cartella1=$1
  fi
  report_file1="${date_report}_${current_user}_celle_pre_temp.csv"
  report_file2="${date_report}_${current_user}_celle_pos_temp.csv"
  report_file="${date_report}_${current_user}_celle_temp.csv"
  echo "NODE;A;ADMINISTRATIVE;O;OPERATIONAL;CELLA"  > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_PRECHECK_START> /,/_PRECHECK_STOP> /p'   |egrep "ABLED\)|LOCKED\)" |egrep "NRCellDU=|EUtranCellFDD=" |grep -v lst |sed 's/ (/;/g' |sed 's/..(/;/g' |sed 's/)/;/g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |awk -v OFS=";" -F";" '{$2=""; print}' |sed 's/.log:;//g' |sed 's/;;/;/g'       >> $fullpath/temp/$report_file1
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_POSTCHECK_START> /,/_POSTCHECK_STOP> /p' |egrep "ABLED\)|LOCKED\)" |egrep "NRCellDU=|EUtranCellFDD=" |grep -v lst |sed 's/ (/;/g' |sed 's/..(/;/g' |sed 's/)/;/g' |sed 's/  */;/g' |sed 's%.*/\([^/]*\.log\):%\1:%' |awk -v OFS=";" -F";" '{$2=""; print}' |sed 's/.log:;//g' |sed 's/;;/;/g'       >> $fullpath/temp/$report_file2
  cat $fullpath/temp/$report_file2 |grep -v -F -f $fullpath/temp/$report_file1 >> $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file
  echo -e "\n\n"
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

function menu_49D() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_sync_dis.csv"
  echo "NODE;MO;encapsulation;operQualityLevel;priority;referenceStatus;syncRefType "  > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  grep -H . $fullpath/log/$cartella1/*.log |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p'  |grep ",RadioEquipmentClockReference=" |grep -v Warning |grep -v Minor |grep -v Major |grep -v Critical |grep -v NO_FAULT |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g' |sed 's/  *//g' >> $fullpath/temp/$report_file
  
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


function menu_stz() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_stz_report.html"
  cat $fullpath/tools/stz_band_report_header.html                                                                                                                      > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  cat $fullpath/log/$cartella1/*.log   |sed -n '/_HEALTH_CHECK_START> /,/_HEALTH_CHECK_END> /p' |sed -n '/;LTECell/,/Total/p; /;NRCell/,/Total/p' |grep -v Total |grep "=" |grep -v "=====" |sed 's/ //g' |awk -F";" '{print "{ \"cell\": \""$2"\", \"band\": "$18", \"freqDL\": "$14", \"freqUL\": "$15", \"dlBw\": "$16", \"ulBw\": "$17" },"}' |column -t                  >> $fullpath/temp/$report_file
  cat $fullpath/tools/stz_band_report_footer.html                                                                                                                      >> $fullpath/temp/$report_file
  echo -e "Frequency Test Chart created in report_html folder."
  cp $fullpath/temp/$report_file $fullpath/report_html/$report_file
  rm $fullpath/temp/$report_file
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


function menu_r() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_result.csv"
  echo "NODE;RESULT;DESCRIPTION" > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  grep -H . $fullpath/log/$cartella1/*.log   |grep "RESULT:" |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g'          >> $fullpath/temp/$report_file
  cat $fullpath/temp/$report_file |column -s ';' -t |sed "1a\\$separator2" |sed "1i\\$separator2" |sed "\$a\\$separator2"
  cp $fullpath/temp/$report_file $fullpath/report_xlsx/$report_file
  rm $fullpath/temp/$report_file
}

function menu_rs() {
  if [ $# -eq 0 ]; then
    choose_folder
  else
    cartella1=$1
  fi
  report_file="${date_report}_${current_user}_result_summary.csv"
  echo "N;RESULT" > $fullpath/temp/$report_file
  chmod 777 $fullpath/temp/$report_file
  grep -H . $fullpath/log/$cartella1/*.log   |grep "RESULT:" |sed 's%.*/\([^/]*\.log\):%\1:%' |sed 's/.log:/;/g'  |awk -F":" '{print $2}' |sort |uniq -c |sort -n -r   |sed 's/^  *//g'     >> $fullpath/temp/$report_file
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

#######################
function selection_menu_auto {
source $fullpath/settings/user_settings.sh

if [[ -z $SEQUENCE ]]; then
SEQUENCE="menu_01"
#SEQUENCE="menu_01; menu_CA; menu_01"
fi
eval $SEQUENCE
}

function selection_menu {
while true; do
echo -e "\n"
#read -e -p "[$static_folder1] - [$static_folder2] Menu Number: " option

unset processes
unset timeout
source $fullpath/settings/user_settings.sh

if [[ -n "$static_folder1" && -z "$static_folder2" ]]; then
    echo -e "\033[1;32m"  # Set text color to green
    read -e -p "[$static_folder1] Menu Number: " option
    echo -e "\033[0m"  # Reset text color
fi

if [[ -z "$static_folder1" && -z "$static_folder2" ]]; then
    read -e -p "Menu Number: " option
fi


if [[ -n "$static_folder1" && -n "$static_folder2" ]]; then
    echo -e "\033[1;31m"  # Set text color to red
    read -e -p "[$static_folder1 - $static_folder2] Menu Number: " option
    echo -e "\033[0m"  # Reset text color
fi

if [[ -z "$static_folder1" && -n "$static_folder2" ]]; then
    read -e -p "[$static_folder2] Menu Number: " option
fi


case "$option" in


  s1)   menu_s1;;
  s2)   menu_s2;;
  su)   menu_su;;

  CA)   menu_CA;;
  01)   menu_01;;
  02)   menu_02;;
  03)   menu_03;;
  mom)  menu_mom;;
  KD)   menu_KD;;
  BC)   menu_BC;;
  HC)   menu_HC;;
   x)   menu_x;;
  xm)   menu_xm;;
  xd)   menu_xd;;
  50)  [[ -n "$static_folder1" ]] && menu_50 "$static_folder1" || menu_50 ;;
  51)  [[ -n "$static_folder1" ]] && menu_51 "$static_folder1" || menu_51 ;;
  52)  [[ -n "$static_folder1" ]] && menu_52 "$static_folder1" || menu_52 ;;
  52l) [[ -n "$static_folder1" ]] && menu_52l "$static_folder1" || menu_52l ;;
  53)  [[ -n "$static_folder1" ]] && menu_53 "$static_folder1" || menu_53 ;;
  53l) [[ -n "$static_folder1" ]] && menu_53l "$static_folder1" || menu_53l ;;
  54)  [[ -n "$static_folder1" ]] && menu_54 "$static_folder1" || menu_54 ;;
  54l) [[ -n "$static_folder1" ]] && menu_54l "$static_folder1" || menu_54l ;;
  54s) [[ -n "$static_folder1" ]] && menu_54s "$static_folder1" || menu_54s ;;
  55)  [[ -n "$static_folder1" ]] && menu_55 "$static_folder1"  || menu_55 ;;
  55l) [[ -n "$static_folder1" ]] && menu_55l "$static_folder1" || menu_55l ;;
  55s) [[ -n "$static_folder1" ]] && menu_55s "$static_folder1" || menu_55s ;;
  60)  [[ -n "$static_folder1" ]] && menu_60 "$static_folder1"  || menu_60 ;;
  60s)  [[ -n "$static_folder1" ]] && menu_60s "$static_folder1"  || menu_60s ;;
  40)  [[ -n "$static_folder1" ]] && menu_40 "$static_folder1"  || menu_40 ;;
  10s) [[ -n "$static_folder1" ]] && menu_10s "$static_folder1" || menu_10s ;;
  10m) [[ -n "$static_folder1" ]] && menu_10m "$static_folder1" || menu_10m ;;
  10)  [[ -n "$static_folder1" ]] && menu_10 "$static_folder1" || menu_10 ;;
  11)  [[ -n "$static_folder1" ]] && menu_11 "$static_folder1" || menu_11 ;;
  12)  [[ -n "$static_folder1" ]] && menu_12 "$static_folder1" || menu_12 ;;
  13)  [[ -n "$static_folder1" ]] && menu_13 "$static_folder1" || menu_13 ;;
  14)  [[ -n "$static_folder1" ]] && menu_14 "$static_folder1" || menu_14 ;;
  11m)  [[ -n "$static_folder1" && -n "$static_folder2" ]] && menu_11m "$static_folder1" "$static_folder2" || menu_11m ;;
  11md)  [[ -n "$static_folder1" && -n "$static_folder2" ]] && menu_11md "$static_folder1" "$static_folder2" || menu_11md ;;
  11d)  [[ -n "$static_folder1" && -n "$static_folder2" ]] && menu_11d "$static_folder1" "$static_folder2" || menu_11d ;;
  16)  [[ -n "$static_folder1" ]] && menu_16 "$static_folder1" || menu_16 ;;
  16E)  [[ -n "$static_folder1" ]] && menu_16E "$static_folder1" || menu_16E ;;
  16D)  [[ -n "$static_folder1" ]] && menu_16D "$static_folder1" || menu_16D ;;
  16m)  [[ -n "$static_folder1" && -n "$static_folder2" ]] && menu_16m "$static_folder1" "$static_folder2" || menu_16m ;;
  16d)  [[ -n "$static_folder1" && -n "$static_folder2" ]] && menu_16d "$static_folder1" "$static_folder2" || menu_16d ;;
  21)  [[ -n "$static_folder1" ]] && menu_21 "$static_folder1" || menu_21 ;;
  tp44)  [[ -n "$static_folder1" ]] && menu_tp44 "$static_folder1" || menu_tp44 ;;
  tp45)  [[ -n "$static_folder1" ]] && menu_tp45 "$static_folder1" || menu_tp45 ;;
  tp54)  [[ -n "$static_folder1" ]] && menu_tp54 "$static_folder1" || menu_tp54 ;;
  tp55)  [[ -n "$static_folder1" ]] && menu_tp55 "$static_folder1" || menu_tp55 ;;
  
  temp_summary)  [[ -n "$static_folder1" ]] && menu_temp_summary "$static_folder1" || menu_temp_summary ;;
  temp_tp)       [[ -n "$static_folder1" ]] && menu_temp_tp      "$static_folder1" || menu_temp_tp ;;
  temp_celle)    [[ -n "$static_folder1" ]] && menu_temp_celle   "$static_folder1" || menu_temp_celle ;;
  
  

  24)  [[ -n "$static_folder1" ]] && menu_24 "$static_folder1" || menu_24 ;;
  26)  [[ -n "$static_folder1" ]] && menu_26 "$static_folder1" || menu_26 ;;
  29)  [[ -n "$static_folder1" ]] && menu_29 "$static_folder1" || menu_29 ;;
  24m)  [[ -n "$static_folder1" && -n "$static_folder2" ]] && menu_24m "$static_folder1" "$static_folder2" || menu_24m ;;
  24d)  [[ -n "$static_folder1" && -n "$static_folder2" ]] && menu_24d "$static_folder1" "$static_folder2" || menu_24d ;;
  26m)  [[ -n "$static_folder1" && -n "$static_folder2" ]] && menu_26m "$static_folder1" "$static_folder2" || menu_26m ;;
  26d)  [[ -n "$static_folder1" && -n "$static_folder2" ]] && menu_26d "$static_folder1" "$static_folder2" || menu_26d ;;
  29m)  [[ -n "$static_folder1" && -n "$static_folder2" ]] && menu_29m "$static_folder1" "$static_folder2" || menu_29m ;;
  29d)  [[ -n "$static_folder1" && -n "$static_folder2" ]] && menu_29d "$static_folder1" "$static_folder2" || menu_29d ;;
  21m) [[ -n "$static_folder1" && -n "$static_folder2" ]] && menu_21m "$static_folder1" "$static_folder2" || menu_21m ;;
  21d) [[ -n "$static_folder1" && -n "$static_folder2" ]] && menu_21d "$static_folder1" "$static_folder2" || menu_21d ;;
  27)  [[ -n "$static_folder1" ]] && menu_27 "$static_folder1" || menu_27 ;;
  28)  [[ -n "$static_folder1" ]] && menu_28 "$static_folder1" || menu_28 ;;
  31)  [[ -n "$static_folder1" ]] && menu_31 "$static_folder1" || menu_31 ;;
  31d)  [[ -n "$static_folder1" && -n "$static_folder2" ]] && menu_31d "$static_folder1" "$static_folder2" || menu_31d ;;
  33)  [[ -n "$static_folder1" ]] && menu_33 "$static_folder1" || menu_33 ;;
  33d)  [[ -n "$static_folder1" && -n "$static_folder2" ]] && menu_33d "$static_folder1" "$static_folder2" || menu_33d ;;
  35)  [[ -n "$static_folder1" && -n "$static_folder2" ]] && menu_35 "$static_folder1" "$static_folder2" || menu_35 ;;
  36)  [[ -n "$static_folder1" && -n "$static_folder2" ]] && menu_36 "$static_folder1" "$static_folder2" || menu_36 ;;
  38)  [[ -n "$static_folder1" && -n "$static_folder2" ]] && menu_38 "$static_folder1" "$static_folder2" || menu_38 ;;
  41)  [[ -n "$static_folder1" ]] && menu_41 "$static_folder1" || menu_41 ;;
  41f) [[ -n "$static_folder1" ]] && menu_41f "$static_folder1" || menu_41f ;;
  41c) [[ -n "$static_folder1" ]] && menu_41c "$static_folder1" || menu_41c ;;
  41m)  [[ -n "$static_folder1" && -n "$static_folder2" ]] && menu_41m "$static_folder1" "$static_folder2" || menu_41m ;;
  41d)  [[ -n "$static_folder1" && -n "$static_folder2" ]] && menu_41d "$static_folder1" "$static_folder2" || menu_41d ;;
  44)  [[ -n "$static_folder1" ]] && menu_44 "$static_folder1" || menu_44 ;;
  45)  [[ -n "$static_folder1" ]] && menu_45 "$static_folder1" || menu_45 ;;
  46)  [[ -n "$static_folder1" ]] && menu_46 "$static_folder1" || menu_46 ;;
  48)  [[ -n "$static_folder1" ]] && menu_48 "$static_folder1" || menu_48 ;;
  49)  [[ -n "$static_folder1" ]] && menu_49 "$static_folder1" || menu_49 ;;
  49D)  [[ -n "$static_folder1" ]] && menu_49D "$static_folder1" || menu_49D ;;
  63)  [[ -n "$static_folder1" ]] && menu_63 "$static_folder1" || menu_63 ;;
  61)  [[ -n "$static_folder1" ]] && menu_61 "$static_folder1" || menu_61 ;;
  62)  [[ -n "$static_folder1" ]] && menu_62 "$static_folder1" || menu_62 ;;
  stz)  [[ -n "$static_folder1" ]] && menu_stz "$static_folder1" || menu_stz ;;
  stz4)  [[ -n "$static_folder1" ]] && menu_stzlte "$static_folder1" || menu_stzlte ;;
  stz5)  [[ -n "$static_folder1" ]] && menu_stznr "$static_folder1" || menu_stznr ;;
  mfc)  [[ -n "$static_folder1" ]] && menu_mfc "$static_folder1" || menu_mfc ;;
  82)  [[ -n "$static_folder1" ]] && menu_82 "$static_folder1" || menu_82 ;;
  85)   menu_85;;
  r) menu_r;;
  rs) menu_rs;;

  e) echo -e "Exiting script.\n";exit 1;;
  q) echo -e "Exiting script.\n";exit 1;;
  f) print_lists;;
  a) menu_a;;
  b) menu_b;;
  m) print_menu;;
  h) print_help;;

  *) echo "Invalid Choice.";;

esac

done
}



function print_menu1 {
  cat $fullpath/txt/menu1.txt
}

function print_menu2 {

  if [[ $short_report == "1" ]]; then
      cat $fullpath/txt/menu2_short.txt
  else
      cat $fullpath/txt/menu2.txt
  fi
}

function print_menu {
  if [[ $view == "b" ]]; then
    print_menu1
  fi
  
  if [[ $view == "a" ]]; then
    print_menu2
  fi
}

function menu_a {
  view=a
  print_menu2
}

function menu_b {
  view=b
  print_menu1
}

######################## MAIN ############################


#separator="================================================================================================================="
#separator2="============================================================================================================================================================="

separator=$(printf '%*s' 80 '' | tr ' ' '=')
separator2=$(printf '%*s' 160 '' | tr ' ' '=')

GRN='\033[0;32m'
RED='\033[0;31m'
NCL='\033[0m'

echo -e "\n\n\n############################## path information start #####################################"
echo "execute:     " $0
dir=`echo $(pwd)`
if [[ "$dir" == "" ]]; then dir=`echo $PWD` ; fi
echo "dir:         " $dir
runpath=`echo $0`
echo "runpath:     " $runpath
filename=`echo $runpath |awk -F"/" '{print $NF}'`
echo "filename:    " $filename
if [[ "$runpath" == "./"* ]]; then temppath=$dir$runpath ; elif [[ "$runpath" == "/"* ]]; then temppath=$runpath ; elif [[ "$runpath" == "../"* ]]; then echo "You cannot run it from this subfolder. Please go to an upper folder"; exit ; elif [[ "$runpath" != "/"* ]]; then temppath=$dir"/"$runpath ; fi
echo "temppath:    " $temppath
fullpath=`echo $temppath |sed 's/\.\//\//g' |awk -F"/" '{$NF=""; print}' |sed 's/ /\//g' |sed 's/\/\//\//g' |sed 's/\/$//g'`
echo "fullpath:    " $fullpath
echo -e "############################### path information end ######################################\n\n\n"

installation



if [[ $CRON != "1" ]]; then
print_header
fi

permessi
view=b



if [[ $username_appears_in_filename == "1" ]]; then
  current_user=$(whoami)
else
  current_user="0"
fi

if [[ $CRON != "1" ]]; then
print_menu
selection_menu
fi

if [[ $CRON == "1" ]]; then
selection_menu_auto
fi
##########################################################