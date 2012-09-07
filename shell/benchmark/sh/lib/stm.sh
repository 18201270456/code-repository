#!/bin/bash
# auto run regular benchmark test
# When user press Ctrl+C then clear the environment

function STM_HTTP_S01C01()
{
	curTime=`date +"%Y%m%d%H%M%S"`
	caseName="HTTP.S01C01.SSE.NoS.SimplePic.$curTime"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/simple-151k.html:1 >/root/http"
	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/pic-37k.jpg:2 >>/root/http"
	
	ConfCPWall $csgIP http_sse_nostream HTTP
	RunBenchmark "HTTP_K"
}

function STM_HTTP_S01C02()
{
	curTime=`date +"%Y%m%d%H%M%S"`
	caseName="HTTP.S01C02.SKIP.NoS.SimplePic.$curTime"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/simple-151k.html:1 >/root/http"
	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/pic-37k.jpg:2 >>/root/http"
	
	ConfCPWall $csgIP http_skip HTTP
	RunBenchmark "HTTP_K"
}

function STM_HTTP_S01C03()
{
	curTime=`date +"%Y%m%d%H%M%S"`
	caseName="HTTP.S01C03.SSE.NoS.ComplexPic.$curTime"

	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/complex-151k.html:1 >/root/http"
	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/pic-37k.jpg:2 >>/root/http"
	
	ConfCPWall $csgIP http_sse_nostream HTTP
	RunBenchmark "HTTP_K"
}

function STM_HTTP_S01C04()
{
	caseName="HTTP.S01C04.SSE.NoS.ComplexPic.QRT"
	
	SetStepValue $1 $2 $3 $4 $5
	
	SetStepValue $1 $2 $3 $4 $5
	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/simple-151k.html:1 >/root/http"
	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/pic-37k.jpg:2 >>/root/http"
	
	ConfCPWall $csgIP http_sse_nos_qrt HTTP
	RunBenchmark "HTTP_K"
}

function STM_HTTP_S01C05()
{
	caseName="HTTP.S01C05.SSE.NoS.SimplePic.BlockApp"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/simple-151k.html:1 >/root/http"
	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/pic-37k.jpg:2 >>/root/http"
	ssh root\@$csgIP  "cd /opt/snort_inline/conf;sed -e s/allow/block/g ips.conf > ips.conf.block;cp ips.conf.block ips.conf"
	
	ConfCPWall $csgIP http_sse_nostream HTTP
	RunBenchmark "HTTP_K"
	
	ssh root\@$csgIP  "cd /opt/snort_inline/conf;sed -e s/block/allow/g ips.conf > ips.conf.allow;cp ips.conf.allow ips.conf"
}

function STM_HTTP_S01C06()
{
	caseName="HTTP.S01C06.SSE.NoS.K.Post.Perform.Simple151K"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/sample-index.html:1:/opt/CPSecure/CPBenchmark/samples/sample-index.html >/root/http"
	
	ConfCPWall $csgIP http_sse_nostream HTTP
	RunBenchmark "HTTP_PK"
}



function STM_HTTP_S02C01()
{
	caseName="HTTP.S02C01.SSE.NoS.Simple151K"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/simple-151k.html:1 >/root/http"
	
	ConfCPWall $csgIP http_sse_nostream HTTP
	RunBenchmark "HTTP_K"
}

function STM_HTTP_S02C02()
{
	caseName="HTTP.S02C02.SSE.S.Simple151K"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/simple-151k.html:1 >/root/http"
	
	ConfCPWall $csgIP http_sse_stream HTTP
	RunBenchmark "HTTP_K"
}

function STM_HTTP_S02C03()
{
	caseName="HTTP.S02C03.TRAD.NoS.Simple151K"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/simple-151k.test:1 >/root/http"
	
#	ConfCPWall $csgIP http_trad_nostream HTTP
	ConfCPWall $csgIP http_sse_nostream HTTP
	RunBenchmark "HTTP_K"
}

function STM_HTTP_S02C04()
{
	caseName="HTTP.S02C04.TRAD.S.Simple151K"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/simple-151k.test:1 >/root/http"
	
#	ConfCPWall $csgIP http_trad_stream HTTP
	ConfCPWall $csgIP http_sse_stream HTTP
	RunBenchmark "HTTP_K"
}

function STM_HTTP_S02C05()
{
	caseName="HTTP.S02C01.SSE.NoS.ForCore.Simple151K"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/simple-151k.html:1 >/root/http"
	
	ConfCPWall $csgIP http_sse_nostream HTTP
	RunBenchmark "HTTP_K"
}


function STM_HTTP_S03C01()
{
	caseName="HTTP.S02C10.SSE.NoS.Simple151KGZ"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/simple-151k.html.gz:1 >/root/http"
	
	ConfCPWall $csgIP http_sse_nostream HTTP
	RunBenchmark "HTTP_K_GZ"
}

function STM_HTTP_S04C01()
{
	caseName="HTTP.S04C01.SSE.NoS.K.Post.Simple151K"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/sample-index.html:1:/opt/CPSecure/CPBenchmark/samples/sample-index.html >/root/http"
	
	ConfCPWall $csgIP http_sse_nostream HTTP
	RunBenchmark "HTTP_PK"
}

function STM_HTTP_S04C02()
{
	caseName="HTTP.S04C02.SSE.NoS.NoK.Post.Simple151K"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/sample-index.html:1:/opt/CPSecure/CPBenchmark/samples/sample-index.html >/root/http"
	
	ConfCPWall $csgIP http_sse_nostream HTTP
	RunBenchmark "HTTP_PNK"
}

function STM_HTTP_S05C01()
{
	caseName="HTTP.S05C01.SSE.NoS.JS"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/tudou.html:1 >/root/http"
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/minijuegos.html:1 >>/root/http"
	
	ConfCPWall $csgIP http_block_js HTTP
	RunBenchmark "HTTP_K"
}

function STM_HTTP_S06C01()
{
	caseName="HTTP.S06C01.SSE.NoS.Mix.Stress"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP  "cat /root/httpstress > /root/http"
	
	ConfCPWall $csgIP http_sse_nostream HTTP
	RunBenchmark "HTTP_K"
}

function STM_HTTP_S06C02()
{
	caseName="HTTP.S06C02.SSE.NoS.Mix.Spike"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP  "cat /root/httpstress > /root/http"
	
	ConfCPWall $csgIP http_sse_nostream HTTP
	RunBenchmark "HTTP_K" 3
}

function STM_HTTP_S06C03()
{
	caseName="HTTP.S06C03.SSE.NoS.Virus"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/netlengendtestvirus.zip:1 >/root/http"
	
	ConfCPWall $csgIP http_sse_nostream HTTP
	RunBenchmark "HTTP_K" 
}

function STM_HTTP_S06C04()
{
	caseName="HTTP.S06C04.SSE.NoS.Virus.Quarantine"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/netlengendtestvirus.zip:1 >/root/http"
	
	ConfCPWall $csgIP http_sse_nos_qrt HTTP
	RunBenchmark "HTTP_K"
}

function STM_HTTP_S07C01()
{
	caseName="HTTP.S07C01.SSE.NoS.BigFile.1M"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/google.exe:1 >/root/http"
	
	ConfCPWall $csgIP http_sse_nostream HTTP
	RunBenchmark "HTTP_K"
}

function STM_HTTP_S07C02()
{
	caseName="HTTP.S07C02.SSE.NoS.BigFile.8M"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/linux.rar:1 >/root/http"
	
	ConfCPWall $csgIP http_sse_nostream HTTP
	RunBenchmark "HTTP_K"
}

function STM_HTTP_S08C01()
{
	caseName="HTTP.S08C01.SSE.NoS.URLD.SimplePic.F"
	
	SetStepValue $1 $2 $3 $4 $5
	
	urldConnStart=$1
	urldConnStep=$2
	urldIteNum=`expr $1 / $3`
	
	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/simple-151k.html:1 >/root/http"
	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/pic-37k.jpg:2 >>/root/http"
	
	ssh root\@$csgIP "/etc/init.d/urld stop;rm /opt/urld/data/cache_file;/etc/init.d/urld start"
	ssh root\@$csgIP "cd /opt/CPSecure/webui/common/conf;cp block_sites.db.AllowAll block_sites.db;chown cpwall.cpwall *"
	
	ConfCPWall $csgIP http_urld_qkck_f HTTP
	RunBenchmark "HTTP_K_URLD" $urldIteNum
	
#	ssh root\@$csgIP "cd /opt/CPSecure/webui/common/conf;cp block_sites.db.AllowAll block_sites.db;chown cpwall.cpwall *"
}

function STM_HTTP_S08C02()
{
	caseName="HTTP.S08C02.SSE.NoS.URLD.SimplePic.T"
	
	SetStepValue $1 $2 $3 $4 $5
	
	urldConnStart=$1
	urldConnStep=$2
	urldIteNum=`expr $1 / $3`
	
	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/simple-151k.html:1 >/root/http"
	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/pic-37k.jpg:2 >>/root/http"
	
	ssh root\@$csgIP "/etc/init.d/urld stop;rm /opt/urld/data/cache_file;/etc/init.d/urld start"
	ssh root\@$csgIP "cd /opt/CPSecure/webui/common/conf;cp block_sites.db.AllowAll block_sites.db;chown cpwall.cpwall *"
	
	ConfCPWall $csgIP http_urld_qkck_t HTTP
	RunBenchmark "HTTP_K_URLD" $urldIteNum
	
#	ssh root\@$csgIP "cd /opt/CPSecure/webui/common/conf;cp block_sites.db.Default block_sites.db;chown cpwall.cpwall *;"
}

function STM_HTTP_S09C01()
{
	curTime=`date +"%Y%m%d%H%M%S"`
	caseName="HTTP.S09C01.SMTP.6K.Perform.$curTime"
	
######## HTTP #########
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/simple-151k.html:1 >/root/http"
	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/pic-37k.jpg:2 >>/root/http"
	
	RefreshParam
	runHTTP_K_M=$runHTTP_K
	echo "$runHTTP_K_M"
	
	
######## SMTP #########
	
	tmpValue=$cliIP
	cliIP=$svrIP
	svrIP=$tmpValue
	
	SetStepValue $6 $7 $8 $9 ${10}
	
	ssh root\@$serverIP  "echo /opt/CPSecure/CPBenchmark/samples/email-6k:1 >/root/smtp"
	
	RefreshParam
	runSMTP_M=$runSMTP
	echo "$runSMTP_M"
		
	ConfCPWall $csgIP http_sse_nostream HTTP SMTP
	RunBenchmark "HTTPSMTP"
	
	tmpValue=$cliIP
	cliIP=$svrIP
	svrIP=$tmpValue
}

function STM_HTTP_S09C02()
{
	curTime=`date +"%Y%m%d%H%M%S"`
	caseName="HTTP.S09C02.SMTP.43K.Perform.$curTime"
	
######## HTTP #########
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/simple-151k.html:1 >/root/http"
	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/pic-37k.jpg:2 >>/root/http"
	
	RefreshParam
	runHTTP_K_M=$runHTTP_K
	
	
######## SMTP #########
	
	tmpValue=$cliIP
	cliIP=$svrIP
	svrIP=$tmpValue
	
	SetStepValue $6 $7 $8 $9 ${10}
	
	ssh root\@$serverIP  "echo /opt/CPSecure/CPBenchmark/samples/email-43k:1 >/root/smtp"
	
	RefreshParam
	runSMTP_M=$runSMTP
	
	ConfCPWall $csgIP http_sse_nostream HTTP SMTP
	RunBenchmark "HTTPSMTP"
	
	tmpValue=$cliIP
	cliIP=$svrIP
	svrIP=$tmpValue
}


function STM_HTTP_S10C01()
{
	caseName="HTTP.S10C01.SSE.NoS.Stable"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/simple-151k.html:1 >/root/http"
	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/pic-37k.jpg:2 >>/root/http"
	
	ConfCPWall $csgIP http_sse_nostream HTTP
	RunBenchmark "HTTP_K"
}


function STM_SMTP_S01C01()
{
	caseName="SMTP.S01C01.Perform.6K"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/email-6k:1 >/root/smtp"
	
	ConfCPWall $csgIP smtp_delete SMTP
	RunBenchmark "SMTP"
}

function STM_SMTP_S01C02()
{
	caseName="SMTP.S01C02.Perform.43K"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/email-43k:1 >/root/smtp"
	
	ConfCPWall $csgIP smtp_delete SMTP
	RunBenchmark "SMTP"
}

function STM_SMTP_S01C03()
{
	caseName="SMTP.S01C03.Perform.Qurantine.6K"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/email-6k:1 >/root/smtp"
	
	ConfCPWall $csgIP smtp_qrt SMTP
	RunBenchmark "SMTP"
}


function STM_SMTP_S01C04()
{
	caseName="SMTP.S01C04.AntiSpam.6K"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/email-6k:1 >/root/smtp"
	
	ConfCPWall $csgIP smtp_antispam SMTP
	RunBenchmark "SMTP"
}

function STM_SMTP_S02C01()
{
	caseName="SMTP.S02C01.Stress.6K"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/email-6k:1 >/root/smtp"
	
	ConfCPWall $csgIP smtp_delete SMTP
	RunBenchmark "SMTP"
}

function STM_SMTP_S02C02()
{
	caseName="SMTP.S02C02.Stress.43K"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/email-43k:1 >/root/smtp"
	
	ConfCPWall $csgIP smtp_delete SMTP
	RunBenchmark "SMTP"
}

function STM_SMTP_S02C03()
{
	caseName="SMTP.S02C03.Stress.1M"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/google.eml:1 > /root/smtp"
	
	ConfCPWall $csgIP smtp_delete SMTP
	RunBenchmark "SMTP"
}

function STM_SMTP_S02C04()
{
	caseName="SMTP.S02C04.Stress.AntiSpam"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/email-6k:1 > /root/smtp"
	
	ConfCPWall $csgIP smtp_antispam SMTP
	RunBenchmark "SMTP"
}


function STM_SMTP_S03C01()
{
	caseName="SMTP.S03C01.Stress.Mix"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/email-2k:10 > /root/smtp"
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/email-15k:10 >> /root/smtp"
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/email-15k-virus:1 >> /root/smtp"
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/scan.eml:1 >> /root/smtp"
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/mailvirus.eml:1 >> /root/smtp"
	
	ConfCPWall $csgIP smtp_delete SMTP
	RunBenchmark "SMTP"
}

function STM_SMTP_S03C02()
{
	caseName="SMTP.S03C02.Stable.MailVirus"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/mailvirus.eml:1 > /root/smtp"
	
	ConfCPWall $csgIP smtp_block SMTP
	RunBenchmark "SMTP" 1
}

function STM_SMTP_S03C03()
{
	caseName="SMTP.S03C03.Stable.MailVirus.QRT"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/mailvirus.eml:1 > /root/smtp"
	
	ConfCPWall $csgIP smtp_qrt SMTP
	RunBenchmark "SMTP" 1
}

function STM_SMTP_S03C04()
{
	caseName="SMTP.S03C04.Stable.HTTP"
	
######## HTTP #########
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP  "cat /root/httpstress >/root/http"
	
	RefreshParam
	runHTTP_K_M=$runHTTP_K
	
	
######## SMTP #########
	
	tmpValue=$cliIP
	cliIP=$svrIP
	svrIP=$tmpValue
	
	SetStepValue $6 $7 $8 $9 ${10}
	
	ssh root\@$serverIP  "echo /opt/CPSecure/CPBenchmark/samples/email-2k:1 >/root/smtp"
	ssh root\@$serverIP  "echo /opt/CPSecure/CPBenchmark/samples/email-15k:1 >/root/smtp"
	ssh root\@$serverIP  "echo /opt/CPSecure/CPBenchmark/samples/email-15k-virus:1 >/root/smtp"
	
	RefreshParam
	runSMTP_M=$runSMTP
		
	ConfCPWall $csgIP http_sse_nostream HTTP SMTP
	RunBenchmark "HTTPSMTP"
	
	tmpValue=$cliIP
	cliIP=$svrIP
	svrIP=$tmpValue
}

function STM_HTTP_S03C05()
{
	caseName="SMTP.S03C05.Stable.HTTP.Virus"
	
######## HTTP #########
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/netlengendtestvirus.zip:1 >/root/http"
	
	RefreshParam
	runHTTP_K_M=$runHTTP_K
	
	
######## SMTP #########
	
	tmpValue=$cliIP
	cliIP=$svrIP
	svrIP=$tmpValue
	
	SetStepValue $6 $7 $8 $9 ${10}
	
	ssh root\@$serverIP  "echo /opt/CPSecure/CPBenchmark/samples/mailvirus.eml:1 >/root/smtp"
	
	RefreshParam
	runSMTP_M=$runSMTP
		
	ConfCPWall $csgIP http_sse_nostream HTTP SMTP
	RunBenchmark "HTTPSMTP"
	
	tmpValue=$cliIP
	cliIP=$svrIP
	svrIP=$tmpValue
}

function STM_SMTP_S03C06()
{
	caseName="SMTP.S03C06.Stable.43K"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/email-43k:1 > /root/smtp"
	
	ConfCPWall $csgIP smtp_delete SMTP
	RunBenchmark "SMTP" 1
}

function STM_SMTP_S04C01()
{
	caseName="SMTP.S04C01.RBL.DSBL.Block.6K"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/email-6k:1 > /root/smtp"
	
	ssh root\@$csgIP "echo 'nameserver 192.168.48.200' > /etc/resolv.conf"
	ssh root\@"192.168.48.200" "
	cd /var/named;
	cp dsbl.rbltest.hwwang dsbl.rbltest;
	echo '11.200.168.192 IN A 127.0.0.4' >> dsbl.rbltest;
	echo '11.201.168.192 IN A 127.0.0.4' >> dsbl.rbltest;
	echo '12.200.168.192 IN A 127.0.0.4' >> dsbl.rbltest;
	echo '12.201.168.192 IN A 127.0.0.4' >> dsbl.rbltest;
	/etc/init.d/named restart;
	"
	
	ssh root\@$csgIP "
	cd /opt/CPSecure/CPWall/conf/; 
	echo -e 'Dsbl\t\t\tCommon\t\t\tlist.dsbl.org' > bldb.conf"
	
	ConfCPWall $csgIP smtp_rbl SMTP
	RunBenchmark "SMTP"
	
	ssh root\@$csgIP "echo 'nameserver 192.168.3.1' > /etc/resolv.conf"
	ssh root\@$csgIP "cd /opt/CPSecure/CPWall/conf/; cat /dev/null > bldb.conf"
}

function STM_SMTP_S04C02()
{
	caseName="SMTP.S04C02.DSBL.NotBlock.6K"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/email-6k:1 > /root/smtp"
	
	ssh root\@$csgIP "echo 'nameserver 192.168.48.200' > /etc/resolv.conf"
	ssh root\@"192.168.48.200" "
	cd /var/named;
	cp dsbl.rbltest.hwwang dsbl.rbltest;
	/etc/init.d/named restart;
	"
	
	ssh root\@$csgIP "
	cd /opt/CPSecure/CPWall/conf/; 
	echo -e 'Dsbl\t\t\tCommon\t\t\tlist.dsbl.org' > bldb.conf"
	
	ConfCPWall $csgIP smtp_rbl SMTP
	RunBenchmark "SMTP"
	
	ssh root\@$csgIP "echo 'nameserver 192.168.3.1' > /etc/resolv.conf"
	ssh root\@$csgIP "cd /opt/CPSecure/CPWall/conf/; cat /dev/null > bldb.conf"
}


function STM_SMTP_S04C03()
{
	caseName="SMTP.S04C03.DSBL.NotBlock.AntiSpam.6K"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/email-6k:1 > /root/smtp"
	
	ssh root\@$csgIP "echo 'nameserver 192.168.48.200' > /etc/resolv.conf"
	ssh root\@"192.168.48.200" "
	cd /var/named;
	cp dsbl.rbltest.hwwang dsbl.rbltest;
	/etc/init.d/named restart;
	"
	
	ssh root\@$csgIP "
	cd /opt/CPSecure/CPWall/conf/; 
	echo -e 'Dsbl\t\t\tCommon\t\t\tlist.dsbl.org' > bldb.conf"
	
	ConfCPWall $csgIP smtp_rbl_cmth SMTP
	RunBenchmark "SMTP"
	
	ssh root\@$csgIP "echo 'nameserver 192.168.3.1' > /etc/resolv.conf"
	ssh root\@$csgIP "cd /opt/CPSecure/CPWall/conf/; cat /dev/null > bldb.conf"
}

function STM_SMTP_S04C04()
{
	caseName="SMTP.S04C04.Spamhaus.NotBlock.6K"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/email-6k:1 > /root/smtp"
	
	ssh root\@$csgIP "echo 'nameserver 192.168.3.1' > /etc/resolv.conf"
	
	ssh root\@$csgIP "
	cd /opt/CPSecure/CPWall/conf/; 
	echo -e 'Spamhaus\t\t\tCommon\t\t\tsbl-xbl.spamhaus.org' > bldb.conf"
	
	ConfCPWall $csgIP smtp_rbl SMTP
	RunBenchmark "SMTP"
	
	ssh root\@$csgIP "cd /opt/CPSecure/CPWall/conf/; cat /dev/null > bldb.conf"
}


function STM_SMTP_S05C01()
{
	caseName="SMTP.S05C01.CommonTouch.Spam.Tag"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/spam.eml:1 > /root/smtp"
	
	ConfCPWall $csgIP smtp_cmth_tag SMTP
	RunBenchmark "SMTP"
}

function STM_SMTP_S05C02()
{
	caseName="SMTP.S05C02.CommonTouch.Spam.Quarantine"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/spam.eml:1 > /root/smtp"
	
	ConfCPWall $csgIP smtp_cmth_qrt SMTP
	RunBenchmark "SMTP"
}

function STM_SMTP_S05C03()
{
	caseName="SMTP.S05C03.CommonTouch.Spam.Block"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/spam.eml:1 > /root/smtp"
	
	ConfCPWall $csgIP smtp_cmth_block SMTP
	RunBenchmark "SMTP"
}


function STM_HTTPS_C01()
{
	caseName="HTTPS.01.Perform.SSE.NoS.SimplePic"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/simple-151k.html:1 >https"
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/pic-37k.jpg:2 >> https"
	
	ConfCPWall $csgIP https_nostream HTTPS
	RunBenchmark "HTTPS_NK"
}

function STM_HTTPS_C02()
{
	caseName="HTTPS.02.Stress.SSE.NoS.SimplePic"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/simple-151k.html:1 >https"
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/pic-37k.jpg:2 >> https"
	
	ConfCPWall $csgIP https_nostream HTTPS
	RunBenchmark "HTTPS_NK"
}

function STM_HTTPS_C03()
{
	caseName="HTTPS.03.SSE.NoS.QRT.SimplePic"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/simple-151k.html:1 >https"
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/pic-37k.jpg:2 >> https"
	
	ConfCPWall $csgIP https_qrt HTTPS
	RunBenchmark "HTTPS_NK"
}

function STM_HTTPS_C04()
{
	caseName="HTTPS.04.Stress.SSE.NoS.QRT.SimplePic"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/netlengendtestvirus.zip:1 >https"
	
	ConfCPWall $csgIP https_nostream HTTPS
	RunBenchmark "HTTPS_NK"
}

function STM_HTTPS_C05()
{
	caseName="HTTPS.05.Stable.SSE.NoS.SimplePic"
	
	SetStepValue $1 $2 $3 $4 $5
	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/simple-151k.html:1 >https"
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/pic-37k.jpg:2 >> https"
	
	ConfCPWall $csgIP https_nostream HTTPS
	RunBenchmark "HTTPS_NK"
}

function POP3_C01()
{
	caseName="POP3.C01.Perform"		
	
	ConfCPWall $csgIP smtp_delete ALL
	ConfMstone
	ssh root\@$clientIP "cd /usr/local/mstone;./mstone smtp -t 3m"
	ssh root\@$clientIP "cd /usr/local/mstone;./mstone pop -t $1 -l $2"
	ssh root\@$serverIP "/home/getMail.sh > /root/$caseName.$1$2Clients"
	
	FinishCase
	FinishMstoneCase
}

function POP3_C02()
{
	caseName="POP3.C02.Stress"		
	
	ConfCPWall $csgIP smtp_delete ALL
	ConfMstone
	ssh root\@$clientIP "cd /usr/local/mstone;./mstone smtp -t 6m"
	ssh root\@$clientIP "cd /usr/local/mstone;./mstone pop -t $1 -l $2"
	ssh root\@$serverIP "/home/getMail.sh > /root/$caseName.$1$2Clients"
	
	FinishCase
	FinishMstoneCase
}

function POP3_C03()
{
	caseName="POP3.C03.CommonTouch"		
	
	ConfCPWall $csgIP pop3_cmth_tag ALL
	ConfMstone
	
	ssh root\@$clientIP "cd /usr/local/mstone;cp conf/smtp.wld.spam conf/smtp.wld;./mstone smtp -t 3m"
	
	ssh root\@$clientIP "cd /usr/local/mstone;./mstone pop -t $1 -l $2"
	ssh root\@$serverIP "/home/getMail.sh > /root/$caseName.$1$2Clients"
	
	ssh root\@$clientIP "cd /usr/local/mstone;cp conf/smtp.wld.5k conf/smtp.wld"
	FinishCase
	FinishMstoneCase
}


function POP3_C04()
{
	caseName="POP3.C04.Stable.1H"		
	
	ConfCPWall $csgIP smtp_delete ALL
	ConfMstone
	ssh root\@$clientIP "cd /usr/local/mstone;./mstone smtp -t 6m"
	ssh root\@$clientIP "cd /usr/local/mstone;./mstone pop -t $1 -l $2"
	ssh root\@$serverIP "/home/getMail.sh > /root/$caseName.$1$2Clients"
	
	FinishCase
	FinishMstoneCase
}

function POP3_C05()
{
	caseName="POP3.C05.Perform.QRT"	
	
	ConfCPWall $csgIP pop3_qrt ALL
	ConfMstone
	ssh root\@$clientIP "cd /usr/local/mstone;./mstone smtp -t 3m"
	ssh root\@$clientIP "cd /usr/local/mstone;./mstone pop -t $1 -l $2"
	ssh root\@$serverIP "/home/getMail.sh > /root/$caseName.$1$2Clients"
	
	FinishCase
	FinishMstoneCase
}

function IMAP_C01()
{
	caseName="IMAP.C01.Perform"		
	
	ConfCPWall $csgIP smtp_delete ALL
	ConfMstone
	ssh root\@$clientIP "cd /usr/local/mstone;./mstone smtp -t 6m"
	ssh root\@$clientIP "cd /usr/local/mstone;./mstone imap -t $1 -l $2"
	ssh root\@$serverIP "/home/getMail.sh > /root/$caseName.$1$2Clients"
	
	FinishCase
	FinishMstoneCase
}

function IMAP_C02()
{
	caseName="IMAP.C02.Stress"		
	
	ConfCPWall $csgIP smtp_delete ALL
	ConfMstone
	ssh root\@$clientIP "cd /usr/local/mstone;./mstone smtp -t 10m"
	ssh root\@$clientIP "cd /usr/local/mstone;./mstone imap -t $1 -l $2"
	ssh root\@$serverIP "/home/getMail.sh > /root/$caseName.$1$2Clients"
	
	FinishCase
	FinishMstoneCase
}

function IMAP_C03()
{
	caseName="IMAP.C03.Stable"		
	
	ConfCPWall $csgIP smtp_delete ALL
	ConfMstone
	ssh root\@$clientIP "cd /usr/local/mstone;./mstone smtp -t 10m"
	ssh root\@$clientIP "cd /usr/local/mstone;./mstone imap -t $1 -l $2"
	ssh root\@$serverIP "/home/getMail.sh > /root/$caseName.$1$2Clients"
	
	FinishCase
	FinishMstoneCase
}

function IMAP_C04()
{
	caseName="IMAP.C04.Perform.QRT"		
	
	ConfCPWall $csgIP imap_qrt ALL
	ConfMstone
	ssh root\@$clientIP "cd /usr/local/mstone;./mstone smtp -t 6m"
	ssh root\@$clientIP "cd /usr/local/mstone;./mstone imap -t $1 -l $2"
	ssh root\@$serverIP "/home/getMail.sh > /root/$caseName.$1$2Clients"
	
	FinishCase
	FinishMstoneCase
}

# $1 $2 $3 $4
function FTP_C01()
{
	caseName="FTP.C01.Perform"		
	
	ConfCPWall $csgIP smtp_delete ALL
	ConfMstone
	ssh root\@$clientIP "dkftpbench -n$1 -h$svrIP -uftp -p123456 -t$2 -v -fx100k.dat | tee /root/$caseName.100K"
	sleep 20
	ssh root\@$clientIP "dkftpbench -n$3 -h$svrIP -uftp -p123456 -t$4 -v -fx10M.dat | tee /root/$caseName.10M"
	
	FinishCase
	FinishMstoneCase
}

function FTP_C02()
{
	caseName="FTP.C02.Stress"		
	
	ConfCPWall $csgIP smtp_delete ALL
	ConfMstone
	ssh root\@$clientIP "dkftpbench -n$1 -h$svrIP -uftp -p123456 -t$2 -v -fx100k.dat | tee /root/$caseName.100K"
	
	FinishCase
	FinishMstoneCase
}

function FTP_C03()
{
	caseName="FTP.C03.Stable"	
	
	ConfCPWall $csgIP smtp_delete ALL
	ConfMstone
	ssh root\@$clientIP "dkftpbench -n$1 -h$svrIP -uftp -p123456 -t$2 -v -fx100k.dat | tee /root/$caseName.100K"
	
	FinishCase
	FinishMstoneCase
}

function FTP_C04()
{
	caseName="FTP.C04.Perform.Qrt"		
	
	ConfCPWall $csgIP ftp_qrt ALL
	ConfMstone
	ssh root\@$clientIP "dkftpbench -n$1 -h$svrIP -uftp -p123456 -t$2 -v -fx100k.dat | tee /root/$caseName.100K"
	
	FinishCase
	FinishMstoneCase
}
########### Test ########################################

###################################
###################################

function RunSTM()
{
	ConfigRun "STM" $1
	
	STM_HTTP_S01C01
}

function RunSTM_All()
{
	ConfigRun "STM" $1
	
	# Basic Perform #
	STM_HTTP_S01C01
	STM_SMTP_S01C01
	STM_HTTPS_C01
	POP3_C01
	IMAP_C01
	FTP_C01
	
	# HTTP Perform #
	STM_HTTP_S01C02
	STM_HTTP_S01C03
	STM_HTTP_S01C04
	STM_HTTP_S01C05
	STM_HTTP_S01C06
	
	# SMTP Perform Test #
	STM_SMTP_S01C02
	STM_SMTP_S01C03
	STM_SMTP_S01C04
	
	# HTTPS QRT Perform #
	STM_HTTPS_C03
	
	# HTTP Stress SSE/TRAD #
	STM_HTTP_S02C01
	STM_HTTP_S02C02
	STM_HTTP_S02C03
	STM_HTTP_S02C04
	STM_HTTP_S02C05
	
	# SMTP Stress Test #
	STM_SMTP_S02C01
	STM_SMTP_S02C02
	STM_SMTP_S02C03
	STM_SMTP_S02C04
	
	# HTTPS Stress #
	STM_HTTPS_C02
	
	# HTTP Gzip #
	STM_HTTP_S03C01
	
	# HTTP Post #
	STM_HTTP_S04C01
	STM_HTTP_S04C02
	
	# HTTP JS #
	STM_HTTP_S05C01
	
	# POP3/IMAP/FTP Streee #
	POP3_C02
	POP3_C03
	POP3_C05
	IMAP_C02
	IMAP_C04
	FTP_C02
	FTP_C04
	
	# HTTP Stress URLD #
	STM_HTTP_S08C01
	STM_HTTP_S08C02
	
	# HTTP with SMTP Perform #
	STM_HTTP_S09C01
	STM_HTTP_S09C02
	
#######################################
	
	# HTTP Stress Viurs Files #
	STM_HTTP_S06C01
	STM_HTTP_S06C02
	STM_HTTP_S06C03
	STM_HTTP_S06C04
	
	# HTTP Stress Big File #
	STM_HTTP_S07C01
	STM_HTTP_S07C02
	
	# SMTP Stress Virus #
	STM_SMTP_S03C01
	STM_SMTP_S03C02
	STM_SMTP_S03C03
	STM_SMTP_S03C04
	STM_SMTP_S03C05
	
	# SMTP RBL Test #
	STM_SMTP_S04C01
	
	# SMTP Common Touch Test#
	STM_SMTP_S05C01
	STM_SMTP_S05C02
	
#######################################
	
	# HTTPS Stress QRT Test#
	STM_HTTPS_C04
	
#######################################
	
	# MSTONE Perform & Stress Test #
	
	
	# MSTONE Stable #
	POP3_C04
	IMAP_C03
	FTP_C03
	
	# SMTP 43k stable #
	STM_SMTP_S03C06
	
	# HTTP Stable #
	STM_HTTP_S10C01
	
	# HTTPS Stable #
	STM_HTTPS_C05
}


function RunSTM_T()
{
	ConfigRun "STM.T" $1
	
	# HTTP Stress URLD #
#	STM_HTTP_S08C01
#	STM_HTTP_S08C02
	# Spam Tag #
#	STM_SMTP_S05C01
	
#	STM_HTTP_S01C01_T
	# HTTP Stress 1000-6000 #	
#	STM_HTTP_S02C01_T
	
}













