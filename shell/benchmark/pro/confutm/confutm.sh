#!/bin/bash
#./confutm.sh $csgIP http_sse_nostream http smtp pop3
#./confutm.sh $csgIP http_sse_nostream http


function GetLines()
{
	httpSt=`grep -n "<HTTP " $confOri`
	httpSt=${httpSt%%:*}
	httpEd=`grep -n "</HTTP>" $confOri`
	httpEd=${httpEd%%:*}
	ftpSt=`grep -n "<FTP " $confOri`
	ftpSt=${ftpSt%%:*}
	ftpEd=`grep -n "</FTP>" $confOri`
	ftpEd=${ftpEd%%:*}
	smtpSt=`grep -n "<SMTP " $confOri`
	smtpSt=${smtpSt%%:*}
	smtpEd=`grep -n "</SMTP>" $confOri`
	smtpEd=${smtpEd%%:*}
	imapSt=`grep -n "<IMAP " $confOri`
	imapSt=${imapSt%%:*}
	imapEd=`grep -n "</IMAP>" $confOri`
	imapEd=${imapEd%%:*}
	httpsSt=`grep -n "<HTTPS " $confOri`
	httpsSt=${httpsSt%%:*}
	httpsEd=`grep -n "</HTTPS>" $confOri`
	httpsEd=${httpsEd%%:*}
	pop3St=`grep -n "<POP3 " $confOri`
	pop3St=${pop3St%%:*}
	pop3Ed=`grep -n "</POP3>" $confOri`
	pop3Ed=${pop3Ed%%:*}
}

function DoConf()
{
	echo "DoConf $1"

#	default conf:
	sed -e $httpSt,$httpEd's/ HtmlScanEngine="[^"]*"/ HtmlScanEngine="STREAMING"/g' $confMid | sed -e $httpSt,$httpEd's/FirstAction="[^"]*"/FirstAction="Delete"/g' | sed -e $httpSt,$httpEd's/Streaming="[^"]*"/Streaming="false"/g' | sed -e $httpSt,$httpEd's/BlockFileType Enabled="[^"]*"/BlockFileType Enabled="false"/g' | sed -e $httpSt,$httpEd's/BlockObject Enabled="[^"]*"/BlockObject Enabled="false"/g' | sed -e $httpSt,$httpEd's/BlockJS Enabled="[^"]*"/BlockJS Enabled="false"/g' > $confChg
	cp  $confChg $confMid
	sed -e $smtpSt,$smtpEd's/SpamScan Action="[^"]*"/SpamScan Action="AddTag"/g' $confMid | sed -e $smtpSt,$smtpEd's/ FirstAction="[^"]*"/ FirstAction="Delete"/g' | sed -e $smtpSt,$smtpEd's/ Enabled="[^"]*" HeaderTag="X-NETGEAR-SPAM"/ Enabled="false" HeaderTag="X-NETGEAR-SPAM"/g' > $confChg
	case $1 in
		http_sse_nostream)
			sed -e $httpSt,$httpEd's/ HtmlScanEngine="[^"]*"/ HtmlScanEngine="STREAMING"/g' $confMid | sed -e $httpSt,$httpEd's/FirstAction="[^"]*"/FirstAction="Delete"/g' | sed -e $httpSt,$httpEd's/Streaming="[^"]*"/Streaming="false"/g' > $confChg
		;;
		http_kav_nostream)
			sed -e $httpSt,$httpEd's/ HtmlScanEngine="[^"]*"/ HtmlScanEngine="TRADITION"/g' $confMid | sed -e $httpSt,$httpEd's/FirstAction="[^"]*"/FirstAction="Delete"/g' | sed -e $httpSt,$httpEd's/Streaming="[^"]*"/Streaming="false"/g' > $confChg
		;;
		http_sse_stream)
			sed -e $httpSt,$httpEd's/ HtmlScanEngine="[^"]*"/ HtmlScanEngine="STREAMING"/g' $confMid | sed -e $httpSt,$httpEd's/FirstAction="[^"]*"/FirstAction="Delete"/g' | sed -e $httpSt,$httpEd's/Streaming="[^"]*"/Streaming="true"/g' > $confChg
		;;
		http_kav_stream)
			sed -e $httpSt,$httpEd's/ HtmlScanEngine="[^"]*"/ HtmlScanEngine="TRADITION"/g' $confMid | sed -e $httpSt,$httpEd's/FirstAction="[^"]*"/FirstAction="Delete"/g' | sed -e $httpSt,$httpEd's/Streaming="[^"]*"/Streaming="true"/g' > $confChg
		;;
		http_skip)
			sed -e $httpSt,$httpEd's/ HtmlScanEngine="[^"]*"/ HtmlScanEngine="SKIP"/g' $confMid | sed -e $httpSt,$httpEd's/FirstAction="[^"]*"/FirstAction="Delete"/g' | sed -e $httpSt,$httpEd's/Streaming="[^"]*"/Streaming="false"/g' > $confChg
		;;
		http_block)
			sed -e $httpSt,$httpEd's/ HtmlScanEngine="[^"]*"/ HtmlScanEngine="STREAMING"/g' $confMid | sed -e $httpSt,$httpEd's/FirstAction="[^"]*"/FirstAction="Delete"/g' | sed -e $httpSt,$httpEd's/Streaming="[^"]*"/Streaming="false"/g' | sed -e $httpSt,$httpEd's/BlockFileType Enabled="[^"]*"/BlockFileType Enabled="true"/g' | sed -e $httpSt,$httpEd's/BlockObject Enabled="[^"]*"/BlockObject Enabled="true"/g'> $confChg
		;;
		http_block_js)
			sed -e $httpSt,$httpEd's/ HtmlScanEngine="[^"]*"/ HtmlScanEngine="STREAMING"/g' $confMid | sed -e $httpSt,$httpEd's/FirstAction="[^"]*"/FirstAction="Delete"/g' | sed -e $httpSt,$httpEd's/Streaming="[^"]*"/Streaming="false"/g' | sed -e $httpSt,$httpEd's/BlockJS Enabled="[^"]*"/BlockJS Enabled="true"/g' > $confChg
		;;
		https_nostream)
			sed -e $httpsSt,$httpsEd's/ HtmlScanEngine="[^"]*"/ HtmlScanEngine="STREAMING"/g' $confMid | sed -e $httpsSt,$httpsEd's/FirstAction="[^"]*"/FirstAction="Delete"/g' | sed -e $httpsSt,$httpsEd's/Streaming="[^"]*"/Streaming="false"/g' | sed -e $httpsSt,$httpsEd's/Notrusted="[^"]*"/Notrusted="true"/g' > $confChg
		;;
		smtp_delete)
			sed -e $smtpSt,$smtpEd's/ FirstAction="[^"]*"/ FirstAction="Delete"/g' $confMid > $confChg
		;;
		smtp_antispam)
			sed -e $smtpSt,$smtpEd's/SpamScan Action="[^"]*"/SpamScan Action="AddTag"/g' $confMid | sed -e $smtpSt,$smtpEd's/ Enabled="[^"]*" HeaderTag="X-NETGEAR-SPAM"/ Enabled="true" HeaderTag="X-NETGEAR-SPAM"/g' > $confChg
		;;
		smtp_cmth_tag)
			sed -e $smtpSt,$smtpEd's/SpamScan Action="[^"]*"/SpamScan Action="AddTag"/g' $confMid | sed -e $smtpSt,$smtpEd's/ Enabled="[^"]*" HeaderTag="X-NETGEAR-SPAM"/ Enabled="true" HeaderTag="X-NETGEAR-SPAM"/g' > $confChg
		;;
		smtp_cmth_block)
			sed -e $smtpSt,$smtpEd's/SpamScan Action="[^"]*"/SpamScan Action="Block"/g' $confMid | sed -e $smtpSt,$smtpEd's/ Enabled="[^"]*" HeaderTag="X-NETGEAR-SPAM"/ Enabled="true" HeaderTag="X-NETGEAR-SPAM"/g' > $confChg
		;;
		pop3_cmth_tag)
			sed -e $pop3St,$pop3Ed's/SpamScan Action="[^"]*"/SpamScan Action="AddTag"/g' $confMid | sed -e $pop3St,$pop3Ed's/ FirstAction="[^"]*"/ FirstAction="Delete"/g' | sed -e $pop3St,$pop3Ed's/ Enabled="[^"]*" HeaderTag="X-NETGEAR-SPAM"/ Enabled="true" HeaderTag="X-NETGEAR-SPAM"/g' > $confChg
		;;
		*)
			echo "[$1] is Error!"
		;;
	esac

	cp  $confChg $confMid
}

function ChangeService()
{
	svsName=`echo $1 | tr a-z A-Z`
	echo "svsName=$svsName"
	case $svsName in
		HTTP|SMTP|IMAP|HTTPS|POP3|FTP)
			sed -e 's/'$svsName'Enabled="[^"]*"/'$svsName'Enabled="true"/g' $confMid > $confChg
		;;
		ALL)
			sed -e 's/HTTPEnabled="[^"]*"/HTTPEnabled="true"/g' $confMid | sed -e 's/HTTPSEnabled="[^"]*"/HTTPSEnabled="true"/g' |sed -e 's/SMTPEnabled="[^"]*"/SMTPEnabled="true"/g' | sed -e 's/FTPEnabled="[^"]*"/FTPEnabled="true"/g' | sed -e 's/IMAPEnabled="[^"]*"/IMAPEnabled="true"/g' | sed -e 's/POP3Enabled="[^"]*"/POP3Enabled="true"/g'> $confChg
		;;
		*)
			echo "$1 type is error."
		;;
	esac
	
	cp  $confChg $confMid
	
}

function IniCPWallServices()
{
	sed -e 's/HTTPEnabled="[^"]*"/HTTPEnabled="false"/g' $confMid | sed -e 's/HTTPSEnabled="[^"]*"/HTTPSEnabled="false"/g' |sed -e 's/SMTPEnabled="[^"]*"/SMTPEnabled="false"/g' | sed -e 's/FTPEnabled="[^"]*"/FTPEnabled="false"/g' | sed -e 's/IMAPEnabled="[^"]*"/IMAPEnabled="false"/g' | sed -e 's/POP3Enabled="[^"]*"/POP3Enabled="false"/g' > $confChg
	cp  $confChg $confMid
}


function ConfCPWall()
{
	csgIP=$1
	csgConf="$csgIP:/opt/CPSecure/CPWall/conf/cpwall.conf"
	confOri="$caseDir/cpwall.conf.1.original"
	confMid="$caseDir/cpwall.conf.2.middle"
	confChg="$caseDir/cpwall.conf.3.changed"
	
	# test data
	csgIP="192.168.35.254"
	csgConf="$csgIP:/root/benchtest/pro/confutm/cpwall.conf"
	caseDir="/root/benchtest/pro/confutm"
	
	echo "caseDir=$caseDir"
	echo "$1,$2,$3,$4,$5"
	scp $csgConf $confOri
	cp  $confOri $confMid

	GetLines
	IniCPWallServices
	DoConf $2
	
	while [ "$3" != "" ]
	do
		ChangeService $3
		shift
	done 
	
	#scp $confChg root\@$csgIP:/opt/CPSecure/CPWall/conf/cpwall.conf
	#ssh root\@$csgIP "/etc/init.d/cpwalld restart"
	diff $confOri $confChg > $caseDir/diff.TXT
	cat $caseDir/diff.TXT
	
	echo "$csgIP"
	echo "$1,$2,$3,$4,$5"
}


ConfCPWall $1 $2 $3 $4 $5 $6















