require webrick/httpauth/userdb
require webrick/httpauth/basicauth

Apache의 htpasswd에 호환되는 기능을 제공하는 라이브러리입니다.

= class WEBrick::HTTPAuth::Htpasswd < Object
include WEBrick::HTTPAuth::UserDB

Apache의 htpasswd 호환 클래스입니다.
.htpasswd 파일을 새로 만드는 것도 가능합니다.
htpasswd -m (MD5)나 -s (SHA)로 만들어진 .htpasswd 파일은 지원하지 않습니다.


예

 require 'webrick'
 include WEBrick
 htpd = HTTPAuth::Htpasswd.new('dot.htpasswd')
 htpd.set_passwd(nil, 'username', 'supersecretpass')
 htpd.flush
 htpd2 = HTTPAuth::Htpasswd.new('dot.htpasswd')
 pass = htpd2.get_passwd(nil, 'username', false)
 p pass == 'supersecretpass'.crypt(pass[0,2])


== Class Methods

--- new(path) -> WEBrick::HTTPAuth::Htpasswd

Htpasswd 객체를 생성합니다.

@param path 패스워드를 저장할 파일의 경로를 지정합니다.


== Instance Methods

--- delete_passwd(realm, user) -> String

사용자의 패스워드를 삭제합니다.realm은 무시됩니다.

@param realm 무시됩니다.

@param user 사용자명을 지정합니다.

--- each{|user, pass| ...} -> Hash

사용자명과 패스워드를 블록에 넘겨서 평가합니다.

--- get_passwd(realm, user, reload_db) -> String

사용자 패스워드의 암호화된 문자열을 리턴합니다.

@param realm 무시됩니다.

@param user 사용자명을 지정합니다.

@param reload_db true를 지정하면 [[m:WEBrick::HTTPAuth::Htpasswd#reload]]를 호출하고나서 리턴합니다.


--- flush(path = nil)
#@# -> discard
파일에 기록합니다.path에 파일명이 주어지면 해당하는 파일에 기록합니다.

@param path 파일명을 지정합니다.

--- reload
#@# -> discard
파일을 다시 읽습니다.

--- set_passwd(realm, user, pass)
#@# -> discard
与えられた情報をもとに、パスワードをハッシュ化して保存します。

@param realm 무시됩니다.

@param user 사용자명을 지정합니다.

@param pass 패스워드를 지정합니다.
