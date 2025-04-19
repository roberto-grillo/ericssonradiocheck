#!/bin/bash

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
  53)  [[ -n "$static_folder1" ]] && menu_53 "$static_folder1" || menu_53 ;;
  54)  [[ -n "$static_folder1" ]] && menu_54 "$static_folder1" || menu_54 ;;
  55)  [[ -n "$static_folder1" ]] && menu_55 "$static_folder1" || menu_55 ;;
  60)  [[ -n "$static_folder1" ]] && menu_60 "$static_folder1" || menu_60 ;;
  40)  [[ -n "$static_folder1" ]] && menu_40 "$static_folder1" || menu_40 ;;
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
  17)  [[ -n "$static_folder1" ]] && menu_17 "$static_folder1" || menu_17 ;;
  18)  [[ -n "$static_folder1" ]] && menu_18 "$static_folder1" || menu_18 ;;
  16m)  [[ -n "$static_folder1" && -n "$static_folder2" ]] && menu_16m "$static_folder1" "$static_folder2" || menu_16m ;;
  16d)  [[ -n "$static_folder1" && -n "$static_folder2" ]] && menu_16d "$static_folder1" "$static_folder2" || menu_16d ;;
  21)  [[ -n "$static_folder1" ]] && menu_21 "$static_folder1" || menu_21 ;;
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
  63)  [[ -n "$static_folder1" ]] && menu_63 "$static_folder1" || menu_63 ;;
  61)  [[ -n "$static_folder1" ]] && menu_61 "$static_folder1" || menu_61 ;;
  62)  [[ -n "$static_folder1" ]] && menu_62 "$static_folder1" || menu_62 ;;
  stz4)  [[ -n "$static_folder1" ]] && menu_stzlte "$static_folder1" || menu_stzlte ;;
  stz5)  [[ -n "$static_folder1" ]] && menu_stznr "$static_folder1" || menu_stznr ;;
  mfc)  [[ -n "$static_folder1" ]] && menu_mfc "$static_folder1" || menu_mfc ;;
  82)  [[ -n "$static_folder1" ]] && menu_82 "$static_folder1" || menu_82 ;;
  85)   menu_85;;
  result) menu_result;;

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