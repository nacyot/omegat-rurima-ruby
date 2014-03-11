#@since 1.9.1
HTTP クッキーを利用するためのクラスを定義したライブラリです。#@end

#@# = class CGI::Cookie < DelegateClass(Array)
= class CGI::Cookie < Array

쿠키를 나타내는 클래스입니다.

예:
  cookie1 = CGI::Cookie.new("name", "value1", "value2", ...)
  cookie1 = CGI::Cookie.new({"name" => "name", "value" => "value"})
  cookie1 = CGI::Cookie.new({'name'    => 'name',
                             'value'   => ['value1', 'value2', ...],
                             'path'    => 'path',   # optional
                             'domain'  => 'domain', # optional
                             'expires' => Time.now, # optional
                             'secure'  => true      # optional
                            })

  cgi.out({"cookie" => [cookie1, cookie2]}){ "string" }

  name    = cookie1.name
  values  = cookie1.value
  path    = cookie1.path
  domain  = cookie1.domain
  expires = cookie1.expires
  secure  = cookie1.secure

  cookie1.name    = 'name'
  cookie1.value   = ['value1', 'value2', ...]
  cookie1.path    = 'path'
  cookie1.domain  = 'domain'
  cookie1.expires = Time.now + 30
  cookie1.secure  = true

@see [[rfc:2965]]


== Class Methods

--- new(name = "", *value) -> CGI::Cookie

쿠키 객체를 생성합니다.

첫번째 인수를 해쉬로 지정하는 경우 아래의 키를 사용할 수 있습니다.

: name
  쿠키의 이름을 지정합니다.필수: value
  쿠키의 단일 값이나 리스트를 지정합니다.
: path
  이 쿠키에 적용되는 path를 지정합니다.기본 설정은 CGI 스크립트의 베이스 디렉토리입니다.
: domain
  이 쿠키를 적용하는 도메인을 지정합니다.
: expires
  쿠키가 유효한 시간을  [[c:Time]] 인스턴트로 지정합니다. : secure
  true를 지정하면 이 쿠키는 secure cookie로 설정됩니다.
  기본 설정은 false입니다.secure cookie는 https 프로코톨을 사용하는 경우만 송신됩니다.

@param name 쿠키의 이름을 문자열로 지정합니다.
            쿠키의 이름과 값을 요소로 가지는 해쉬를 지정합니다.

@param value name에 대응하는 하나 이상의 값 리스트를 지정합니다.

        예 :
        cookie1 = CGI::Cookie.new("name", "value1", "value2", ...)
        cookie1 = CGI::Cookie.new({"name" => "name", "value" => "value"})
        cookie1 = CGI::Cookie.new({'name'    => 'name',
                                   'value'   => ['value1', 'value2', ...],
                                   'path'    => 'path',   # optional
                                   'domain'  => 'domain', # optional
                                   'expires' => Time.now, # optional
                                   'secure'  => true      # optional
                                  })

        cgi.out({"cookie" => [cookie1, cookie2]}){ "string" }

        name    = cookie1.name
        values  = cookie1.value
        path    = cookie1.path
        domain  = cookie1.domain
        expires = cookie1.expires
        secure  = cookie1.secure

        cookie1.name    = 'name'
        cookie1.value   = ['value1', 'value2', ...]
        cookie1.path    = 'path'
        cookie1.domain  = 'domain'
        cookie1.expires = Time.now + 30
        cookie1.secure  = true

--- parse(raw_cookie) -> Hash

쿠키 문자열을 분석합니다.

 

        예 :
        cookies = CGI::Cookie.parse("raw_cookie_string")
          # { "name1" => cookie1, "name2" => cookie2, ... }


== Instance Methods

--- name -> String

쿠키의 이름을 리턴합니다.

--- name=(value)

쿠키의 이름을 지정합니다.

@param value 이름을 지정합니다. 

--- value -> Array

쿠키 값을 리턴합니다.

--- value=(value)

쿠키 값을 지정합니다.

@param value 새로운 값을 지정합니다.

--- path -> String

쿠키에 적용되는 경로를 리턴합니다.

--- path=(value)

쿠키에 적용되는 경로를 지정합니다.

@param value 경로를 지정합니다.

--- domain -> String

쿠키에 적용되는 도메인을 리턴합니다.

--- domain=(value)

쿠키에 적용되는 도메인을 지정합니다.

@param value 도메인을 지정합니다.

--- expires -> Time

쿠키의 유효기간을 리턴합니다.

--- expires=(value)

쿠키의 유효기간을 지정합니다.

@param value 유효기간을 [[c:Time]] 의 인스턴트로 지정합니다.

--- secure -> bool

secure cookie인 경우 true을 리턴합니다.
그렇지 않은 경우엔 false를 반환합니다.

--- secure=(val)

secure cookie 여부를 설정합니다.

@param val true를 설정하면 secure cookie가 됩니다.

--- to_s -> String

쿠키를 문자열로 리턴합니다.
