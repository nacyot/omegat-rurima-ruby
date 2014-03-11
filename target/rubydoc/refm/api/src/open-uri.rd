category Network

#@# = open-uri

간단히 http/ftp에 접근하기 위한 클래스입니다.
[[m:Kernel.#open]]를 재정의합니다.

=== 예

http/ftp의 URL을 파일처럼 열 수 있습니다.

  require 'open-uri'
  open("http://www.ruby-lang.org/") {|f|
    f.each_line {|line| p line}
  }

開いたファイルオブジェクトは [[c:StringIO]] もしくは [[c:Tempfile]] で
すが [[c:OpenURI::Meta]] モジュールで拡張されていて、メタ情報を獲得する
メソッドが使えます。  open("http://www.ruby-lang.org/en") {|f|
    f.each_line {|line| p line}
    p f.base_uri         # <URI::HTTP:0x40e6ef2 URL:http://www.ruby-lang.org/en/>
    p f.content_type     # "text/html"
    p f.charset          # "iso-8859-1"
    p f.content_encoding # []
    p f.last_modified    # Thu Dec 05 02:45:02 UTC 2002
  }
해쉬 인수로 추가 헤더 필드를 지정할 수 있습니다.
  open("http://www.ruby-lang.org/en/",
    "User-Agent" => "Ruby/#{RUBY_VERSION}",
    "From" => "foo@bar.invalid",
    "Referer" => "http://www.ruby-lang.org/") {|f|
    ...
  기본적으로 http_proxy나 ftp_proxy 환경변수는 유효합니다.
프록시를 무효로 만드려면 :proxy => nil를 사용해주세요.
  open("http://www.ruby-lang.org/en/raa.html",
    :proxy => nil) {|f|
    ...
  }

また、open-uri を読み込むと [[c:URI::HTTP]] と [[c:URI::FTP]] が
[[c:OpenURI::OpenRead]] モジュールをインクルードします。ですので、
URI オブジェクトも似たような方法で開けます。  uri = URI.parse("http://www.ruby-lang.org/en/")
  uri.open {|f|
    ...
  }
URI オブジェクトは直接読み込むことができます。戻り値の文字列は、[[c:OpenURI::Meta]] で拡張されています。  str = uri.read
  p str.base_uri

= redefine Kernel

== Module Functions

--- open(name, mode = 'r', perm = nil, options = {})                -> StringIO | File
--- open(name, mode = 'r', perm = nil, options = {}) {|ouri| ...}   -> nil

name が http:// や ftp:// で始まっている文字列なら URI のリソースを
取得した上で [[c:StringIO]] オブジェクトとして返します。
StringIO オブジェクトは [[c:OpenURI::Meta]] モジュールで extend されています。

name に open メソッドが定義されている場合は、*rest を引数として渡し
name.open(*rest, &block) のように name の open メソッドが呼ばれます。

これ以外の場合は、name はファイル名として扱われ、従来の
[[m:Kernel.#open]](name, *rest) が呼ばれます。

ブロックを与えた場合は上の場合と同様、name が http:// や ftp:// で
始まっている文字列なら URI のリソースを取得した上で [[c:StringIO]] オブジェクトを
引数としてブロックを評価します。後は同様です。
StringIO オブジェクトは [[c:OpenURI::Meta]] モジュールで extend されています。

@param name オープンしたいリソースを文字列で与えます。

@param mode モードを文字列で与えます。[[m:Kernel.#open]] と同じです。

@param perm [[man:open(2)]] の第 3 引数のように、ファイルを生成する場合のファイルのパーミッションを
            整数で指定します。[[m:Kernel.#open]]와 같습니다.

@param options ハッシュを与えます。詳しくは [[m:OpenURI.open_uri]] を参照してください。

@raise OpenURI::HTTPError 対象となる URI のスキームが http であり、
                          かつリソースの取得に失敗した時に発生します。

@raise Net::FTPError 対象となる URI のスキームが ftp であり、かつリソースの取得に失敗した時に
                     [[c:Net::FTPError]] のサブクラスが発生します。자세한 내용은 [[lib:net/ftp]] 
                     을 참조해주세요.

예:
 
  require 'open-uri'
  sio = open('http://www.example.com')
  p sio.is_a?(OpenURI::Meta) # => true
  p sio.content_type
  puts sio.read

@see [[m:OpenURI.open_uri]]

= module OpenURI
간단히 http/ftp에 접근하기 위한 모듈입니다.

== Singleton Methods

--- open_uri(name, mode = 'r', perm = nil, options = {})                  -> StringIO
--- open_uri(name, mode = 'r', perm = nil, options = {}){|sio| ... }     -> nil

URI である文字列 name のリソースを取得して [[c:StringIO]] オブジェクト
として返します。

ブロックを与えた場合は [[c:StringIO]] オブジェクトを引数としてブロックを
評価します。ブロックの終了時に StringIO は close されます。nil을 반환힙니다.

  require 'open-uri'
  sio = OpenURI.open_uri('http://www.example.com')
  p sio.last_modified 
  puts sio.read
  
  OpenURI.open_uri('http://www.example.com'){|sio| sio.read }

options には [[c:Hash]] を与えます。理解するハッシュの
キーは以下の4つのシンボル、
 * :proxy
 * :progress_proc
 * :content_length_proc
 * :http_basic_authentication 
です。HTTP でのみ意味があります。「:content_length_proc」と「:progress_proc」はプログレスバーに
利用されることを想定しています。

  require 'open-uri'
  sio = OpenURI.open_uri('http://www.example.com',
                         { :proxy => 'http://proxy.example.com:8000/',
                           :http_basic_authentication => [usrname, password] })

: :proxy
 値には以下のいずれかを与えます。//emlist{
   文字列:           "http://proxy.foo.com:8000/" のようなプロクシの URI。   URI オブジェクト: URI.parse("http://proxy.foo.com:8000/") のようなプロクシの URI オブジェクト。   true:             Proxy を環境変数などから見つけようとする。   false:            Proxy を用いない。   nil:              Proxy を用いない。//}

: :http_basic_authentication
  HTTP の Basic 認証のためのユーザ名とパスワードを、文字列の配列 ["user", "password"] として与えます。

: :content_length_proc
 値にはブロックを与えます。ブロックは対象となる URI の
 Content-Length ヘッダの値を引数として、実際の転送が始まる前に評価されます。Redirect された場合は、
 実際に転送されるリソースの HTTP ヘッダを利用します。Content-Length ヘッダがない場合は、nil を
 引数としてブロックを評価します。ブロックの返り値は特に利用されません。 
: :progress_proc
 値にはブロックを与えます。ブロックは対象となる URI からデータの
 断片が転送されるたびに、その断片のサイズを引数として評価されます。ブロックの返り値は特に
 利用されません。

@param name オープンしたいリソースを文字列で与えます。

@param mode モードを文字列で与えます。[[m:Kernel.#open]] と同じです。

@param perm 無視されます。

@param options ハッシュを与えます。

@return 返り値である StringIO オブジェクトは [[c:OpenURI::Meta]] モジュールで extend されています。

@raise OpenURI::HTTPError 対象となる URI のスキームが http であり、
                          かつリソースの取得に失敗した時に発生します。

@raise Net::FTPError 対象となる URI のスキームが ftp であり、かつリソースの取得に失敗した時に 
                     [[c:Net::FTPError]] のサブクラスが発生します。자세한 내용은 [[lib:net/ftp]] 
                     을 참조해주세요.

@raise ArgumentError 与えられた mode が読み込みモードでなかった場合に発生します。

= module OpenURI::OpenRead 
[[c:URI::HTTP]] と [[c:URI::FTP]] を拡張するために用意されたモジュールです。


== Instance Methods

--- open(mode = 'r', perm = nil, options = {})                 -> StringIO
--- open(mode = 'r', perm = nil, options = {}){|sio| ... }     -> nil

自身が表すリソースを取得して [[c:StringIO]] オブジェクトとして返します。
[[m:OpenURI.open_uri]](self, *rest, &block) と同じです。

ブロックを与えた場合は [[c:StringIO]] オブジェクトを引数としてブロックを
評価します。ブロックの終了時に StringIO は close されます。nil을 반환힙니다.

返り値である StringIO オブジェクトは [[c:OpenURI::Meta]] モジュールで extend されています。

@param mode モードを文字列で与えます。[[m:Kernel.#open]] と同じです。

@param perm 無視されます。

@param options ハッシュを与えます。

@raise OpenURI::HTTPError 対象となる URI のスキームが http であり、かつリソースの取得に
                          失敗した時に発生します。

@raise Net::FTPError 対象となる URI のスキームが ftp であり、かつリソースの取得に失敗した時に 
                     [[c:Net::FTPError]] のサブクラスが発生します。자세한 내용은 [[lib:net/ftp]] 
                     을 참조해주세요.

@see [[m:OpenURI.open_uri]]

--- read(options = {})     -> String

自身が表す内容を読み込んで文字列として返します。
self.open(options={}).read と同じです。
このメソッドによって返される文字列は [[c:OpenURI::Meta]]
によって extend されています。

@param options ハッシュを与えます。

  require 'open-uri'
  uri = URI.parse('http://www.example.com/')
  str = uri.read
  p str.is_a?(OpenURI::Meta) # => true
  p str.content_type

= reopen URI::HTTP
include OpenURI::OpenRead

= reopen URI::FTP
include OpenURI::OpenRead

= module OpenURI::Meta
サーバから取得したデータの属性を扱うために使われるモジュールです。
データを表す文字列や [[c:StringIO]] が extend します。


== Instance Methods

--- last_modified    -> Time | nil

対象となる URI の最終更新時刻を [[c:Time]] オブジェクトで返します。
Last-Modified ヘッダがない場合は nil を返します。

예:
  require 'open-uri'
  p open('http://www.rubyist.net/').last_modified    
  #=> Thu Feb 26 16:54:58 +0900 2004

--- content_type    -> String

対象となるリソースの Content-Type を文字列の配列で返します。Content-Type ヘッダの情報が使われます。
Content-Type ヘッダがない場合は、"application/octet-stream" を返します。

예:

  require 'open-uri'
  p open('http://www.ruby-lang.org/').content_type  #=> "text/html"

--- charset       -> String | nil
--- charset{ ... }  -> String

対象となるリソースの文字コードを文字列で返します。Content-Type ヘッダの文字コード情報が使われます。
文字列は小文字へと変換されています。

Content-Type ヘッダがない場合は、nil を返します。ただし、ブロックが与えられている場合は、
その結果を返します。また対象となる URI のスキームが HTTP であり、自身のタイプが text である場合は、
[[RFC:2616]] 3.7.1 で定められているとおり、文字列 "iso-8859-1" を返します。

예:

  open("http://www.ruby-lang.org/en") {|f|
    p f.content_type  # => "text/html"
    p f.charset       # => "iso-8859-1"
  }

--- content_encoding    -> [String]

対象となるリソースの Content-Encoding を文字列の配列として返します。
Content-Encoding ヘッダがない場合は、空の配列を返します。

예:

  require 'open-uri'
  p open('http://example.com/f.tar.gz').content_encoding  #=> ["x-gzip"]

--- status    -> [String]

対象となるリソースのステータスコードと reason phrase を文字列の配列として返します。

예:
  require 'open-uri'
  p open('http://example.com/').status  #=> ["200", "OK"]
 
--- base_uri    -> URI

リソースの実際の URI を URI オブジェクトとして返します。
リダイレクトされた場合は、リダイレクトされた後のデータが存在する URI を返します。

예:

  require 'open-uri'
  p open('http://www.ruby-lang.org/').base_uri
  #=> #<URI::HTTP:0xb7043aa0 URL:http://www.ruby-lang.org/en/>

--- meta    -> Hash

ヘッダを収録したハッシュを返します。

예:

  require 'open-uri'
  p open('http://example.com/').meta
  #=> {"date"=>"Sun, 04 May 2008 11:26:40 GMT",
       "content-type"=>"text/html;charset=utf-8",
       "server"=>"Apache/2.0.54 (Debian GNU/Linux) mod_ssl/2.0.54 OpenSSL/0.9.7e",
       "transfer-encoding"=>"chunked"}

= class OpenURI::HTTPError < StandardError

リソースの取得に失敗した時に投げられます。
