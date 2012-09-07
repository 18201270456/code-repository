#!/bin/bash
# auto run regular benchmark test
# When user press Ctrl+C then clear the environment


# Since $caseName and run parameters(such as $beginValue...) will change in every case,we need to run this function before every case start.
function RefreshParam()
{
	caseDir=$resultDir/$caseName
	mkdir -p "$caseDir"
	mkdir -p "$caseDir/png"

	runHTTP_K="./live_benchmark -p HTTP -S $svrIP -C $cliIP -b $beginValue -s $stepValue -m $maxValue -t $tValue -T $TValue -o /tmp/rawlog -O /tmp/rawlog -k -I /root/http"
	runHTTP_K_AVG="./live_benchmark_avg -p HTTP -S $svrIP -C $cliIP -b $beginValue -s $stepValue -m $maxValue -t $tValue -T $TValue -o /tmp/rawlog -O /tmp/rawlog -k -I /root/http -M 1"
	runHTTP_K_URLD="./live_benchmark -p HTTP -S $svrIP -C $cliIP -b $beginValue -s $stepValue -m $maxValue -t $tValue -T $TValue -o /tmp/rawlog -O /tmp/rawlog -k -I /root/http -A 1 -U cgi-bin -H ../samples/urllist.txt"
	runHTTP_NK="./live_benchmark -p HTTP -S $svrIP -C $cliIP -b $beginValue -s $stepValue -m $maxValue -t $tValue -T $TValue -o /tmp/rawlog -O /tmp/rawlog -I /root/http"
	runHTTP_PK="./live_benchmark -p HTTP -S $svrIP -C $cliIP -b $beginValue -s $stepValue -m $maxValue -t $tValue -T $TValue -o /tmp/rawlog -O /tmp/rawlog -k -P /root/http"
	runHTTP_PNK="./live_benchmark -p HTTP -S $svrIP -C $cliIP -b $beginValue -s $stepValue -m $maxValue -t $tValue -T $TValue -o /tmp/rawlog -O /tmp/rawlog -P /root/http"
	runHTTPS_K="./live_benchmark -p HTTPS -S $svrIP -C $cliIP -b $beginValue -s $stepValue -m $maxValue -t $tValue -T $TValue -o /tmp/rawlog -O /tmp/rawlog -I /root/https -K ../demoCA/server.key -c ../demoCA/server.crt -k"
	runHTTPS_NK="./live_benchmark -p HTTPS -S $svrIP -C $cliIP -b $beginValue -s $stepValue -m $maxValue -t $tValue -T $TValue -o /tmp/rawlog -O /tmp/rawlog -I /root/https -K ../demoCA/server.key -c ../demoCA/server.crt"
	runSMTP="./live_benchmark -p SMTP -S $svrIP -C $cliIP -b $beginValue -s $stepValue -m $maxValue -t $tValue -T $TValue -o /tmp/rawlog -O /tmp/rawlog -I /root/smtp"
#	runSMTP_M="./live_benchmark -p SMTP -S $cliIP -C $svrIP -b $beginValue -s $stepValue -m $maxValue -t $tValue -T $TValue -o /tmp/rawlog -O /tmp/rawlog -I /root/smtp"
}

function RunBenchmark()
{
	echo "InitialEnv..."
	InitialEnv

	#echo "stop here!!!"
	#sleep 3000
	cycValue=1
	iterationValue=$2
	if [ "$iterationValue" = "" ];then
		iterationValue=1
	fi

	case $1 in
		HTTP_K)
			echo "start to run HTTP Keep Alive Test	=> $caseName [iterationValue=$iterationValue]"
			while (($cycValue<=$iterationValue));do
				echo "cycValue=$cycValue, iterationValue=$iterationValue"
				ssh root\@$clientIP "cd /opt/CPSecure/CPBenchmark/bin;$runHTTP_K;cat result.http > result.http.$cycValue"
				echo "cycValue=$cycValue, iterationValue=$iterationValue"
				cycValue=$(($cycValue+1))
			done

        		echo "run finished, saving results..."
        		scp root\@$clientIP:/opt/CPSecure/CPBenchmark/bin/result.http.* $caseDir
#        		echo "" >> $caseDir/result.http.*
        		cat $caseDir/result.http.*  >> $resultDir/$caseName.TXT
		;;
		HTTP_K_GZ)
			echo "start to run HTTP Keep Alive Test	GZip=> $caseName [iterationValue=$iterationValue]"
			while (($cycValue<=$iterationValue));do
				echo "cycValue=$cycValue, iterationValue=$iterationValue"
				ssh root\@$clientIP "cd /opt/GZTEST/CPBenchmark/bin;$runHTTP_K;cp result.http result.http.$cycValue"
				cycValue=$(($cycValue+1))
			done

        		echo "run finished, saving results..."
        		scp root\@$clientIP:/opt/GZTEST/CPBenchmark/bin/result.http.* $caseDir
#        		echo "" >> $caseDir/result.http.*
        		cat $caseDir/result.http.*  >> $resultDir/$caseName.TXT
		;;
		HTTP_K_AVG)
			echo "start to run HTTP Keep Alive Test	AVG=> $caseName [iterationValue=$iterationValue]"
			while (($cycValue<=$iterationValue));do
				echo "cycValue=$cycValue, iterationValue=$iterationValue"
				ssh root\@$clientIP "cd /opt/CPSecure/CPBenchmark/bin;$runHTTP_K_AVG;cp result.http result.http.$cycValue"
				cycValue=$(($cycValue+1))
			done

        		echo "run finished, saving results..."
        		scp root\@$clientIP:/opt/CPSecure/CPBenchmark/bin/result.http.* $caseDir
        		cat $caseDir/result.http.*  >> $resultDir/$caseName.TXT
		;;
		HTTP_K_URLD)
			echo "start to run HTTP URLD Test => $caseName [iterationValue=$iterationValue]"
			while (($cycValue<=$iterationValue));do
				echo "cycValue=$cycValue, iterationValue=$iterationValue"
				ssh root\@$clientIP "cd /opt/URLDTEST/CPBenchmark/bin;cp ../samples/urllist.txt.$cycValue ../samples/urllist.txt;$runHTTP_K_URLD;cp result.http result.http.$cycValue"
			#	For Test when urllist.txt doesn't change
			#	ssh root\@$clientIP "cd /opt/URLDTEST/CPBenchmark/bin;$runHTTP_K_URLD;cp result.http result.http.$cycValue"
				beginValue=$(($beginValue+$urldConnStep))
        			maxValue=$(($maxValue+$urldConnStep))
				RefreshParam
				cycValue=$(($cycValue+1))
			done

        		echo "run finished, saving results..."
        		scp root\@$clientIP:/opt/URLDTEST/CPBenchmark/bin/result.http.* $caseDir
        		cat $caseDir/result.http.*  >> $resultDir/$caseName.TXT
		;;
		HTTP_NK)
			echo "start to run HTTP No Keep Alive Test => $caseName"
			ssh root\@$clientIP "cd /opt/CPSecure/CPBenchmark/bin;$runHTTP_NK"

        		echo "run finished, saving results..."
        		scp root\@$clientIP:/opt/CPSecure/CPBenchmark/bin/result.http $resultDir/$caseName.TXT
		;;
		HTTP_PK)
			echo "start to run HTTP Keep Alive Post Test => $caseName"
			ssh root\@$clientIP "cd /opt/CPSecure/CPBenchmark/bin;$runHTTP_PK"

        		echo "run finished, saving results..."
        		scp root\@$clientIP:/opt/CPSecure/CPBenchmark/bin/result.http $resultDir/$caseName.TXT
		;;
		HTTP_PNK)
			echo "start to run HTTP No Keep Alive Post Test => $caseName"
			ssh root\@$clientIP "cd /opt/CPSecure/CPBenchmark/bin;$runHTTP_PNK"

        		echo "run finished, saving results..."
        		scp root\@$clientIP:/opt/CPSecure/CPBenchmark/bin/result.http $resultDir/$caseName.TXT
		;;
		HTTPS_K)
			echo "start to run HTTPS Keep Alive Test => $caseName"
			ssh root\@$clientIP "cd /opt/CPSecure/CPBenchmark/bin;$runHTTPS_K"

        		echo "run finished, saving results..."
        		scp root\@$clientIP:/opt/CPSecure/CPBenchmark/bin/result.https $resultDir/$caseName.TXT
		;;
		HTTPS_NK)
			echo "start to run HTTPS No Keep Alive Test => $caseName"
			ssh root\@$clientIP "cd /opt/CPSecure/CPBenchmark/bin;$runHTTPS_NK"

        		echo "run finished, saving results..."
        		scp root\@$clientIP:/opt/CPSecure/CPBenchmark/bin/result.https $resultDir/$caseName.TXT
		;;
		SMTP)
			echo "start to run SMTP Test => $caseName [iterationValue=$iterationValue]"
			while (($cycValue<=$iterationValue));do
				echo "cycValue=$cycValue, iterationValue=$iterationValue"
				ssh root\@$clientIP "cd /opt/CPSecure/CPBenchmark/bin;$runSMTP;cp result.smtp result.smtp.$cycValue"
				cycValue=$(($cycValue+1))
			done

        		echo "run finished, saving results..."
        		scp root\@$clientIP:/opt/CPSecure/CPBenchmark/bin/result.smtp.* $caseDir
        		cat $caseDir/result.smtp.*  >> $resultDir/$caseName.TXT
		;;
		HTTPSMTP)
			echo "start to run HTTPSMTP Multi Test.SMTP => $caseName"
			ssh root\@$serverIP "cd /opt/CPSecure/CPBenchmark/bin;$runSMTP_M " &

			sleep 15

			echo "start to run HTTPSMTP Multi Test.HTTP => $caseName"
			ssh root\@$clientIP "cd /opt/CPSecure/CPBenchmark/bin;$runHTTP_K_M" 


        	echo "run finished, saving results..."
       		scp root\@$clientIP:/opt/CPSecure/CPBenchmark/bin/result.http $resultDir/$caseName.HTTP.TXT

       		echo "run finished, saving results..."
       		scp root\@$serverIP:/opt/CPSecure/CPBenchmark/bin/result.smtp $resultDir/$caseName.SMTP.TXT
		;;
		*)
			echo "error! your RunBenchmark $1 parameter is error!"
			echo "caseName=$caseName"
			exit 0
		;;
	esac
	
	cycValue=1
	BackupResult
	
	FinishCase
}

function RunBreak()
{
	echo "run break..."
	
	echo "KillServices"
	KillServices
	
	echo "BackupResult"
	BackupResult
	
	echo "FinishCase"
	FinishCase
	
	echo "FinishTest"
	FinishTest
	
	echo "finish break"
}

function GetRunTime()
{
	startTimeS=`date -d "$startTime" +%s`
	stopTimeS=`date -d "$stopTime" +%s`
	pngTime=$(( (((stopTimeS-startTimeS)/60)+3) ))
	pngTime="$pngTime"m
}

function InitialEnv()
{
	RefreshParam
	
	BeforeReboot
	RebootEnv
	AfterReboot
}


function KillServices()
{
	ssh root\@$serverIP "killall -9 HTTPServer;killall -9 SMTPServer"
	ssh root\@$clientIP "killall -9 HTTPServer;killall -9 SMTPServer"
	ssh root\@$serverIP "killall -9 HTTPClient;killall -9 SMTPClient"
	ssh root\@$clientIP "killall -9 HTTPClient;killall -9 SMTPClient"
	ssh root\@$clientIP "killall -9 mailclient"
	echo "kill services"

}

