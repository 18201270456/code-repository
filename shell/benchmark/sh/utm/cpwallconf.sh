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
	lastLine=`grep -n "</CpWallConfig>" $confOri`
	lastLine=${lastLine%%:*}
}

# changeItem $httpSt $httpEd $confOri $confMid $itemName $itemAttr $itemAttrValue
# changeItem $httpSt $httpEd $confOri tt "<VirusScan" "Streaming" "true"
function changeItem()
{
	
	boundStart=$1
	boundEnd=$2
	
	if [ "$boundStart" = "" ];then
		boundStart=1
	fi
	if [ "$boundEnd" = "" ];then
		boundEnd=$lastLine
	fi
	
	boundAll=$(($boundEnd-$boundStart))
	fileIn=$3
	fileOut=$4
	itemName=$5
	itemAttr=$6
	itemAttrValue=$7
	
	# get the target line number, according to $itemName #
	targetLine=`head -$boundEnd $fileIn | tail -$boundAll | grep -n "$itemName"` 
	targetLine=${targetLine%%:*}
	targetLine=$(($targetLine+$boundStart))
	
	sed -e $targetLine's/'$itemAttr'="[^"]*"/'$itemAttr'="'$itemAttrValue'"/g' $fileIn > $fileOut
	
	# !! ## the copy comand is very important here. changes the original file."
#	diff $fileOut $fileIn
	cp $fileOut $fileIn
}



function DoConf()
{
	echo "DoConf $1"
	
	case $1 in
		http_sse_nostream)
			changeItem $httpSt $httpEd $confChg $confMid "<ScanFile" "HtmlScanEngine" "STREAMING"
		;;
		http_trad_nostream)
			changeItem $httpSt $httpEd $confChg $confMid "<ScanFile" "HtmlScanEngine" "TRADITION"
		;;
		http_sse_stream)
			changeItem $httpSt $httpEd $confChg $confMid "<VirusScan" "Streaming" "true"
			changeItem $httpSt $httpEd $confChg $confMid "<ScanFile" "HtmlScanEngine" "STREAMING"
		;;
		http_trad_stream)
			changeItem $httpSt $httpEd $confChg $confMid "<VirusScan" "Streaming" "true"
			changeItem $httpSt $httpEd $confChg $confMid "<ScanFile" "HtmlScanEngine" "TRADITION"
		;;
		http_skip)
			changeItem $httpSt $httpEd $confChg $confMid "<ScanFile" "HtmlScanEngine" "SKIP"
		;;
		http_block_js)
			changeItem $httpSt $httpEd $confChg $confMid "<BlockObject" "Enabled" "true"
			changeItem $httpSt $httpEd $confChg $confMid "<BlockJS" "Enabled" "true"
		;;
		http_urld_qkck_t)
			changeItem $httpSt $httpEd $confChg $confMid "<UrlCategory" "Enabled" "true"
			changeItem $httpSt $httpEd $confChg $confMid "<UrlCategory" "QuickCheck" "true"
		;;
		http_urld_qkck_f)
			changeItem $httpSt $httpEd $confChg $confMid "<UrlCategory" "Enabled" "true"
			changeItem $httpSt $httpEd $confChg $confMid "<UrlCategory" "QuickCheck" "false"
		;;
		http_trfc)
			changeItem $httpSt $httpEd $confChg $confMid "<ScanFile" "HtmlScanEngine" "STREAMING"
			ssh root\@$csgIP "cd /opt/CPSecure/Eventd/conf;sed -e '1,30s/Service HTTP=\"false\"/Service HTTP=\"true\"/g' eventd.conf > b; cp b eventd.conf;chmod 666 *"
		;;
		https_nostream)
			changeItem $httpsSt $httpsEd $confChg $confMid "<Security" "Notrusted" "true"
		;;
		smtp_delete)
			changeItem $smtpSt $smtpEd $confChg $confMid "<VirusScan" "FirstAction" "Delete"
		;;
		smtp_antispam)
			changeItem $smtpSt $smtpEd $confChg $confMid "<SpamScan" "Enabled" "true"
			changeItem $smtpSt $smtpEd $confChg $confMid "<SpamScan" "Action" "AddTag"
		;;
		smtp_cmth_tag)
			changeItem $smtpSt $smtpEd $confChg $confMid "<SpamScan" "Enabled" "true"
			changeItem $smtpSt $smtpEd $confChg $confMid "<SpamScan" "Action" "AddTag"
		;;
		smtp_rbl)
			changeItem $smtpSt $smtpEd $confChg $confMid "<SpamACL" "Enabled" "true"
		;;
		pop3_cmth_tag)
			changeItem $pop3St $pop3Ed $confChg $confMid "<SpamScan" "Enabled" "true"
			changeItem $pop3St $pop3Ed $confChg $confMid "<SpamScan" "Action" "AddTag"
		;;
		*)
			echo "WARNING: [$1] is Error!"
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
			changeItem "" "" $confChg $confMid "<Services " "${svsName}Enabled" "true"
		;;
		ALL)
			changeItem "" "" $confChg $confMid "<Services " "HTTPEnabled" "true"
			changeItem "" "" $confChg $confMid "<Services " "SMTPEnabled" "true"
			changeItem "" "" $confChg $confMid "<Services " "HTTPSEnabled" "true"
			changeItem "" "" $confChg $confMid "<Services " "IMAPEnabled" "true"
			changeItem "" "" $confChg $confMid "<Services " "POP3Enabled" "true"
			changeItem "" "" $confChg $confMid "<Services " "FTPEnabled" "true"
		;;
		NONE)
			echo "NONE Services Would Be Started"
		;;
		*)
			echo "WARNING: [$1] type is error."
		;;
	esac
	
	cp  $confChg $confMid
	
}

function IniCPWallServices()
{
	changeItem "" "" $confChg $confMid "<Services " "HTTPEnabled" "false"
	changeItem "" "" $confChg $confMid "<Services " "SMTPEnabled" "false"
	changeItem "" "" $confChg $confMid "<Services " "HTTPSEnabled" "false"
	changeItem "" "" $confChg $confMid "<Services " "IMAPEnabled" "false"
	changeItem "" "" $confChg $confMid "<Services " "POP3Enabled" "false"
	changeItem "" "" $confChg $confMid "<Services " "FTPEnabled" "false"
	
	
	changeItem $httpSt $httpEd $confChg $confMid "<VirusScan" "Streaming" "false"
	changeItem $httpSt $httpEd $confChg $confMid "<VirusScan" "FirstAction" "Delete"
	changeItem $httpSt $httpEd $confChg $confMid "<ScanFile" "HtmlScanEngine" "STREAMING"
	changeItem $httpSt $httpEd $confChg $confMid "<BlockFileType" "Enabled" "false"
	changeItem $httpSt $httpEd $confChg $confMid "<BlockObject" "Enabled" "false"
	changeItem $httpSt $httpEd $confChg $confMid "<BlockJS" "Enabled" "false"
	changeItem $httpSt $httpEd $confChg $confMid "<SizeLimit" "Value" "10240"
	
	changeItem $httpsSt $httpsEd $confChg $confMid "<VirusScan" "Streaming" "false"
	changeItem $httpsSt $httpsEd $confChg $confMid "<ScanFile" "HtmlScanEngine" "STREAMING"
	changeItem $httpsSt $httpsEd $confChg $confMid "<Security" "Notrusted" "true"
	
	changeItem $smtpSt $smtpEd $confChg $confMid "<SpamScan" "Action" "AddTag"
	changeItem $smtpSt $smtpEd $confChg $confMid "<SpamScan" "Enabled" "false"
	changeItem $smtpSt $smtpEd $confChg $confMid "<VirusScan" "FirstAction" "Delete"
	changeItem $smtpSt $smtpEd $confChg $confMid "<SpamACL" "Enabled" "false"
	
	changeItem $pop3St $pop3Ed $confChg $confMid "<SpamScan" "Action" "AddTag"
	changeItem $pop3St $pop3Ed $confChg $confMid "<SpamScan" "Enabled" "false"
	changeItem $pop3St $pop3Ed $confChg $confMid "<VirusScan" "FirstAction" "Delete"
	
	changeItem $imapSt $imapEd $confChg $confMid "<VirusScan" "FirstAction" "Delete"
	
	changeItem $ftpSt $ftpEd $confChg $confMid "<VirusScan" "FirstAction" "Delete"
}

# need variable $caseDir before run this function.
function ConfCPWall()
{
	RefreshParam
	csgIP=$1
	csgConf="../../pro/utm25/backup/cpwall.conf"
	
	# for test #
#	csgConf="./tmp/cpwall.conf"
	
	confOri="$caseDir/cpwall.conf.1.original"
	confMid="$caseDir/cpwall.conf.2.middle"
	confChg="$caseDir/cpwall.conf.3.changed"
	
	echo "caseDir=$caseDir"
	echo "$1,$2,$3,$4,$5"
	cp $csgConf $confOri
	cp $confOri $confMid
	cp $confOri $confChg
	
	GetLines
	IniCPWallServices
	DoConf $2
	
	while [ "$3" != "" ]
	do
		ChangeService $3
		shift
	done 
	
#	when test this script, mark the next lines.
	scp $confChg root\@$csgIP:/opt/CPSecure/CPWall/conf/cpwall.conf
	ssh root\@$csgIP "cd /opt/CPSecure/CPWall/conf/;chown cpwall.cpwall cpwall.conf;/etc/init.d/cpwalld restart"
#	ssh root\@$csgIP "cd /opt/CPSecure/CPWall/conf/;chown cpwall.cpwall cpwall.conf;/opt/CPSecure/CPWall/bin/CPWallService all start core;/opt/CPSecure/CPWall/bin/checkRegister.pl 1"
	
	diff $confOri $confChg > $caseDir/diff.TXT
	cat $caseDir/diff.TXT
	
	echo "$csgIP"
	echo "$1,$2,$3,$4,$5"
}


# for test #
#caseDir="./tmp"
#ConfCPWall $1 $2 $3 $4 $5 $6 $7 $8
#ConfCPWall "192.168.35.183" http_sse_nostream HTTP POP3















