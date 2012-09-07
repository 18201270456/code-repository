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
	echo "sleep 200 seconds..."
	sleep 200
}

# The first param $1 is the name of this test
function ConfigRun()
{
	echo "Start Running Test..."
	
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
	
	echo "resultDir=$resultDir"
	
	ssh root\@$serverIP "mv /opt/URLDTEST/CPBenchmark/bin/result.*.* /tmp/"
	ssh root\@$clientIP "mv /opt/URLDTEST/CPBenchmark/bin/result.*.* /tmp/"
	ssh root\@$serverIP "mv /opt/CPSecure/CPBenchmark/bin/result.*.* /tmp/"
	ssh root\@$clientIP "mv /opt/CPSecure/CPBenchmark/bin/result.*.* /tmp/"
	
	CopyTestFiles
	
	ssh root\@$csgIP "
	cd /opt/CPSecure/webui/common/conf;
	sed -e '5,1000s/0$/1/g' block_sites.db > block_sites.db.BlockAll;
	sed -e '5,1000s/1$/0/g' block_sites.db > block_sites.db.AllowAll;
	cp block_sites.db          block_sites.db.Default;
	cp block_sites.db.AllowAll block_sites.db;
	chown cpwall.cpwall *;
	"
	ssh root\@$csgIP  "
	cd /opt/snort_inline/conf;
	sed -e s/block/allow/g ips.conf > ips.conf.allow;
	cp ips.conf.allow ips.conf;
	"
	ssh root\@$clientIP "cd /usr/local/mstone/conf;cp general.wld.stm general.wld"
	
	IniMstone
	
}

function BeforeReboot()
{
	echo "start do sth before reboot..."
	echo "finish do sth before reboot."
}

function AfterReboot()
{
	echo "start do sth after reboot..."
	
	startTime="`ssh root\@$csgIP '/root/date.sh'`"
	ssh root\@$csgIP "/root/info.sh temp " &
	ssh root\@$csgIP "/root/test.pl " &
	
	# Clear MySQL DataBase 
	ssh root\@$csgIP "mysql -p123456 < /root/dbcplog_db.clear"
	
	ssh root\@$serverIP "/etc/init.d/apache stop;killall HTTPServer;killall SMTPServer;/etc/init.d/sendmail stop"
	ssh root\@$serverIP "killall -9 HTTPServer;killall -9 SMTPServer"
	ssh root\@$serverIP "/etc/init.d/exim4 stop"
	
	ssh root\@$csgIP "free -m >> /root/$caseName.freem"
	ssh root\@$csgIP "pstree -p >> /root/$caseName.pstree"
	ssh root\@$csgIP "dmesg -c > /root/$caseName.dmesgStart.TXT"
	
	echo "finish do sth after reboot."
}

function FinishCase()
{
	echo "stopping case: $caseName"
	
	echo "start to generate results..."
	stopTime="`ssh root\@$csgIP '/root/date.sh'`"
	ssh root\@$csgIP "echo '=========================================================================' > /root/$caseName.SYSINFO.TXT"
	ssh root\@$csgIP "echo 'svrIP=$svrIP; cliIP=$cliIP; csgIP=$csgIP;' >> /root/$caseName.SYSINFO.TXT"
	ssh root\@$csgIP "echo '=========================================================================' >> /root/$caseName.SYSINFO.TXT"
	ssh root\@$csgIP "echo 'Run Start: $startTime' >> /root/$caseName.SYSINFO.TXT"
	ssh root\@$csgIP "echo 'Run Stop : $stopTime ' >> /root/$caseName.SYSINFO.TXT"
	ssh root\@$csgIP "echo '=========================================================================' >> /root/$caseName.SYSINFO.TXT"
	ssh root\@$csgIP "cat $caseName.freem >> /root/$caseName.SYSINFO.TXT"
	ssh root\@$csgIP "echo '-------------------------------------------------------------------------' >> /root/$caseName.SYSINFO.TXT"
	ssh root\@$csgIP "free -m >> /root/$caseName.SYSINFO.TXT"
	ssh root\@$csgIP "echo '-------------------------------------------------------------------------' >> /root/$caseName.SYSINFO.TXT"
	sleep 200
	stopTime="`ssh root\@$csgIP '/root/date.sh'`"
	GetRunTime
	ssh root\@$csgIP "free -m >> /root/$caseName.SYSINFO.TXT"
	ssh root\@$csgIP "echo '=========================================================================' >> /root/$caseName.SYSINFO.TXT"
	ssh root\@$csgIP "wc -l wc -l /opt/CPSecure/CPWall/log/*log >> /root/$caseName.SYSINFO.TXT"
	ssh root\@$csgIP "mysql -p123456 < /root/dbcplog_db.count >> /root/$caseName.SYSINFO.TXT"
	ssh root\@$csgIP "echo '=========================================================================' >> /root/$caseName.SYSINFO.TXT"
	ssh root\@$csgIP "cat $caseName.pstree >> /root/$caseName.SYSINFO.TXT"
	ssh root\@$csgIP "echo '-------------------------------------------------------------------------' >> /root/$caseName.SYSINFO.TXT"
	ssh root\@$csgIP "pstree -p >> /root/$caseName.SYSINFO.TXT"
	ssh root\@$csgIP "uptime >> /root/$caseName.SYSINFO.TXT"
	ssh root\@$csgIP "echo '=========================================================================' >> /root/$caseName.SYSINFO.TXT"
	ssh root\@$csgIP "killall info.sh;mv info.log.temp info.log.$caseName;dmesg >$caseName.dmesg.TXT"
	ssh root\@$csgIP "killall test.pl;/root/logSysVitals.pl -d /root/all_result/ -g $pngTime"
	ssh root\@$csgIP "gzip info.log.* "
	
	echo "moving core files if exist."
	ssh root\@$csgIP "mv /opt/CPSecure/CPWall/core* /root "
	
	echo "moving $caseName result files to $caseDir"
	scp root\@$csgIP:/root/*.png $caseDir/png
	scp root\@$csgIP:/root/$caseName.*.TXT $caseDir
	scp root\@$csgIP:/root/info.log.* $caseDir
	scp root\@$csgIP:/root/httpctl.* $caseDir
	scp root\@$csgIP:/opt/CPSecure/CPWall/conf/cpwall.conf $caseDir
	scp root\@$csgIP:/opt/snort_inline/conf/* $caseDir
	scp root\@$csgIP:/opt/CPSecure/CPWall/log/errlog* $caseDir
	
	scp root\@$clientIP:/root/http $caseDir/root.http.$clientIP
	scp root\@$clientIP:/root/https $caseDir/root.https.$clientIP
	scp root\@$clientIP:/root/smtp $caseDir/root.smtp.$clientIP
	scp root\@$serverIP:/root/smtp $caseDir/root.smtp.$serverIP
	
	echo "remove needn't files of /root/ in csg $csgIP"
	ssh root\@$csgIP "rm -rf info.log.* all_result httpctl.* *.png $caseName.*"
	scp "$caseDir/cpwall.conf.1.original" root\@$csgIP:/opt/CPSecure/CPWall/conf/cpwall.conf
	ssh root\@$csgIP "cd /opt/CPSecure/CPWall/conf/;chown cpwall.cpwall cpwall.conf;"
	
	echo "benchmark test $caseName finished."
}

function FinishTest()
{
	echo "The Whole Test Finished. moving errlogs to $logDir"
	scp root\@$csgIP:/opt/CPSecure/CPWall/log/errlog* $logDir
	scp root\@$csgIP:/opt/CPSecure/CPWall/conf/cpwall.conf $logDir
	
	scp -r root\@$csgIP:/opt/CPSecure/CPWall/log/debug/* $debuglogDir
	gzip $debuglogDir/*
	
	FinishMstone

	# important! when run two type of cases one after another, should not use exit 0!
	exit 0;
}


function BackupResult()
{
	echo "start BackupResult..."
	ssh root\@$csgIP "echo 'nameserver 192.168.3.1' > /etc/resolv.conf"
	ssh root\@$clientIP "cd /usr/local/mstone;cp conf/smtp.wld.5k conf/smtp.wld"
	
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
	
	echo "Finish BackupResult."
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






