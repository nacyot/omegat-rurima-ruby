= module WEBrick::HTTPAuth::UserDB

[[c:WEBrick::HTTPAuth::BasicAuth]], [[c:WEBrick::HTTPAuth::DigestAuth]]에서 사용하는 모듈입니다.


== Instance Methods

--- auth_type -> Class

[[c:WEBrick::HTTPAuth::BasicAuth]], [[c:WEBrick::HTTPAuth::DigestAuth]] 둘 중 하나를 리턴합니다.

--- auth_type=(type)

인증 방식을 정합니다.

@param type [[c:WEBrick::HTTPAuth::BasicAuth]], [[c:WEBrick::HTTPAuth::DigestAuth]] 둘 중 하나를 지정합니다.

--- make_passwd(realm, user, pass) -> String

[[m:WEBrick::HTTPAuth::UserDB#auth_type]]의 make_passwd를 호출합니다.

@param realm レルムを指定します。

@param user 사용자명을 지정합니다.

@param pass 패스워드를 지정합니다.

@see [[m:WEBrick::HTTPAuth::BasicAuth#make_passwd]], [[m:WEBrick::HTTPAuth::DigestAuth#make_passwd]]

--- set_passwd(realm, user, pass)
#@# -> discard
与えられた情報をもとに、パスワードをハッシュ化して保存します。

@param realm レルムを指定します。

@param user 사용자명을 지정합니다.

@param pass 패스워드를 지정합니다.

--- get_passwd(realm, user, reload_db = false) -> String

与えられたレルムとユーザ名からパスワードのハッシュ値を取得して返します。

@param realm レルムを指定します。

@param user 사용자명을 지정합니다.

@param reload_db 무시됩니다.
