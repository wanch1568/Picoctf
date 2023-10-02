#!/bin/bash

# The -a オプションは変数を配列として定義
declare -a file_names=("dolls.jpg" "2_c.jpg" "3_c.jpg" "4_c.jpg")
declare -a skip_values=(272492 187707 123606 79578)
#for i in "${!file_names[@]}"; do は配列のindexをループ
#for i in "${file_names[@]}"; do は配列のvalueをループ
for i in "${!file_names[@]}" ; do
	echo -e "\033[32mbinwalk ${file_names[$i]}\033[0m"
	binwalk "${file_names[$i]}"
	
	echo -e "\033[32mdd if=${file_names[$i]} of=extracted.zip bs=1 skip=${skip_values[$i]} status=progress\033[0m"
    dd if="${file_names[$i]}" of=extracted.zip bs=1 skip="${skip_values[$i]}" status=progress
	
	echo -e "\033[32munzip extracted.zip\033[0m"
    unzip extracted.zip
	
	if [ "$i" !=  3 ] ; then
		echo -e "\033[32mcd base_images\033[0m"
		cd base_images
	else
		echo -e "\033[32mcat flag.txt\033[0m"
		cat "flag.txt"
	fi
done
