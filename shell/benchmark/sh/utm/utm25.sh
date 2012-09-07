#!/bin/bash
# auto run regular benchmark test
# When user press Ctrl+C then clear the environment

function UTM25_HTTP_S01C01()
{
	caseName="HTTP.S01C01.SSE.NoS.IndexBig"

	beginValue=20
	stepValue=20
	maxValue=200

	tValue=360
	TValue=120

	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/sample-index.html:1 >/root/http"
	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/sample-big.jpg:2 >>/root/http"

	ConfCPWall $csgIP http_sse_nostream HTTP
	RunBenchmark "HTTP_K"
}

function UTM25_HTTP_S01C02()
{
	caseName="HTTP.S01C02.SKIP.NoS.IndexBig"

	beginValue=20
	stepValue=20
	maxValue=200

	tValue=360
	TValue=120

	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/sample-index.html:1 >/root/http"
	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/sample-big.jpg:2 >>/root/http"

	ConfCPWall $csgIP http_skip HTTP
	RunBenchmark "HTTP_K"
}

function UTM25_HTTP_S01C03()
{
	caseName="HTTP.S01C03.SSE.NoS.BigBig"

	beginValue=20
	stepValue=20
	maxValue=200

	tValue=360
	TValue=120

	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/sample-big.htm:1 >/root/http"
	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/sample-big.jpg:2 >>/root/http"

	ConfCPWall $csgIP http_sse_nostream HTTP
	RunBenchmark "HTTP_K"
}

function UTM25_HTTP_S01C04()
{
	caseName="HTTP.S01C04.SSE.NoS.IndexBig.RecTfc"

	beginValue=20
	stepValue=20
	maxValue=100

	tValue=360
	TValue=120

	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/sample-index.html:1 >/root/http"
	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/sample-big.jpg:2 >>/root/http"

	ConfCPWall $csgIP http_trfc HTTP
	RunBenchmark "HTTP_K"
	ssh root\@$csgIP "cd /opt/CPSecure/Eventd/conf;sed -e '1,30s/Service HTTP=\"true\"/Service HTTP=\"false\"/g' eventd.conf > b; cp b eventd.conf;chmod 666 *"
}

function UTM25_HTTP_S01C05()
{
	caseName="HTTP.S01C05.SSE.NoS.IndexBig.RouteMode"

	beginValue=20
	stepValue=20
	maxValue=100

	tValue=360
	TValue=120

	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/sample-index.html:1 >/root/http"
	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/sample-big.jpg:2 >>/root/http"

	ConfCPWall $csgIP http_sse_nostream HTTP
	RunBenchmark "HTTP_K"
}


function UTM25_HTTP_S02C01()
{
	caseName="HTTP.S02C01.SSE.NoS.Index"

	beginValue=100
	stepValue=400
	maxValue=1000

	tValue=360
	TValue=120

	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/sample-index.html:1 >/root/http"

	ConfCPWall $csgIP http_sse_nostream HTTP
	RunBenchmark "HTTP_K"
}

function UTM25_HTTP_S02C02()
{
	caseName="HTTP.S02C02.SSE.S.Index"

	beginValue=100
	stepValue=400
	maxValue=1000

	tValue=360
	TValue=120

	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/sample-index.html:1 >/root/http"

	ConfCPWall $csgIP http_sse_stream HTTP
	RunBenchmark "HTTP_K"
}

function UTM25_HTTP_S02C03()
{
	caseName="HTTP.S02C03.TRAD.NoS.Index"

	beginValue=100
	stepValue=400
	maxValue=1000

	tValue=360
	TValue=120

	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/sample-index.html:1 >/root/http"

	ConfCPWall $csgIP http_trad_nostream HTTP
	RunBenchmark "HTTP_K"
}

function UTM25_HTTP_S02C04()
{
	caseName="HTTP.S02C04.TRAD.S.Index"

	beginValue=100
	stepValue=400
	maxValue=1000

	tValue=360
	TValue=120

	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/sample-index.html:1 >/root/http"

	ConfCPWall $csgIP http_trad_stream HTTP
	RunBenchmark "HTTP_K"
}

function UTM25_HTTP_S02C05()
{
	caseName="HTTP.S02C05.SKIP.Index"

	beginValue=100
	stepValue=400
	maxValue=1000

	tValue=360
	TValue=120

	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/sample-index.html:1 >/root/http"

	ConfCPWall $csgIP http_skip HTTP
	RunBenchmark "HTTP_K"
}

function UTM25_HTTP_S02C06()
{
	caseName="HTTP.S02C06.SKIP.NoS.NoK.Index"

	beginValue=100
	stepValue=400
	maxValue=1000

	tValue=360
	TValue=120

	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/sample-index.html:1 >/root/http"

	ConfCPWall $csgIP http_sse_nostream HTTP
	RunBenchmark "HTTP_NK"
}

function UTM25_HTTP_S02C07()
{
	caseName="HTTP.S02C07.SSE.NoS.RouteMode.Index"

	beginValue=100
	stepValue=400
	maxValue=1000

	tValue=360
	TValue=120

	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/sample-index.html:1 >/root/http"

	ConfCPWall $csgIP http_sse_nostream HTTP
	RunBenchmark "HTTP_K"
}


function UTM25_HTTP_S03C01()
{
	caseName="HTTP.S02C10.SSE.NoS.IndexGZ"

	beginValue=100
	stepValue=400
	maxValue=1000

	tValue=360
	TValue=120

	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/sample-index.html.gz:1 >/root/http"

	ConfCPWall $csgIP http_sse_nostream HTTP
	RunBenchmark "HTTP_K_GZ"
}


function UTM25_HTTP_S04C01()
{
	caseName="HTTP.S04C01.SSE.NoS.K.Post.Index"

	beginValue=100
	stepValue=400
	maxValue=1000

	tValue=360
	TValue=120

	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/sample-index.html:1:/opt/CPSecure/CPBenchmark/samples/sample-index.html >/root/http"

	ConfCPWall $csgIP http_sse_nostream HTTP
	RunBenchmark "HTTP_PK"
}

function UTM25_HTTP_S04C02()
{
	caseName="HTTP.S04C02.SSE.NoS.NoK.Post.Index"

	beginValue=100
	stepValue=400
	maxValue=1000

	tValue=360
	TValue=120

	
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/sample-index.html:1:/opt/CPSecure/CPBenchmark/samples/sample-index.html >/root/http"

	ConfCPWall $csgIP http_sse_nostream HTTP
	RunBenchmark "HTTP_PNK"
}

function UTM25_HTTP_S05C01()
{
	caseName="HTTP.S05C01.SSE.NoS.JS"

	beginValue=100
	stepValue=400
	maxValue=1000

	tValue=360
	TValue=120

	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/tudou.html:1 >/root/http"
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/minijuegos.html:1 >>/root/http"

	ConfCPWall $csgIP http_block_js HTTP
	RunBenchmark "HTTP_K"
}

function UTM25_HTTP_S06C01()
{
	caseName="HTTP.S06C01.SSE.NoS.Mix.Stress"

	beginValue=1000
	stepValue=1000
	maxValue=1000

	tValue=1800
	TValue=120

	ssh root\@$clientIP  "cat /root/httpstress > /root/http"

	ConfCPWall $csgIP http_sse_nostream HTTP
	RunBenchmark "HTTP_K"
}

function UTM25_HTTP_S06C02()
{
	caseName="HTTP.S06C02.SSE.NoS.Mix.Spike"

	beginValue=1000
	stepValue=1000
	maxValue=1000
	
	tValue=30
	TValue=120

	ssh root\@$clientIP  "cat /root/httpstress > /root/http"

	ConfCPWall $csgIP http_sse_nostream HTTP
	RunBenchmark "HTTP_K" 5
}

function UTM25_HTTP_S06C03()
{
	caseName="HTTP.S06C03.SSE.NoS.Virus"

	beginValue=1000
	stepValue=1000
	maxValue=1000

	tValue=1800
	TValue=120

	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/netlengendtestvirus.zip:1 >/root/http"

	ConfCPWall $csgIP http_sse_nostream HTTP
	RunBenchmark "HTTP_K" 1
}

function UTM25_HTTP_S07C01()
{

	caseName="HTTP.S07C01.SSE.NoS.BigFile.1M"

	beginValue=20
	stepValue=20
	maxValue=20

	tValue=1800
	TValue=120

	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/google.exeexe:1 >/root/http"

	ConfCPWall $csgIP http_sse_nostream HTTP
	RunBenchmark "HTTP_K"
}

function UTM25_HTTP_S07C02()
{
	caseName="HTTP.S07C02.SSE.NoS.BigFile.8M"

	beginValue=20
	stepValue=20
	maxValue=20

	tValue=1800
	TValue=120

	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/linux.rar:1 >/root/http"

	ConfCPWall $csgIP http_sse_nostream HTTP
	RunBenchmark "HTTP_K"
}

function UTM25_HTTP_S08C01()
{
	caseName="HTTP.S08C01.SSE.NoS.IPS.DefRules"

	beginValue=20
	stepValue=20
	maxValue=200

	tValue=360
	TValue=120

	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/sample-index.html:1 >/root/http"
	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/sample-big.jpg:2 >>/root/http"

	ConfCPWall $csgIP http_sse_nostream HTTP
	RunBenchmark "HTTP_K"

	ssh root\@$csgIP "/opt/snort_inline/sbin/ips_ctrl stop"

}

function UTM25_HTTP_S08C02()
{
	caseName="HTTP.S08C02.SSE.NoS.IPS.AllRules"

	beginValue=20
	stepValue=20
	maxValue=200

	tValue=360
	TValue=120

	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/sample-index.html:1 >/root/http"
	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/sample-big.jpg:2 >>/root/http"

	ConfCPWall $csgIP http_sse_nostream HTTP
	RunBenchmark "HTTP_K"

	ssh root\@$csgIP "/opt/snort_inline/sbin/ips_ctrl stop"
}

function UTM25_HTTP_S09C01()
{
	caseName="HTTP.S09C01.SSE.NoS.URLD.IndexBig"

	urldConnStart=20
	urldConnStep=20
	urldIteNum=10

	beginValue=$urldConnStart
	stepValue=$urldConnStart
	maxValue=$urldConnStart

	tValue=360
	TValue=120

	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/sample-index.html:1 >/root/http"
	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/sample-big.jpg:2 >>/root/http"

	ssh root\@$csgIP "/etc/init.d/urld stop;rm /opt/modules/urld/data/cache_file;/etc/init.d/urld start"
	#ssh root\@$clientIP "ssh root\@csgLANIP cp /opt/CPSecure/webui/common/conf/block_sites.db.AllowAll /opt/CPSecure/webui/common/conf/block_sites.db"
	#ssh root\@$clientIP "ssh root\@csgLANIP cd /opt/CPSecure/CPWall/conf;cp thread_policy.conf.2 thread_policy.conf;chown cpwall.cpwall *"

	#ConfCPWall $csgIP http_urld_qkck_f HTTP
	ConfCPWall $csgIP http_sse_nostream HTTP
	RunBenchmark "HTTP_K_URLD" $urldIteNum

	#ssh root\@$clientIP "ssh root\@csgLANIP cp /opt/CPSecure/webui/common/conf/block_sites.db.Default /opt/CPSecure/webui/common/conf/block_sites.db"
	#ssh root\@$clientIP "ssh root\@csgLANIP cd /opt/CPSecure/CPWall/conf;cp thread_policy.conf.4 thread_policy.conf;chown cpwall.cpwall *"
}

function UTM25_HTTP_S09C02()
{
	caseName="HTTP.S09C02.SSE.NoS.URLD.IndexBig.True"

	urldConnStart=20
	urldConnStep=20
	urldIteNum=10

	beginValue=$urldConnStart
	stepValue=$urldConnStart
	maxValue=$urldConnStart

	tValue=360
	TValue=120

	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/sample-index.html:1 >/root/http"
	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/sample-big.jpg:2 >>/root/http"
	ssh root\@$csgIP "/etc/init.d/urld stop;rm /opt/modules/urld/data/cache_file;/etc/init.d/urld start"
	#ssh root\@$clientIP "ssh root\@csgLANIP cp /opt/CPSecure/webui/common/conf/block_sites.db.AllowAll /opt/CPSecure/webui/common/conf/block_sites.db"
	#ssh root\@$clientIP "ssh root\@csgLANIP cd /opt/CPSecure/CPWall/conf;cp thread_policy.conf.2 thread_policy.conf;chown cpwall.cpwall *"

#	ConfCPWall $csgIP http_urld_qkck_t HTTP
	ConfCPWall $csgIP http_sse_nostream HTTP
	RunBenchmark "HTTP_K_URLD" $urldIteNum

	#ssh root\@$clientIP "ssh root\@csgLANIP cp /opt/CPSecure/webui/common/conf/block_sites.db.Default /opt/CPSecure/webui/common/conf/block_sites.db"
	#ssh root\@$clientIP "ssh root\@csgLANIP cd /opt/CPSecure/CPWall/conf;cp thread_policy.conf.4 thread_policy.conf;chown cpwall.cpwall *"
}

function UTM25_HTTP_S10C01()
{

	caseName="HTTP.S10C01.SMTP.Perform"

######## HTTP #########

	beginValue=75
	stepValue=75
	maxValue=75

	tValue=360
	TValue=120

	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/sample-index.html:1 >/root/http"
	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/sample-big.jpg:2 >>/root/http"

	RefreshParam
	runHTTP_K_M=$runHTTP_K


######## SMTP #########

	tmpValue=$cliIP
	cliIP=$svrIP
	svrIP=$csgWANIP

	beginValue=25
	stepValue=25
	maxValue=25

	tValue=360
	TValue=120

	ssh root\@$serverIP  "echo /opt/CPSecure/CPBenchmark/samples/email-6k:1 >/root/smtp"

	RefreshParam
	runSMTP_M=$runSMTP
	
	ConfCPWall $csgIP http_sse_nostream HTTP SMTP
	RunBenchmark "HTTPSMTP"

	svrIP=$cliIP
	cliIP=$tmpValue
}

function UTM25_HTTP_S11C01()
{
	caseName="HTTP.S11C01.SSE.NoS.Stable"

######## HTTP #########

	beginValue=300
	stepValue=300
	maxValue=300

	tValue=180000
	TValue=120

	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/sample-index.html:1 >/root/http"
	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/sample-big.jpg:2 >>/root/http"

	RefreshParam
	runHTTP_K_M=$runHTTP_K


######## SMTP #########

	tmpValue=$cliIP
	cliIP=$svrIP
	svrIP=$csgWANIP

	beginValue=30
	stepValue=30
	maxValue=30

	tValue=180000
	TValue=120

	ssh root\@$serverIP  "echo /opt/CPSecure/CPBenchmark/samples/email-6k:1 >/root/smtp"

	RefreshParam
	runSMTP_M=$runSMTP
	
	ConfCPWall $csgIP http_sse_nostream HTTP SMTP POP3 IMAP FTP HTTPS
	RunBenchmark "HTTPSMTP"

	svrIP=$cliIP
	cliIP=$tmpValue
}


function UTM25_HTTP_S12C01()
{
	caseName="HTTP.S12C01.SSE.NoS.Soak"

######## HTTP #########

	beginValue=500
	stepValue=500
	maxValue=500

	tValue=7200
	TValue=120

	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/sample-index.html:1 >/root/http"
	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/sample-big.jpg:2 >>/root/http"

	RefreshParam
	runHTTP_K_M=$runHTTP_K


######## SMTP #########

	tmpValue=$cliIP
	cliIP=$svrIP
	svrIP=$csgWANIP

	beginValue=500
	stepValue=500
	maxValue=500

	tValue=7200
	TValue=120

	ssh root\@$serverIP  "echo /opt/CPSecure/CPBenchmark/samples/email-6k:1 >/root/smtp"

	RefreshParam
	runSMTP_M=$runSMTP
	
	ConfCPWall $csgIP http_sse_nostream HTTP SMTP
	RunBenchmark "HTTPSMTP"

	svrIP=$cliIP
	cliIP=$tmpValue
}

function UTM25_HTTP_S13C01()
{
	caseName="HTTP.S13C01.SSE.NoS.Bug7214.ArpError"

	beginValue=1
	stepValue=1
	maxValue=1

	tValue=360
	TValue=120

	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/sample-index.html:1 >/root/http"

	ConfCPWall $csgIP http_sse_nostream HTTP
	RunBenchmark "HTTP_K"
}


function UTM25_HTTP_S14C01()
{
	caseName="HTTP.S14C01.SSE.NoS.SessionLimit"

	beginValue=500
	stepValue=500
	maxValue=500

	tValue=1800
	TValue=120

	ssh root\@$clientIP  "cat /root/httpstress > /root/http"

	ConfCPWall $csgIP http_sse_nostream HTTP
	RunBenchmark "HTTP_K"
}


function UTM25_HTTP_S14C02()
{
	caseName="HTTP.S12C02.SSE.NoS.InOutBound"

######## HTTP #########

	beginValue=1000
	stepValue=1000
	maxValue=1000

	tValue=1800
	TValue=120

	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/sample-index.html:1 >/root/http"
	ssh root\@$clientIP  "echo /opt/CPSecure/CPBenchmark/samples/sample-big.jpg:2 >>/root/http"

	RefreshParam
	runHTTP_K_M=$runHTTP_K


######## SMTP #########

	tmpValue=$cliIP
	cliIP=$svrIP
	svrIP=$csgWANIP

	beginValue=1000
	stepValue=1000
	maxValue=1000

	tValue=1800
	TValue=120

	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/email-2k:10 > /root/smtp"
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/email-15k:10 >> /root/smtp"
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/email-15k-virus:1 >> /root/smtp"
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/scan.eml:1 >> /root/smtp"
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/mailvirus.eml:1 >> /root/smtp"

	RefreshParam
	runSMTP_M=$runSMTP
	
	ConfCPWall $csgIP http_sse_nostream HTTP SMTP
	RunBenchmark "HTTPSMTP"

	svrIP=$cliIP
	cliIP=$tmpValue
}




function UTM25_SMTP_S01C01()
{
	caseName="SMTP.S01C01.Perform.6K"

	beginValue=10
	stepValue=20
	maxValue=110

	tValue=360
	TValue=120

	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/email-6k:1 >/root/smtp"

	ConfCPWall $csgIP smtp_delete SMTP
	RunBenchmark "SMTP"
}

function UTM25_SMTP_S01C02()
{
	caseName="SMTP.S01C02.Perform.43K"

	beginValue=10
	stepValue=20
	maxValue=110

	tValue=360
	TValue=120

	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/email-43k:1 >/root/smtp"

	ConfCPWall $csgIP smtp_delete SMTP
	RunBenchmark "SMTP"
}

function UTM25_SMTP_S01C03()
{
	caseName="SMTP.S01C03.AntiSpam.6K"

	beginValue=10
	stepValue=40
	maxValue=110

	tValue=360
	TValue=120

	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/email-6k:1 >/root/smtp"

	ConfCPWall $csgIP smtp_antispam SMTP
	RunBenchmark "SMTP"
}

function UTM25_SMTP_S02C01()
{
	caseName="SMTP.S02C01.Stress.6K"

	beginValue=50
	stepValue=100
	maxValue=550

	tValue=360
	TValue=120

	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/email-6k:1 >/root/smtp"

	ConfCPWall $csgIP smtp_delete SMTP
	RunBenchmark "SMTP"
}

function UTM25_SMTP_S02C02()
{
	caseName="SMTP.S02C02.Stress.43K"

	beginValue=50
	stepValue=100
	maxValue=550

	tValue=360
	TValue=120

	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/email-43k:1 >/root/smtp"

	ConfCPWall $csgIP smtp_delete SMTP
	RunBenchmark "SMTP"
}

function UTM25_SMTP_S02C03()
{
	caseName="SMTP.S02C03.Stress.1M"

	beginValue=20
	stepValue=20
	maxValue=20

	tValue=1800
	TValue=120

	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/google.eml:1 > /root/smtp"

	ConfCPWall $csgIP smtp_delete SMTP
	RunBenchmark "SMTP"
}

function UTM25_SMTP_S02C04()
{
	caseName="SMTP.S02C04.Stress.AntiSpam"

	beginValue=50
	stepValue=100
	maxValue=550

	tValue=360
	TValue=120

	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/email-6k:1 > /root/smtp"

	ConfCPWall $csgIP smtp_antispam SMTP
	RunBenchmark "SMTP"
}


function UTM25_SMTP_S03C01()
{
	caseName="SMTP.S03C01.Stress.Mix"

	beginValue=500
	stepValue=500
	maxValue=1500

	tValue=360
	TValue=120

	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/email-2k:10 > /root/smtp"
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/email-15k:10 >> /root/smtp"
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/email-15k-virus:1 >> /root/smtp"
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/scan.eml:1 >> /root/smtp"
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/mailvirus.eml:1 >> /root/smtp"

	ConfCPWall $csgIP smtp_delete SMTP
	RunBenchmark "SMTP"
}

function UTM25_SMTP_S03C02()
{
	caseName="SMTP.S03C02.Stable.MailVirus"

	beginValue=1000
	stepValue=1000
	maxValue=1000

	tValue=1800
	TValue=120

	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/mailvirus.eml:1 > /root/smtp"

	ConfCPWall $csgIP smtp_delete SMTP
	RunBenchmark "SMTP" 1
}

function UTM25_SMTP_S03C03()
{
	caseName="SMTP.S03C03.Stable.43K"

	beginValue=30
	stepValue=30
	maxValue=30

	tValue=3600
	TValue=120

	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/email-43k:1 > /root/smtp"

	ConfCPWall $csgIP smtp_delete SMTP
	RunBenchmark "SMTP" 1
}

function UTM25_SMTP_S04C01()
{
	caseName="SMTP.S04C01.RBL.6K"

	beginValue=10
	stepValue=20
	maxValue=110

	tValue=360
	TValue=120

	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/email-6k:1 > /root/smtp"

	#ConfCPWall $csgIP smtp_rbl SMTP
	#ConfCPWall $csgIP smtp_antispam SMTP
	# hongwei need change in the future.
	#ssh root\@$clientIP "ssh root\@csgLANIP echo 'nameserver 192.168.35.168' > /etc/resolv.conf"
	#ssh root\@"192.168.35.168" "/etc/init.d/named restart"
	#ssh root\@$clientIP "ssh root\@csgLANIP cd /opt/CPSecure/CPWall/conf/; cat dsbl > bldb.conf"
	RunBenchmark "SMTP"

	#ssh root\@$clientIP "ssh root\@csgLANIP echo 'nameserver 192.168.3.1' > /etc/resolv.conf"
	#ssh root\@$clientIP "ssh root\@csgLANIP cd /opt/CPSecure/CPWall/conf/; cat /dev/null > bldb.conf"
}

function UTM25_SMTP_S05C01()
{
	caseName="SMTP.S05C01.CommonTouch.Spam.Tag"

	beginValue=25
	stepValue=25
	maxValue=25

	tValue=360
	TValue=120

	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/spam.eml:1 > /root/smtp"

	ConfCPWall $csgIP smtp_cmth_tag SMTP
	RunBenchmark "SMTP"
}

function UTM25_SMTP_S05C02()
{
	caseName="SMTP.S05C02.CommonTouch.Spam.Block"

	beginValue=25
	stepValue=25
	maxValue=25

	tValue=360
	TValue=120

	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/spam.eml:1 > /root/smtp"

	ConfCPWall $csgIP smtp_cmth_block SMTP
	RunBenchmark "SMTP"
}

function UTM25_HTTPS_C01()
{
	caseName="HTTPS.01.Perform.SSE.NoS.IndexBig"

	beginValue=10
	stepValue=20
	maxValue=110

	tValue=360
	TValue=120

	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/sample-index.html:1 >https"
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/sample-big.jpg:2 >> https"

	ConfCPWall $csgIP https_nostream HTTPS
	RunBenchmark "HTTPS_NK"
}

function UTM25_HTTPS_C02()
{
	caseName="HTTPS.02.Stress.SSE.NoS.IndexBig"

	beginValue=50
	stepValue=100
	maxValue=550

	tValue=360
	TValue=120

	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/sample-index.html:1 >https"
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/sample-big.jpg:2 >> https"

	ConfCPWall $csgIP https_nostream HTTPS
	RunBenchmark "HTTPS_NK"
}

function UTM25_HTTPS_C03()
{
	caseName="HTTPS.03.Stable.SSE.NoS.IndexBig"

	beginValue=80
	stepValue=80
	maxValue=80

	tValue=3600
	TValue=120

	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/sample-index.html:1 >https"
	ssh root\@$clientIP "echo /opt/CPSecure/CPBenchmark/samples/sample-big.jpg:2 >> https"

	ConfCPWall $csgIP https_nostream HTTPS HTTP IMAP SMTP POP3 FTP
	RunBenchmark "HTTPS_NK"
}


function POP3_C01()
{
	caseName="POP3.C01.Perform"		
	
	ConfCPWall $csgIP smtp_delete POP3 FTP IMAP
	ConfMstone
	ssh root\@$clientIP "cd /usr/local/mstone;./mstone smtp -t 3m -l 10"
	ssh root\@$clientIP "cd /usr/local/mstone;./mstone pop -t 6m -l 100"
	ssh root\@$serverIP "/home/getMail.sh > /root/$caseName.6m100L"
	
	FinishCase
	FinishMstoneCase
}

function POP3_C02()
{
	caseName="POP3.C02.Stress"		

	ConfCPWall $csgIP smtp_delete POP3 FTP IMAP
	ConfMstone
	ssh root\@$clientIP "cd /usr/local/mstone;./mstone smtp -t 6m -l 10"
	ssh root\@$clientIP "cd /usr/local/mstone;./mstone pop -t 30m -l 200"
	ssh root\@$serverIP "/home/getMail.sh > /root/$caseName.30m200L"

	FinishCase
	FinishMstoneCase
}

function POP3_C03()
{
	caseName="POP3.C03.CommonTouch"		

	ConfCPWall $csgIP pop3_cmth_tag POP3
	ConfMstone
	
	ssh root\@$serverIP "/home/delMail.sh"
	ssh root\@$serverIP "/etc/init.d/exim4 start"
	
	ssh root\@$clientIP "cd /usr/local/mstone;cp conf/smtp.wld.spam conf/smtp.wld;./mstone smtp -t 3m -l 10"
	
	ssh root\@$clientIP "cd /usr/local/mstone;./mstone pop -t 6m -l 25"
	ssh root\@$serverIP "/home/getMail.sh > /root/$caseName.6m25L"
	
	ssh root\@$clientIP "cd /usr/local/mstone;cp conf/smtp.wld.5k conf/smtp.wld"
	FinishCase
	FinishMstoneCase
}

function POP3_C04()
{
	caseName="POP3.C04.Stable"		
	
	ConfCPWall $csgIP smtp_delete POP3 FTP IMAP
	ConfMstone
	ssh root\@$clientIP "cd /usr/local/mstone;./mstone smtp -t 6m -l 10"
	ssh root\@$clientIP "cd /usr/local/mstone;./mstone pop -t 1h -l 25"
	ssh root\@$serverIP "/home/getMail.sh > /root/$caseName.1h25L"
	
	FinishCase
	FinishMstoneCase
}


function IMAP_C01()
{
	caseName="IMAP.C01.Perform"		
	
	ConfCPWall $csgIP smtp_delete POP3 FTP IMAP
	ConfMstone
	ssh root\@$clientIP "cd /usr/local/mstone;./mstone smtp -t 12m -l 10"
	ssh root\@$clientIP "cd /usr/local/mstone;./mstone imap -t 6m -l 100"
	ssh root\@$serverIP "/home/getMail.sh > /root/$caseName.6m100L"
	
	FinishCase
	FinishMstoneCase
}

function IMAP_C02()
{
	caseName="IMAP.C02.Stress"		
	
	ConfCPWall $csgIP smtp_delete POP3 FTP IMAP
	ConfMstone
	ssh root\@$clientIP "cd /usr/local/mstone;./mstone smtp -t 20m -l 10"
	ssh root\@$clientIP "cd /usr/local/mstone;./mstone imap -t 30m -l 200"
	ssh root\@$serverIP "/home/getMail.sh > /root/$caseName.30m200L"
	
	FinishCase
	FinishMstoneCase
}

function IMAP_C03()
{
	caseName="IMAP.C03.Stable"		
	
	ConfCPWall $csgIP smtp_delete POP3 FTP IMAP
	ConfMstone
	ssh root\@$clientIP "cd /usr/local/mstone;./mstone smtp -t 1h -l 10"
	ssh root\@$clientIP "cd /usr/local/mstone;./mstone imap -t 1h -l 25"
	ssh root\@$serverIP "/home/getMail.sh > /root/$caseName.1h25L"
	
	FinishCase
	FinishMstoneCase
}



function FTP_C01()
{
	caseName="FTP.C01.Perform"		
	
	ConfCPWall $csgIP smtp_delete POP3 FTP IMAP
	ConfMstone
	ssh root\@$clientIP "dkftpbench -n100 -h$svrIP -uftp -p123456 -t600 -v -fx100k.dat > /root/$caseName.100K"
	sleep 20
	ssh root\@$clientIP "dkftpbench -n25 -h$svrIP -uftp -p123456 -t600 -v -fx10M.dat > /root/$caseName.10M"
	
	scp root\@$clientIP:/root/$caseName.* $resultDir
	
	FinishCase
	FinishMstoneCase
}

function FTP_C02()
{
	caseName="FTP.C02.Stress"		
	
	ConfCPWall $csgIP smtp_delete POP3 FTP IMAP
	ConfMstone
	ssh root\@$clientIP "dkftpbench -n200 -h$svrIP -uftp -p123456 -t1800 -v -fx100k.dat > /root/$caseName.100K"
	
	scp root\@$clientIP:/root/$caseName.* $resultDir
	
	FinishCase
	FinishMstoneCase
}

function FTP_C03()
{
	caseName="FTP.C03.Stable"		
	
	ConfCPWall $csgIP smtp_delete POP3 FTP IMAP
	ConfMstone
	ssh root\@$clientIP "dkftpbench -n25 -h$svrIP -uftp -p123456 -t3600 -v -fx100k.dat > /root/$caseName.100K"
	
	scp root\@$clientIP:/root/$caseName.* $resultDir
	
	FinishCase
	FinishMstoneCase
}

function FTP_C04()
{
	caseName="FTP.C04.InBound"		
	
	ConfCPWall $csgIP smtp_delete POP3 FTP IMAP
	ConfMstone
	ssh root\@$clientIP "dkftpbench -n200 -h$svrIP -uftp -p123456 -t1800 -v -fx100k.dat > /root/$caseName.100K"
	
	scp root\@$clientIP:/root/$caseName.* $resultDir
	
	FinishCase
	FinishMstoneCase
}

########### Test ########################################

###################################
###################################

function RunUTM()
{
	ConfigRun "UTM25" $1
	
	# HTTP Perform #
	UTM25_HTTP_S01C01
	UTM25_HTTP_S01C02
	UTM25_HTTP_S01C03
	UTM25_HTTP_S01C04
	
	# HTTP Stress SSE/TRAD #
	UTM25_HTTP_S02C01
	UTM25_HTTP_S02C02
	UTM25_HTTP_S02C03
	UTM25_HTTP_S02C04
	UTM25_HTTP_S02C05
	UTM25_HTTP_S02C06
	
	# HTTP Gzip #
	UTM25_HTTP_S03C01
	
	# HTTP Post #
	UTM25_HTTP_S04C01
	UTM25_HTTP_S04C02
	
	# HTTP JS #
	UTM25_HTTP_S05C01
	
	# HTTP Stress Viurs Files #
	UTM25_HTTP_S06C01
	UTM25_HTTP_S06C02
	UTM25_HTTP_S06C03
	
	# HTTP Stress Big File #
	UTM25_HTTP_S07C01
	UTM25_HTTP_S07C02
	
	# HTTP Stress IPS #
	UTM25_HTTP_S08C01
	UTM25_HTTP_S08C02
	
	# HTTP Stress URLD #
	UTM25_HTTP_S09C01
	UTM25_HTTP_S09C02
	
	# HTTP SMTP Perform #
	UTM25_HTTP_S10C01
	
	# HTTP SMTP Stable & Soak #
	UTM25_HTTP_S11C01
	UTM25_HTTP_S12C01
	
#######################################
	
	# SMTP Perform Test #
	UTM25_SMTP_S01C01
	UTM25_SMTP_S01C02
	UTM25_SMTP_S01C03
	
	# SMTP Stress Test #
	UTM25_SMTP_S02C01
	UTM25_SMTP_S02C02
	UTM25_SMTP_S02C03
	UTM25_SMTP_S02C04
	
	# SMTP Stress Virus #
	UTM25_SMTP_S03C01
	UTM25_SMTP_S03C02
	UTM25_SMTP_S03C03
	
	# SMTP RBL Test #
	UTM25_SMTP_S04C01
	
	# SMTP Common Touch Test#
	UTM25_SMTP_S05C01
	UTM25_SMTP_S05C02
	
#######################################
	
	# HTTPS Test#
	UTM25_HTTPS_C01
	UTM25_HTTPS_C02
	UTM25_HTTPS_C03
	
#######################################
	
	# MSTONE Perform & Stress Test#
	POP3_C01
	POP3_C02
	POP3_C03
	
	IMAP_C01
	IMAP_C02
	
	FTP_C01
	FTP_C02
	
	# MSTONE Stable Test#
	POP3_C04
	IMAP_C03
	FTP_C03
	
}

function RunUTM25_T()
{
	ConfigRun "UTM25.T" $1
	
#	# Basic Performance #
#	UTM25_HTTP_S01C01
#	UTM25_SMTP_S01C01
#	UTM25_HTTPS_C01
#	POP3_C01
#	IMAP_C01
#	FTP_C01
#	
#	# Basic Stress #
#	UTM25_HTTP_S02C01
#	UTM25_SMTP_S02C01
#	POP3_C02
#	IMAP_C02
#	FTP_C02
#	
#	# Baseic Stress 2 #
#	UTM25_HTTP_S02C02
#	UTM25_HTTP_S02C03
#	UTM25_HTTP_S02C04
#	UTM25_HTTP_S02C05
#	UTM25_HTTP_S02C06
#	UTM25_SMTP_S02C03
#	UTM25_HTTPS_C02
#	
#	# HTTP Gzip #
#	UTM25_HTTP_S03C01
#	
#	# HTTP Post #
#	UTM25_HTTP_S04C01
#	UTM25_HTTP_S04C02
#	
#	# HTTP JS #
#	UTM25_HTTP_S05C01
#	
#	# HTTP Stress Viurs Files #
#	UTM25_HTTP_S06C01
#	UTM25_HTTP_S06C02
#	UTM25_HTTP_S06C03
#	
#	# HTTP Stress Big File #
#	UTM25_HTTP_S07C01
	UTM25_HTTP_S07C02
	
	# HTTP Stress IPS Only Run 1 Now#
	UTM25_HTTP_S08C01
	#UTM25_HTTP_S08C02
	
	# HTTP Stress URLD Only Run 1 Now #
	UTM25_HTTP_S09C01
	#UTM25_HTTP_S09C02
	
	# HTTP SMTP Perform #
	UTM25_HTTP_S10C01
	
#######################################
	
	# HTTP Perform Left #
	UTM25_HTTP_S01C02
	UTM25_HTTP_S01C03
	UTM25_HTTP_S01C04
	
	# SMTP Perform Left #
	UTM25_SMTP_S01C02
	
	# SMTP Stress Left #
	UTM25_SMTP_S02C02
	
	# SMTP Stress Virus #
	UTM25_SMTP_S03C01
	UTM25_SMTP_S03C02
	
#######################################
	
	# MSTONE Stable Test#
	POP3_C04
	IMAP_C03
	FTP_C03
	
	# HTTPS Stable#
	UTM25_HTTPS_C03
	
	# SMTP Stable #	
	UTM25_SMTP_S03C03
########Not Run#####################
#	# HTTP SMTP Stable & Soak #
#	UTM25_HTTP_S11C01
#	UTM25_HTTP_S12C01
#	
#	# SMTP RBL Test #
#	UTM25_SMTP_S04C01
#	
#	# SMTP Common Touch Test#
#	UTM25_SMTP_S05C01
#	UTM25_SMTP_S05C02
	
}

function RunUTM25_Stable()
{
	ConfigRun "UTM25.Stable" $1

	# HTTP Stable Test #
#	UTM25_HTTP_S11C01

}


function RunUTM25_Test()
{
	ConfigRun "UTM25" $1
	
#	# Basic Performance #
#	UTM25_HTTP_S01C01
#	UTM25_SMTP_S01C01
#	UTM25_HTTPS_C01
#	POP3_C01
#	IMAP_C01
#	FTP_C01
#	
#	# Basic Stress #
#	UTM25_HTTP_S02C01
#	UTM25_SMTP_S02C01
#	POP3_C02
#	IMAP_C02
#	FTP_C02
#	
#	# Baseic Stress 2 #
#	UTM25_HTTP_S02C02
#	UTM25_HTTP_S02C03
#	UTM25_HTTP_S02C04
#	UTM25_HTTP_S02C05
#	UTM25_HTTP_S02C06
#	UTM25_SMTP_S02C03
#	UTM25_HTTPS_C02
#	
#	# HTTP Gzip #
#	UTM25_HTTP_S03C01
#	
#	# HTTP Post #
#	UTM25_HTTP_S04C01
#	UTM25_HTTP_S04C02
#	
#	# HTTP JS #
#	UTM25_HTTP_S05C01
#	
#	# HTTP Stress Viurs Files #
#	UTM25_HTTP_S06C01
#	UTM25_HTTP_S06C02
#	UTM25_HTTP_S06C03
#	
#	# HTTP Stress Big File #
#	UTM25_HTTP_S07C01
#	UTM25_HTTP_S07C02
	
	# HTTP Stress IPS Only Run 1 Now#
	UTM25_HTTP_S08C01
	#UTM25_HTTP_S08C02
	
	# HTTP Stress URLD Only Run 1 Now #
	UTM25_HTTP_S09C01
	#UTM25_HTTP_S09C02
	
	# HTTP SMTP Perform #
	UTM25_HTTP_S10C01
	
#######################################
	
	# HTTP Perform Left #
	UTM25_HTTP_S01C02
	UTM25_HTTP_S01C03
	UTM25_HTTP_S01C04
	
	# SMTP Perform Left #
	UTM25_SMTP_S01C02
	
	# SMTP Stress Left #
	UTM25_SMTP_S02C02
	
	# SMTP Stress Virus #
	UTM25_SMTP_S03C01
	UTM25_SMTP_S03C02
	
#######################################
	
	# MSTONE Stable Test#
	POP3_C04
	IMAP_C03
	FTP_C03
	
	# HTTPS Stable#
	UTM25_HTTPS_C03
	
	# SMTP Stable #	
	UTM25_SMTP_S03C03
#######Not Run#####################
	# HTTP SMTP Stable & Soak #
	UTM25_HTTP_S11C01
	UTM25_HTTP_S12C01
	
	# SMTP RBL Test #
	UTM25_SMTP_S04C01
	
	# SMTP Common Touch Test#
	UTM25_SMTP_S05C01
	UTM25_SMTP_S05C02
	
}

















