#USER SETTINGS FILE

#username_appears_in_filename=1 means that the username appears in all the log files created
username_appears_in_filename=1

#view=a means that the menu advanced is always chosen # view=b means that the menu basic is always chosen. Remove the comment # to activate this option
#view=a

#jardir_option=1 means that the jar files are stored in the folder specified in the row "jarxmlfolder"
#jardir_option=0 means that the jar files are not stored
jardir_option=0

#jarxmlfolder path. It is used if jardir_option=1
jarxmlfolder=/mta_fs/UserFiles/XXXXXXXX/jarxmlfiles

# number of parallel processes of mobatch
# comment the var if you prefer the asking of this value during the script
processes=10

# timeout of mobatch
# comment the var if you prefer the asking of this value during the script
timeout=10

# xlsx auto report generation. 1 means that the xlsx files are generated automatically after the default check menu
# [1,0]
autogeneration_xlsx=1

# xlsx auto report generation. The number of Delta Report. Not used if autogeneration_xlsx=0
# [0,1,2,3]
autogeneration_delta_xlsx=0

# you can see the log backup folder when see_backup_folder=1. Anyway the backup folder cannot be selected for the report.
see_backup_folder=0


#amosbatch_command="amosbatch"
amosbatch_command="/usr/local/bin/amosbatch"
#amosbatch_command="/home/moshell/mobatch"

#python_command="python3"
python_command="/usr/bin/python3"

#if short_report=1 more commands are included in the default checks and more items are present in the menu (i.e.: stz, mfc, invlc)
short_report=0

