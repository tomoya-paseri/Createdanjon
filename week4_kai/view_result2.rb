#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
#encodring 'cgi'
require 'cgi'
require "sqlite3"
cgi=CGI.new
print cgi.header("text/html;charset=UTF-8")
choice_data=Hash.new(0)
num=0
title=""
id=1

print <<EOF
<!DOCTYPE html>
<html>
<body>
EOF

begin
db=SQLite3::Database.new("report1102.db")
rescue => ex
  print <<EOF
読み込みに失敗しました。お手数ですがもう一度ページを読み込むか時間を開けてアクセスして下さい<br>
<a href="enquete_form.rb">投票に戻る</a>
</body>
</html>
EOF
#さすがにerror_log.txtの判定をすると無限ループになるからやらない
io_log=open("error_log.txt","a:utf-8")
io_log.write("#{ex}\n")
io_log.close
exit
end

#データの読み込み
db.transaction(){
  db.execute("SELECT question from question where id=#{id};"){|row|
    title=row[0]
  }
  db.execute("SELECT choice.choice_content, choice.choice_number from choice where choice.question_id=#{id};"){|row|
    choice_data[row[0]]=row[1]
    num=num+row[1].to_i
  }
}



#htmlの生成
print <<EOF
<h1>投票結果</h1>
<h2>#{title}</h2>
投票数 : #{num}<br>
EOF

choice_data.each{|key,value|
  print "  ・#{key} : #{value}<br>"
}

print <<EOF
<a href="enquete_form2.rb">投票に戻る</a>
</body>
</html>
EOF
