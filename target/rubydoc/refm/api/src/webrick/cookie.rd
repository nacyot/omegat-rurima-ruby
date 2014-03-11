require webrick/httputils

= class WEBrick::Cookie < Object

Cookie 클래스입니다.[[rfc:2109]] 을 따릅니다.
RFC2109는 [[rfc:2965]]에 의해 폐기되었지만 WEBrick::Cookie 클래스는 RFC2965를 지원하지 않습니다.

 * [[url:http://www.studyinghttp.net/translations#RFC2965]]  
 * [[url:http://www.studyinghttp.net/cookies]] 


== Class Methods

--- new(name, value)    -> WEBrick::Cookie

새로운 [[c:WEBrick::Cookie]] 객체를 리턴합니다.
name에 쿠키의 이름, value에 쿠키 값을 지정 합니다.

@param name Cookie의 이름을 문자열로 지정합니다.

@param value Cookie의 값을 문자열로 지정합니다.

--- parse(str)    -> [WEBrick::Cookie]

ユーザーエージェントから送られてきた Cookie ヘッダの値 str をパースし、
新しく [[c:WEBrick::Cookie]] オブジェクトを生成しその配列を返します。
各属性の形式が仕様に準拠しているかを確認しません。

@param str Cookie を表す文字列を指定します。

  require 'webrick'
  include WEBrick
  c = Cookie.parse('$Version="1"; Customer="WILE"; $Path="/foo"; P_Number="Rocket"; $Path="/foo/hoge"')
  p c[1].name, c[1].path
 
  #=> 
  "P_Number"
  "/foo/hoge"

#@since 1.8.4
--- parse_set_cookie(str)    -> WEBrick::Cookie

サーバから送られてくる Set-Cookie ヘッダの値 str をパースし、
新しく [[c:WEBrick::Cookie]] オブジェクトを生成し返します。

@param str Set-Cookie ヘッダの値を文字列で指定します。

  require 'webrick'
  include WEBrick
  c = Cookie.parse_set_cookie('Shipping="FedEx"; Version="1"; Path="/acme"')
  p c.name, c.value
  
  #=>
  "Shipping"
  "FedEx"

#@end

#@since 1.8.6

--- parse_set_cookies(str)    -> [WEBrick::Cookie]

サーバから送られてくる Set-Cookie ヘッダの値 str をパースし、
新しく [[c:WEBrick::Cookie]] オブジェクトの配列を生成し返します。

@param str Set-Cookie ヘッダの値を文字列で指定します。

#@end


== Instance Methods

--- comment         -> String
--- comment=(value)

コメントを文字列で表すアクセサです。

@param value コメントを文字列で指定します。

--- domain         -> String
--- domain=(value)

ドメイン名を文字列で表すアクセサです。

@param value ドメイン名を表す文字列を指定します。

--- expires    -> Time
--- expires=(value)

有効期限を [[c:Time]]オブジェクトで表すアクセサです。

@param value 有効期限を [[c:Time]] オブジェクトまたは文字列を指定します。

--- max_age          -> Integer
--- max_age=(value)

クッキーの寿命を整数(単位は秒)で表すアクセサです。

@param value クッキーの寿命を正の整数で指定します。0 は直ちに破棄される事を意味する。

--- name   -> String

Cookie の名前を文字列で返します。

--- path          -> String
--- path=(value)

パス名を文字列で表すアクセサです。

@param value パス名を文字列で指定します。

--- secure         -> bool
--- secure=(value)

クッキーのSecure属性を真偽値で表すアクセサです。

@param value クッキーのSecure属性を真偽値で指定します。

--- to_s    -> String

クッキーを文字列にして返します。

--- value       -> String
--- value=(str)

クッキーの値を文字列で表すアクセサです。

@param str クッキーの値を文字列で指定します。

--- version           -> Integer
--- version=(value)

Cookie のバージョン番号を整数で表すアクセサです。

@param value Cookie のバージョン番号を整数で指定します。
