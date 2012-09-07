#!/bin/bash 
# auto run regular benchmark test
# When user press Ctrl+C then clear the environment


function RebootEnv()
{
	echo "$serverIP reboot"
#	ssh root\@$serverIP "reboot"
	echo "$clientIP reboot"
#	ssh root\@$clientIP "reboot"
	echo "$csgIP reboot"
	ssh root\@$csgIP "reboot"

	echo `date +"%Y-%m-%d %H:%M:%S"`
	echo "sleep 300 seconds..."
	sleep 300
}

# The first param $1 is the name of this test
function ConfigRun()
{
	echo "Start Running Test..."
	trap "RunBreak" 2

	time=`date '+%m%d%H%M%S'`
	if [ "$2" = "" ];then
		resultDir=../../results/$time.$1.$envStatus
	else
		resultDir=../../results/$time.$1.$envStatus.$2
	fi
	mkdir $resultDir

	logDir="$resultDir/log"
	mkdir "$logDir"

	debuglogDir="$resultDir/log/debuglog"
	mkdir "$debuglogDir"

	echo $resultDir

	ssh root\@$serverIP "mv /opt/URLDTEST/CPBenchmark/bin/result.*.* /tmp/"
	ssh root\@$clientIP "mv /opt/URLDTEST/CPBenchmark/bin/result.*.* /tmp/"
	ssh root\@$serverIP "mv /opt/CPSecure/CPBenchmark/bin/result.*.* /tmp/"
	ssh root\@$clientIP "mv /opt/CPSecure/CPBenchmark/bin/result.*.* /tmp/"

	ssh root\@$csgIP "mkdir -p /download/root"
	scp root\@$csgIP:/opt/CPSecure/CPWall/conf/cpwall.conf ../../pro/utm25/backup/
	scp ../../pro/utm/* root\@$csgIP:/download/root
	ssh root\@$clientIP "cd /usr/local/mstone/conf;cp general.wld.utm general.wld"
#	scp ../../pro/stm150/conf/* root\@$csgIP:/opt/CPSecure/CPWall/conf
#	scp ../../pro/stm150/blocksites/* root\@$csgIP:/opt/CPSecure/webui/common/conf/
#	ssh root\@$csgIP "chown cpwall.cpwall /opt/CPSecure/webui/common/conf/* " &
	
	echo "ini mstone"
	IniMstone
	
}


function BeforeReboot()
{
	ssh root\@$csgIP "cp /download/root/common.ini /opt/CPSecure/webui/conf/common.ini;/opt/CPSecure/share/bin/csgCheck >/dev/null 2>&1;"
	KillServices
}

function AfterReboot()
{
	KillServices
	
	ssh root\@$serverIP "/etc/init.d/apache stop;/etc/init.d/sendmail stop"
	ssh root\@$serverIP "/etc/init.d/exim4 stop"
	
	startTime="`ssh root\@$csgIP '/download/root/date.sh'`"
	ssh root\@$csgIP "/download/root/info.sh " &
	ssh root\@$csgIP "cd /download/root;/opt/mysql/bin/mysql -p123456 < /download/root/db.clear;
	free -m >> /download/root/$caseName.freem;
	pstree -p >> /download/root/$caseName.pstree;
	dmesg -c > /download/root/$caseName.dmesgStart.TXT
	echo '=========================================================================' > /download/root/$caseName.SYSINFO.TXT;
	echo 'svrIP=$svrIP; cliIP=$cliIP; csgIP=$csgIP;' >> /download/root/$caseName.SYSINFO.TXT;
	echo '=========================================================================' >> /download/root/$caseName.SYSINFO.TXT;
	echo 'Run Start: $startTime' >> /download/root/$caseName.SYSINFO.TXT;
	"
	
	case $caseName in 
		*IPS.Def*) 
			echo "Start IPS Default Rules..."
			ssh root\@$csgIP "/opt/snort_inline/sbin/ips_rule_mgmt set ips all enable_alert;/opt/snort_inline/sbin/ips_rule_mgmt apply_conf all;/opt/snort_inline/sbin/ips_ctrl start"
		;;
		*IPS.All*) 
			echo "Start IPS All Rules..."
			ssh root\@$csgIP "/opt/snort_inline/sbin/ips_rule_mgmt set ips all enable_drop;/opt/snort_inline/sbin/ips_rule_mgmt apply_conf all;/opt/snort_inline/sbin/ips_ctrl start"
		;;
		*RBL*) 
			echo "Start IPS All Rules..."
			ssh root\@"192.168.44.200" "/etc/init.d/named restart"
			ssh root\@$csgIP "echo 'nameserver 192.168.44.200' > /etc/resolv.conf;cp /download/root/rbl.db /opt/CPSecure/CPWall/conf/rbl.db"
		;;
		*) 
			echo "Not IPS Test"
		;;
	esac

#	ssh root\@$csgIP "cat /dev/null > /opt/CPSecure/CPWall/log/urlfilterlog"

}

function FinishCase()
{
	echo "stopping case: $caseName"
	echo "restore cpwall.conf"
	KillServices
	scp root\@$csgIP:/opt/CPSecure/CPWall/conf/cpwall.conf $caseDir/cpwall.conf.run
	
	echo "start to generate results..."
	stopTime="`ssh root\@$csgIP '/download/root/date.sh'`"
	ssh root\@$csgIP "
	cd /download/root;
	echo 'Run Stop : $stopTime ' >> /download/root/$caseName.SYSINFO.TXT;
	echo '=========================================================================' >> /download/root/$caseName.SYSINFO.TXT;
	cat $caseName.freem >> /download/root/$caseName.SYSINFO.TXT;
	echo '-------------------------------------------------------------------------' >> /download/root/$caseName.SYSINFO.TXT;
	free -m >> /download/root/$caseName.SYSINFO.TXT;
	echo '=========================================================================' >> /download/root/$caseName.SYSINFO.TXT;
	wc -l /opt/CPSecure/Eventd/cache/* >> /download/root/$caseName.SYSINFO.TXT;
	/opt/mysql/bin/mysql -p123456 < /download/root/db.count >> /download/root/$caseName.SYSINFO.TXT;
	echo '=========================================================================' >> /download/root/$caseName.SYSINFO.TXT;
	cat $caseName.pstree >> /download/root/$caseName.SYSINFO.TXT;
	echo '-------------------------------------------------------------------------' >> /download/root/$caseName.SYSINFO.TXT;
	pstree -p >> /download/root/$caseName.SYSINFO.TXT;
	echo '=========================================================================' >> /download/root/$caseName.SYSINFO.TXT;
	dmesg >$caseName.dmesg.TXT;
	mv /opt/CPSecure/CPWall/core* /download/root ;
	"

	echo "moving $caseName result files to $caseDir"
	scp root\@$csgIP:/download/root/$caseName.*.TXT $caseDir
	scp root\@$csgIP:/root/info.log.* $caseDir

	scp root\@$clientIP:/root/http $caseDir/root.http.$clientIP
	scp root\@$clientIP:/root/https $caseDir/root.https.$clientIP
	scp root\@$clientIP:/root/smtp $caseDir/root.smtp.$clientIP
	scp root\@$serverIP:/root/smtp $caseDir/root.smtp.$serverIP
	
	
	echo "mv log and revert cpwall.conf"
	mkdir -p "$caseDir/log_cpwall"
	scp root\@$csgIP:/opt/CPSecure/CPWall/log/* $caseDir/log_cpwall/
	mkdir -p "$caseDir/log_policyd"
	scp root\@$csgIP:/opt/policyd/log/* $caseDir/log_policyd
	mkdir -p "$caseDir/log_eventd"
	scp root\@$csgIP:/opt/CPSecure/Eventd/log/* $caseDir/log_eventd/
	mkdir -p "$caseDir/log_urld"
	scp root\@$csgIP:/opt/urld/log/* $caseDir/log_urld/
	mkdir -p "$caseDir/log_scand"
	scp root\@$csgIP:/opt/scand/log/* $caseDir/log_scand/
	scp $confOri root\@$csgIP:/opt/CPSecure/CPWall/conf/cpwall.conf

	echo "remove needn't files of /root/ in csg $csgIP"
	ssh root\@$csgIP "cd /download/root;mkdir -p tmp;mv info.log.* tmp/;mv $caseName.* tmp/;/etc/init.d/cpwalld restart"

	echo "benchmark test $caseName finished."
}

function FinishTest()
{
	echo "The Whole Test Finished. moving errlogs to $logDir"
	scp root\@$csgIP:/opt/CPSecure/CPWall/conf/cpwall.conf $logDir
	
	FinishMstone
	
	exit 0;
}


function BackupResult()
{
	#ssh root\@$csgIP "echo 'nameserver 192.168.3.1' > /etc/resolv.conf"
	#ssh root\@$csgIP "cd /opt/CPSecure/CPWall/conf/; cat /dev/null > bldb.conf"
	ssh root\@$clientIP "cd /usr/local/mstone;cp conf/smtp.wld.5k conf/smtp.wld"
	#ssh root\@$csgIP "cp /opt/CPSecure/webui/common/conf/block_sites.db.Default /opt/CPSecure/webui/common/conf/block_sites.db"
	mkdir -p $logDir/ServerURLDTESTRes
	mkdir -p $logDir/ClientURLDTESTRes
	mkdir -p $logDir/ServerRes
	mkdir -p $logDir/ClientRes
	
	scp root\@$serverIP:/opt/URLDTEST/CPBenchmark/bin/result.* $logDir/ServerURLDTESTRes
	scp root\@$clientIP:/opt/URLDTEST/CPBenchmark/bin/result.* $logDir/ClientURLDTESTRes
	scp root\@$serverIP:/opt/CPSecure/CPBenchmark/bin/result.* $logDir/ServerRes
	scp root\@$clientIP:/opt/CPSecure/CPBenchmark/bin/result.* $logDir/ClientRes
	
	ssh root\@$serverIP "mv /opt/URLDTEST/CPBenchmark/bin/result.*.* /tmp/"
	ssh root\@$clientIP "mv /opt/URLDTEST/CPBenchmark/bin/result.*.* /tmp/"
	ssh root\@$serverIP "mv /opt/CPSecure/CPBenchmark/bin/result.*.* /tmp/"
	ssh root\@$clientIP "mv /opt/CPSecure/CPBenchmark/bin/result.*.* /tmp/"
	
}

function ConfMstone()
{
	InitialEnv
	
	ssh root\@$serverIP "/home/delMail.sh"
	ssh root\@$serverIP "/etc/init.d/exim4 start"
}

function IniMstone()
{
	ssh root\@$serverIP "/home/delMail.sh"
	
	time=`date '+%m%d%H%M%S'`
	ssh root\@$clientIP "mkdir /tmp/$time"
	ssh root\@$clientIP "mv /usr/local/mstone/results/* /tmp/$time"
}

function FinishMstone()
{
	ssh root\@$serverIP "/etc/init.d/exim4 stop"
	ssh root\@$clientIP "/etc/init.d/exim4 stop"
	
	echo "$logDir/mstone/"
	scp -r root\@$clientIP:/usr/local/mstone/results/ $logDir/mstoneResults/
}

function FinishMstoneCase()
{
	mkdir -p $caseDir/mstone/
	
	scp -r root\@$clientIP:/usr/local/mstone/results/ $caseDir/mstone/
	scp root\@$serverIP:/root/$caseName.* $resultDir
	scp root\@$clientIP:/root/$caseName.* $resultDir
	ssh root\@$serverIP "rm -rf /root/$caseName.*"
	ssh root\@$clientIP "rm -rf /root/$caseName.*"
}









