require webrick/httpauth/userdb
require webrick/httpauth/digestauth

Apache의 htdigest에 호환되는 기능을 제공하는 라이브러리입니다.

= class WEBrick::HTTPAuth::Htdigest < Object
include WEBrick::HTTPAuth::UserDB

Apache의 htdigest 호환 클래스

예

 require 'webrick'
 include WEBrick
 htd = HTTPAuth::Htdigest.new('dot.htdigest')
 htd.set_passwd('realm', 'username', 'supersecretpass')
 htd.flush
 htd2 = HTTPAuth::Htdigest.new('dot.htdigest')
 p htd2.get_passwd('realm', 'username', false) == '65fe03e5b0a199462186848cc7fda42b'


== Class Methods

--- new(path) -> WEBrick::HTTPAuth::Htdigest
Htdigest 객체를 생성합니다.

@param path 패스워드를 저장할 파일의 경로를 지정합니다.


== Instance Methods

--- delete_passwd(realm, user)
#@# -> discard
realm 속해 있는 user의 패스워드를 삭제합니다.

@param realm レルムを指定します。

@param user 사용자명을 지정합니다.

--- each{|user, realm, pass| ... } -> Hash

ユーザ名、レルム、パスワードをブロックに渡して評価します。

--- flush(path = nil) -> ()

파일에 기록합니다.path에 파일명이 주어지면 해당하는 파일에 기록합니다.

@param path 파일명을 지정합니다.

--- get_passwd(realm, user, reload_db) -> String

与えられたレルムとユーザ名からパスワードのハッシュ値を取得して返します。

@param realm レルムを指定します。

@param user 사용자명을 지정합니다.

@param reload_db 真を指定すると [[m:WEBrick::HTTPAuth::Htdigest#reload]] を呼んでから値を返します。

--- reload
#@# -> discard
파일을 다시 읽습니다.

--- set_passwd(realm, user, pass)
#@# -> discard
与えられた情報をもとに、パスワードをハッシュ化して保存します。

@param realm レルムを指定します。

@param user 사용자명을 지정합니다.

@param pass 패스워드를 지정합니다.


