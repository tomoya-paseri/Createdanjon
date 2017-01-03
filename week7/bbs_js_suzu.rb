#!/usr/bin/env ruby
# encoding: utf-8
require "cgi"
cgi = CGI.new
data = open("bbsdata.txt","r:UTF-8")
messages = CGI.escapeHTML(data.read)
data.close
print cgi.header("text/html; charset=utf-8")
print <<EOF
<html>
<head>
<meta http-equiv="Content-type" content="text/html; charset=UTF-8">
<title>simple bbs</title>
<script type="text/javascript">
function pre_check(){
msg = document.getElementById("msg").value;
name = document.getElementById("name").value;
result1 = msg.match(/.*<.*>.*/);
result2 = name.match(/.*<.*>.*/);
var ret=true;
if(msg.length==0 || name.length==0){
    alert("文字と名前入れろ");
    ret=false;
}
if(result1!=null || result2!=null){
    alert("タブ使うな");
    ret=false;
}
return ret;
}
</script>
</head>
<body>
<h1>1行掲示板</h1>
<p>メッセージをどうぞ<p>
<form action="update_.rb" method="post" onsubmit="return pre_check()">
<div>メッセージ<input name="msg" type="text" id="msg"></div>
<div>お名前<input name="name" type="text" id="name"></div>
<div>
<input type="submit" value="書き込む">
<input type="reset" value="クリア">
</div>
</form>
</hr>
<pre>
#{messages}
</pre>
</body>
</html>
EOF
