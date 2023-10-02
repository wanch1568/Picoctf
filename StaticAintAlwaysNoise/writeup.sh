./ltdis.sh static && if [ -f "static.ltdis.strings.txt" ] ; then
	echo -e "\033[31m"
	cat static.ltdis.strings.txt | grep "picoCTF"
	echo -e "\033[0m"
else
	echo -e "\033[31mstatic.ltdis.strings.txt doesn't exist\033[0m"
fi
