#!/bin/sh


if [ -z "$1" ]; then
	ww=`date '+%y%m%d%H%M%S'`
	echo $ww
else
	ww=$1
fi


filelog="$PWD/info.log.$ww"

info()
{
	echo "##################################" >> $filelog
	date >> $filelog
	echo >> $filelog
	export TERM=vt100
	/usr/bin/top -c -b -n 2 >> $filelog
	free >> $filelog
	echo "   "  >> $filelog
	echo "##################################" >> $filelog
	echo "" >> $filelog
	echo "" >> $filelog
}

i=0;while [ 1 ]; do let i="$i+1";sleep 30;info ; done
