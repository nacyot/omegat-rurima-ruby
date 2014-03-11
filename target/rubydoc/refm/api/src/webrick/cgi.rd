#@since 1.8.1
require webrick/httprequest
require webrick/httpresponse
require webrick/config

일반적인 CGI 환경에서 [[lib:webrick]] 라이브러리의 서블릿과 같은 CGI를 쓰기 위한 라이브러리입니다.서버가 WEBrick이 아니라도 사용할 수 있습니다.

=== 사용법

WEBrick의 서블릿을 만드는 것과 마찬가지로 [[c:WEBrick::CGI]]의 서브 클래스 메소드 do_GET 이나 do_POST 를 정의해서 CGI 스크립트를 만들 수 있습니다.

스크립트 마지막에 [[m:WEBrick::CGI#start]] 메소드를 호출할 필요가 있습니다.
WEBrick::CGI#start 메소드는 service 메소드를 호출하며, service 메소드는 요청(request)에 반응해 do_XXX 메소드를 호출합니다.이런 원리로 스크릅티가 실행됩니다.

예:

 #!/usr/local/bin/ruby
 require 'webrick/cgi'

 class MyCGI < WEBrick::CGI
   def do_GET(req, res)
     res["content-type"] = "text/plain"
     ret = "hoge\n"
     res.body = ret
   end
 end
 
 MyCGI.new.start()

==== do_XXX メソッド

do_XXX 메소드의 XXX에는 GET, HEAD, POST, PUT, DELETE, OPTIONS를 사용할 수 있습니다.

[[c:WEBrick::CGI]]의 서브클래스에서 정의한 XXX 메소드는 [[m:WEBrick::CGI#service]] 메소드에서 HTTP 요청을 받으면 자동적으로 호출됩니다.
따라서 [[c:WEBrick::CGI]]의 서브 클래스에는 이런 종류의 메소드를 적절하게 정의할 필요가 있습니다.
이러한 메소드들의 리턴값에 대해선 따로 규정되어있지 않습니다.

[[c:WEBrick::CGI]] のサブクラスでは、クライアントが使う可能性のある RFC で定義された HTTP の
メソッドはすべて実装する必要があります。
クライアントからのリクエストに使われないと分かっているメソッドは実装しなくてもかまいません。
実装されていない HTTP メソッドであった場合、[[m:WEBrick::CGI#service]] メソッドが例外を発生させます。

do_XXX メソッドが呼ばれた時点では、クライアントからのリクエストに含まれる Entity Body の読み込みは
まだ行われていません。[[m:WEBrick::HTTPRequest#query]], [[m:WEBrick::HTTPRequest#body]] などの
メソッドが読ばれた時点で読み込みが行われます。クライアントから巨大なデータが送られてくることを考慮して
ユーザはプログラミングを行うべきです。

do_XXX メソッドには二つの引数があります。
第一引数は、クライアントからのリクエストを表す [[c:WEBrick::HTTPRequest]] オブジェクトです。
第二引数は、クライアントへのレスポンスを表す [[c:WEBrick::HTTPResponse]] オブジェクトです。

==== フォームフィールドの値を得る

フォームフィールドの値は [[m:WEBrick::HTTPRequest#query]] メソッドが返す Hash オブジェクトに
収納されています。

 require "webrick/cgi"
 class MyCGI < WEBrick::CGI
   def do_GET(req, res)
     req.query               #=> Hash を返します。     req.query['q']          
     req.query['num']       
   end
 end
 MyCGI.new.start()

。

 require "webrick/cgi"
 class MyCGI < WEBrick::CGI
   def do_GET(req, res)
     req.query['q'].list     #=> フォームの値を保持した文字列の配列を返します。   end
 end
 MyCGI.new.start()

query メソッドが返す Hash オブジェクトのキーと値のうち値は [[c:WEBrick::HTTPUtils::FormData]] クラスの
インスタンスになります。FormData クラスは String クラスのサブクラスです。


==== マルチパートフィールドの値を取得する（ファイル送信）

 require "webrick/cgi"
 class MyCGI < WEBrick::CGI
   def do_GET(req, res)
     d = req.query['field_name']   #=> FormData 클래스의 인스턴트
     d.name                        #=> "field_name"
     d.filename                    #=> 만약 존재한다면 파일명을 리턴합니다.
     d['content-type']             #=> 헤더의 값은 [] 메소드로 가져옵니다.
     d                             #=> 받은 파일의 내용.
   end
 end
 MyCGI.new.start()


==== 클라이언트에 쿠키 설정

 require "webrick/cgi"
 class MyCGI < WEBrick::CGI
   def do_GET(req, res)
     c1 = WEBrick::Cookie.new("name1", "val1")
     c1.expires = Time.now + 30
     res.cookies << c1
     
     c2 = WEBrick::Cookie.new("name2", "val2")
     c2.expires = Time.now + 30
     res.cookies << c2
   end
 end
 MyCGI.new.start()

==== 클라이언트에서 쿠키 가져오기

 require "webrick/cgi"
 class MyCGI < WEBrick::CGI
   def do_GET(req, res)
     req.cookies                                   #=> WEBrick::Cookie 객체 배열
     c = req.cookies.find{|c| c.name == "name1" }  #=> WEBrick::Cookie 객체
   end
 end
 MyCGI.new.start()


==== CGI 에 관련된 환경변수 값 가져오기

CGI에 관련된 환경변수 값들은 직접 ENV에서 가져올 수도 있지만
WEBrick::HTTPRequest 객체의 메소드들을 사용해 가져올 수 있습니다.

 require "webrick/cgi"
 class MyCGI < WEBrick::CGI
   def do_GET(req, res)
     req.content_length
     req.content_type
     req.path_info
     req.query_string
     req.peeraddr
     req.host
     req.user
     req.request_method
     req.script_name
     req.port
   end
 end
 MyCGI.new.start()

=== 링크

 * [[rfc:3875]]

= class WEBrick::CGI < Object

일반적인 CGI 환경에서 [[lib:webrick]] 라이브러리의 서블릿과 같은 CGI를 쓰기 위한 클래스입니다.


== Class Methods

--- new(config = {}, *options)    -> WEBrick::CGI

WEBrick::CGI 객체를 생성해서 리턴합니다.

@param config 설정을 담고 있는 해쉬를 지정합니다.

config 에서 사용할 수 있는 키는 다음과 같습니다.
키는 모두 [[c:Symbol]] 객체입니다.

: :ServerName     
 서버 이름을 문자열로 지정합니다.기본 설정은 ENV["SERVER_SOFTWARE"가 사용됩니다.
 ENV["SERVER_SOFTWARE"] 가 nil이면 "null"로 지정됩니다.
: :HTTPVersion
 HTTP 버전을 [[c:WEBrick::HTTPVersion]] 객체로 지정합니다.
 기본설정은 ENV["SERVER_PROTOCOL"]의 HTTP 버전이 사용됩니다.  ENV["SERVER_PROTOCOL"]가 nil이면 HTTP 버전은 1.0으로 지정됩니다.
: :NPH            
 NPH 스크립트로서 실행되는 경우 true를 지정합니다.그렇지 않은 경우 false를 지정합니다.
 기본 설정은 false입니다.
: :Logger 
 로그를 받을 [[c:WEBrick::BasicLog]] 객체를 지정합니다.기본 설정은 표준에러출력에
 로그가 출력됩니다.
: :RequestTimeout
 요청을 읽어올 때 타임아웃 시간을 초단위로 지정합니다.기본 설정은 30초입니다.
: :Escape8bitURI
 この値が true の場合、クライアントからのリクエスト URI に含まれる 8bit 目が立った文字をエスケープします。 기본 설정은 false입니다. 

@param options 사용자가 이 클래스를 상속해서 만든 클래스에서 @options 이라는 인스턴트 변수로 사용할 수 있습니다.


== Instance Methods

#@since 1.8.3
--- [](key)    -> object

지정된 key에 해당하는 설정값을 리턴합니다.

@param key 설정의 이름을 Symbol 객체로 지정합니다.

#@end

#@since 1.8.3
--- config     -> Hash

설정을 담고 있는 해쉬를 리턴합니다.

@see [[m:WEBrick::CGI.new]]
#@end

#@since 1.8.3
--- logger     -> WEBrick::BasicLog 

설정되어있는 로그 객체를 리턴합니다.

기본 설정은 [[c:WEBrick::BasicLog]].new($stderr)입니다.
#@end

--- service(req, res)     -> ()

指定された [[c:WEBrick::HTTPRequest]] オブジェクト req の [[m:WEBrick::HTTPRequest#request_method]] に応じて、
自身の do_GET, do_HEAD, do_POST, do_OPTIONS... いずれかのメソッドを req と res を引数として呼びます。

特に理由が無い限り [[c:WEBrick::CGI]] のサブクラスがこのメソッドを定義する必要はありません。

@param req クライアントからのリクエストを表す [[c:WEBrick::HTTPRequest]] オブジェクトです。

@param res クライアントへのレスポンスを表す [[c:WEBrick::HTTPResponse]] オブジェクトです。

@raise WEBrick::HTTPStatus::MethodNotAllowed 指定された
       [[c:WEBrick::HTTPRequest]] オブジェクト req が自身に定義されてい
       ないHTTP のメソッドであった場合発生します。

--- start(env = ENV, stdin = $stdin, stdout = $stdout)     -> ()

自身に定義されたサービスを実行します。

start メソッドは service メソッドを呼び出し、service メソッドはリクエストに応じて
do_XXX メソッドを呼び出します。このようにして CGI スクリプトは実行されます。

@param env CGI スクリプトが受け取った Meta-Variables (環境変数)を保持したハッシュか、
           それと同じ [] メソッドを持ったオブジェクトを指定します。

@param stdin リクエストデータの入力元を [[c:IO]] オブジェクトで指定します。

@param stdout レスポンスデータの出力先を [[c:IO]] オブジェクトで指定します。

= class WEBrick::CGI::CGIError < StandardError

CGI に関係する例外クラスです。

#@end
