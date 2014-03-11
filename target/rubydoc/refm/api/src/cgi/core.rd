#@since 1.9.1
cgi 라이브러리의 핵심 기능을 포함하는 라이브러리입니다.
#@end

= class CGI < Object
include CGI::QueryExtension

CGI 스크립트를 작성하기 위해 필요한 기능을 제공하는 클래스입니다.

== Class Methods
--- parse(query) -> Hash

주어진 쿼리 문자열을 분석합니다.

@param query 쿼리 문자열을 지정합니다.

예 :
        require "cgi"

        params = CGI.parse("query_string")
          # {"name1" => ["value1", "value2", ...],
          #  "name2" => ["value1", "value2", ...], ... }

#@since 1.9.1
--- accept_charset -> String

사용중인 캐릭터셋을 문자열로 리턴합니다.
기본 설정은 UTF-8입니다.

--- accept_charset=(charset)

캐릭터셋을 설정합니다.

@param charset 문자열로 캐릭터셋의 이름을 지정합니다.

@see [[d:spec/m17n]]

#@end
#@until 1.9.1
#@include(util.rd)
#@end
== Instance Methods

#@since 1.9.1
--- accept_charset -> String

사용중인 캐릭터셋을 문자열로 리턴합니다.
기본 설정은 UTF-8입니다.

@see [[m:CGI.accept_charset]], [[m:CGI.accept_charset=]]

--- nph?-> bool
#@#nodoc

#@end

--- header(options = "text/html") -> String

options 인수를 받아 HTTP 헤더를 생성합니다. [[m:CGI#out]] 와는 달리 표준출력으로는 출력하지 않습니다.
[[m:CGI#out]] 를 사용하지 않고 스스로 HTML을 출력할 필요가 있는 경우 사용합니다.
이 메소드는 문자열 인코딩을 변환하지 않습니다.

헤더의 키로 아래의 이름을 사용할 수 있습니다.

: type
  Content-Type 헤더입니다.기본 설정은 "text/html" 입니다.
: charset
  캐릭터셋을 Content-Type 헤더에 추가합니다.
: nph
  boolean 값을 지정합니다.true이면 http 버전, 상태 코드,
  Date 헤더를 지정합니다.또한 Server와 Connection의 각 헤더에도 기본설정값을 지정합니다.
  false인 경우엔 이런 값들을 직접 지정해줄 필요가 있습니다.
: status
  HTTP 상태 코드를 지정합니다.
  이 리스트 아래에 사용가능한 상태코드 리스트가 있습니다.
: server
  서버 소프트웨어의 이름을 지정합니다.Server 헤더에 상응합니다.
: connection
  접속하는 종류를 지정합니다.Connection 헤더에 상응합니다.
: length
  보내는 데이터의 길이를 지정합니다.Content-Length 헤더에 상응합니다.
: language
  보내는 데이터의 언어를 지정합니다.Content-Langugae 헤더에 상응합니다.
: expires
  보내는 데이터의 유효기간을 [[c:Time]] 인스턴트로 지정합니다.
  Expires 헤더에 상응합니다.
: cookie
  쿠키값을 문자열, [[c:CGI::Cookie]]의 인스턴트, 혹은 위의 것들을 포함하는 해쉬로 지정합니다.
  하나 이상의 Set-Cookie 헤더에 상응합니다.

status 인자에는 아래의 문자열이 사용가능합니다.

        "OK"                  --> "200 OK"
        "PARTIAL_CONTENT"     --> "206 Partial Content"
        "MULTIPLE_CHOICES"    --> "300 Multiple Choices"
        "MOVED"               --> "301 Moved Permanently"
        "REDIRECT"            --> "302 Found"
        "NOT_MODIFIED"        --> "304 Not Modified"
        "BAD_REQUEST"         --> "400 Bad Request"
        "AUTH_REQUIRED"       --> "401 Authorization Required"
        "FORBIDDEN"           --> "403 Forbidden"
        "NOT_FOUND"           --> "404 Not Found"
        "METHOD_NOT_ALLOWED"  --> "405 Method Not Allowed"
        "NOT_ACCEPTABLE"      --> "406 Not Acceptable"
        "LENGTH_REQUIRED"     --> "411 Length Required"
        "PRECONDITION_FAILED" --> "412 Rrecondition Failed"
        "SERVER_ERROR"        --> "500 Internal Server Error"
        "NOT_IMPLEMENTED"     --> "501 Method Not Implemented"
        "BAD_GATEWAY"         --> "502 Bad Gateway"
        "VARIANT_ALSO_VARIES" --> "506 Variant Also Negotiates"

@param options [[c:Hash]]으로 HTTP 헤더를 생성하기 위해서 필요한 정보를 지정합니다.

예 :
        header
          # Content-Type: text/html

        header("text/plain")
          # Content-Type: text/plain

        header({"nph"        => true,
                "status"     => "OK",  # == "200 OK"
                  # "status"     => "200 GOOD",
                "server"     => ENV['SERVER_SOFTWARE'],
                "connection" => "close",
                "type"       => "text/html",
                "charset"    => "iso-2022-jp",
                  # Content-Type: text/html; charset=iso-2022-jp
                "language"   => "ja",
                "expires"    => Time.now + 30,
                "cookie"     => [cookie1, cookie2],
                "my_header1" => "my_value"
                "my_header2" => "my_value"})

예 :
        cgi = CGI.new('html3')
        print cgi.header({"charset" => "shift_jis", "status" => "OK"})
        print "<html><head><title>TITLE</title></head>\r\n"
        print "<body>BODY</body></html>\r\n"

@see [[ruby-list:35911]]

--- out(options = "text/html") { .... }

HTTP 헤더와 블록에 넘겨진 문자열을 표준출력으로 출력합니다.

HEAD 요청 (REQUEST_METHOD == "HEAD")의 경우엔 HTTP 헤더만 출력합니다.

charset이 "iso-2022-jp"・"euc-jp"・"shift_jis" 중 하나이면
문자열 인코딩을 자동변환하고 language를 "ja"로 설정합니다.

@param options [[c:Hash]]으로 HTTP 헤더를 생성하기 위해서 필요한 정보를 지정합니다.

예 :
        cgi = CGI.new
        cgi.out{ "string" }
          # Content-Type: text/html
          # Content-Length: 6
          #
          # string

        cgi.out("text/plain"){ "string" }
          # Content-Type: text/plain
          # Content-Length: 6
          #
          # string

        cgi.out({"nph"        => true,
                 "status"     => "OK",  # == "200 OK"
                 "server"     => ENV['SERVER_SOFTWARE'],
                 "connection" => "close",
                 "type"       => "text/html",
                 "charset"    => "iso-2022-jp",
                   # Content-Type: text/html; charset=iso-2022-jp
                 "language"   => "ja",
                 "expires"    => Time.now + (3600 * 24 * 30),
                 "cookie"     => [cookie1, cookie2],
                 "my_header1" => "my_value",
                 "my_header2" => "my_value"}){ "string" }

@see [[m:CGI#header]]

--- print(*strings)
#@todo

인수의 문자열을 표준출력으로 출력합니다.
cgi.print는 $DEFAULT_OUTPUT.print와 같습니다.

예 :
       cgi = CGI.new
       cgi.print "This line is a part of content body.\r\n"

#@#== Constants

--- CR -> String

CR(캐리지 리턴)을 타나내는 문자열입니다.

--- LF -> String

라인피드를 나타내는 문자열입니다.

--- EOL -> String

줄바꿈 문자입니다.

#@# --- REVISION -> String
#@# nodoc

#@since 1.9.2
--- NEEDS_BINMODE -> bool

파일을 열 때 바이너리 모드가 필요한지 여부를 나타내는 상수입니다.
시스템에 의존하는 상수입니다.
#@end

--- PATH_SEPARATOR -> Hash

경로 구분 문자열을 나타내는 해쉬입니다.

--- HTTP_STATUS -> Hash

HTTP 상태 코드를 나타내는 해쉬입니다.

#@until 1.9.1
#@# 1.9.1 이후 버전에서는 cgi/util.rd을 참조해주세요.
--- RFC822_DAYS -> [String]

[[rfc:822]]에 정의된 요일의 줄임말을 리턴합니다.

@see [[rfc:822]]

--- RFC822_MONTHS -> [String]

[[rfc:822]]에 정의된 월 이름의 줄임말을 리턴합니다.

@see [[rfc:822]]
#@end
#@since 1.9.1
--- MAX_MULTIPART_LENGTH -> Fixnum

Maximum content length of multipart data

--- MAX_MULTIPART_COUNT -> Fixnum

Maximum number of request parameters when multipart

#@end
= module CGI::QueryExtension

쿼리 문자열을 다루기 위한 메소드들이 정의된 모듈입니다.


== Instance Methods

--- [](key) -> Array

문자열 key에 대응하는 key に対応するパラメータが見つからなかった場合は、nil を返します。（[[m:CGI#params]]と等価です）

フォームから入力された値や、URL に埋め込まれた QUERY_STRING のパース結果の取得などに使用します。

@param key キーを文字列で指定します。

--- accept -> String

ENV['HTTP_ACCEPT']을 리턴합니다.

--- accept_charset -> String

ENV['HTTP_ACCEPT_CHARSET']을 리턴합니다.

--- accept_encoding -> String

ENV['HTTP_ACCEPT_ENCODING']을 리턴합니다.

--- accept_language -> String

ENV['HTTP_ACCEPT_LANGUAGE']을 리턴합니다.

--- auth_type -> String

ENV['AUTH_TYPE']을 리턴합니다.

--- cache_control -> String

ENV['HTTP_CACHE_CONTROL']을 리턴합니다.

--- content_length -> Fixnum

ENV['CONTENT_LENGTH']을 리턴합니다.

--- content_type -> String

ENV['CONTENT_TYPE']을 리턴합니다.

--- cookies -> Hash

쿠키의 이름과 값을 가진 해쉬를 리턴합니다.

--- cookies=(value)

쿠키를 설정합니다.

@param value 쿠키의 이름과 값을 가지고 있는 해쉬를 지정합니다.

--- from -> String

ENV['HTTP_FROM']을 리턴합니다.

--- gateway_interface -> String

ENV['GATEWAY_INTERFACE']을 리턴합니다.

--- has_key?(*args) -> bool
--- key?(*args) -> bool
--- include?(*args) -> bool

주어진 키가 쿼리에 포함되어 있으면 true를 리턴합니다.
그렇지 않은 경우엔 false를 반환합니다.

@param args 하나 이상의 키를 지정합니다.

--- host -> String

ENV['HTTP_HOST']를 리턴합니다.

--- keys(*args) -> [String]

すべてのパラメータのキーを配列として返します。

--- multipart?-> bool

multipart 폼이면 true를 리턴합니다.
그렇지 않은 경우엔 false를 반환합니다.

       예 :
       cgi = CGI.new
       if cgi.multipart?         field1=cgi['field1'].read
       else
         field1=cgi['field1']
       end

--- negotiate -> String

ENV['HTTP_NEGOTIATE']을 리턴합니다.

--- params -> Hash

쿠키 값들이 저자왼 해쉬를 리턴합니다.

폼에서 입력된 값이나 URL에 포함된 QUERY_STRING을 구문분석한 결과를 사용합니다.

      cgi = CGI.new
      cgi.params['developer']     # => ["Matz"] (Array)
      cgi.params['developer'][0]  # => "Matz"
      cgi.params['']              # => nil

--- params=(hash)

주어진 hash를 쿠키값으로 설정합니다.

@param hash 해쉬를 지정합니다.


--- path_info -> String

ENV['PATH_INFO']를 리턴합니다.

--- path_translated -> String

ENV['PATH_TRANSLATED']를 리턴합니다.

--- pragma -> String

ENV['HTTP_PRAGMA']를 리턴합니다.

--- query_string -> String

ENV['QUERY_STRING']를 리턴합니다.

--- raw_cookie -> String

ENV["HTTP_COOKIE"]를 리턴합니다.

--- raw_cookie2 -> String

ENV["HTTP_COOKIE2"]를 리턴합니다.

--- referer -> String

ENV['HTTP_REFERER']를 리턴합니다.

--- remote_addr -> String

ENV['REMOTE_ADDR']를 리턴합니다.

--- remote_host -> String

ENV['REMOTE_HOST']를 리턴합니다.

--- remote_ident -> String

ENV['REMOTE_IDENT']를 리턴합니다.

--- remote_user -> String

ENV['REMOTE_USER']를 리턴합니다.

--- request_method -> String

ENV['REQUEST_METHOD']를 리턴합니다.

--- script_name -> String

ENV['SCRIPT_NAME']을 리턴합니다.

--- server_name -> String

ENV['SERVER_NAME']을 리턴합니다.

--- server_port -> Fixnum

ENV['SERVER_PORT']을 리턴합니다.

--- server_protocol -> String

ENV['SERVER_PROTOCOL']을 리턴합니다.

--- server_software -> String

ENV['SERVER_SOFTWARE']을 리턴합니다.

--- user_agent -> String

ENV['HTTP_USER_AGENT']을 리턴합니다.

#@since 1.9.1
--- create_body(is_large) -> StringIO | Tempfile
#@# nodoc

--- files -> Hash

업로드한 파일 이름과 내용을 담은 객체를 해쉬를 리턴합니다.

--- unescape_filename?-> bool
#@# nodoc

#@end

= module CGI::QueryExtension::Value
#@# nodoc


== Instance Methods

--- [](idx, *args)
#@todo

--- first -> self
--- last  -> self
#@todo

--- set_params(params)
#@todo

--- to_a -> Array
--- to_ary -> Array
#@todo

= class CGI::InvalidEncoding < Exception

올바르지 않은 문자 인코딩이 있을 때 발생하는 예외입니다.

