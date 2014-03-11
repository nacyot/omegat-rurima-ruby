require webrick/httpversion
require webrick/httputils
require webrick/utils
require webrick/log

= module WEBrick::Config

설정들의 기본값을 가지고 있는 모듈입니다.

#@#== Constants

--- General -> Hash

[[c:WEBrick::GenericServer]] 의 기본설정값을 가진 해쉬입니다.

  WEBrick::Config::General = {
    :ServerName     => Utils.getservername,
    :BindAddress    => nil,   # "0.0.0.0" or "::" or nil
    :Port           => nil,   # users MUST specify this!!    :MaxClients     => 100,   # maximum number of the concurrent connections
    :ServerType     => nil,   # default: WEBrick::SimpleServer
    :Logger         => nil,   # default: WEBrick::Log.new
    :ServerSoftware => "WEBrick/#{WEBrick::VERSION} " +
                       "(Ruby/#{RUBY_VERSION}/#{RUBY_RELEASE_DATE})",
    :TempDir        => ENV['TMPDIR']||ENV['TMP']||ENV['TEMP']||'/tmp',
    :DoNotListen    => false,
    :StartCallback  => nil,
    :StopCallback   => nil,
    :AcceptCallback => nil,
    :DoNotReverseLookup => nil,
  }

--- HTTP -> Hash

[[c:WEBrick::HTTPServer]] 의 기본설정값을 가진 해쉬입니다.

  WEBrick::Config::HTTP = {
    :ServerName     => Utils.getservername,
    :BindAddress    => nil,   # "0.0.0.0" or "::" or nil
    :Port           => 80,
    :MaxClients     => 100,   # maximum number of the concurrent connections
    :ServerType     => nil,   # default: WEBrick::SimpleServer
    :Logger         => nil,   # default: WEBrick::Log.new
    :ServerSoftware => "WEBrick/#{WEBrick::VERSION} " +
                       "(Ruby/#{RUBY_VERSION}/#{RUBY_RELEASE_DATE})",
    :TempDir        => ENV['TMPDIR']||ENV['TMP']||ENV['TEMP']||'/tmp',
    :DoNotListen    => false,
    :StartCallback  => nil,
    :StopCallback   => nil,
    :AcceptCallback => nil,
    :DoNotReverseLookup => nil,

    :RequestTimeout => 30,
    :HTTPVersion    => HTTPVersion.new("1.1"),
    :AccessLog      => nil,
    :MimeTypes      => HTTPUtils::DefaultMimeTypes,
    :DirectoryIndex => ["index.html","index.htm","index.cgi","index.rhtml"],
    :DocumentRoot   => nil,
    :DocumentRootOptions => { :FancyIndexing => true },
    :RequestCallback => nil,
    :ServerAlias    => nil,

    :CGIInterpreter => nil,
    :CGIPathEnv     => nil,

    :Escape8bitURI  => false
  }

--- FileHandler -> Hash

[[c:WEBrick::HTTPServlet::FileHandler]] 의 기본 설정값을 가진 해쉬입니다.

    WEBrick::Config::FileHandler = {
      :NondisclosureName => [".ht*", "*~"],
      :FancyIndexing     => false,
      :HandlerTable      => {},
      :HandlerCallback   => nil,
      :DirectoryCallback => nil,
      :FileCallback      => nil,
      :UserDir           => nil,  # e.g. "public_html"
      :AcceptableLanguages => []  # ["en", "ja", ... ]
    }

: :AcceptableLanguages

컨텐츠의 언어를 선택하는 옵션.설정값은 문자열로 구성된 배열.

클라이언트에서 보내온 요청에 포함된 Accept-Language 값이 fr이고 AcceptableLanguages에는['ja', 'en']이 설정되어있으면 WEBrick::HTTPServlet::FileHandler는 아래의 순서로 파일을 찾습니다.
  (1) index.html
  (2) index.html.fr
  (3) index.html.ja
  (4) index.html.en

: :FancyIndexing
boolean 값.

trueならば、代わりにファイル一覧を表示する。
falseならばエラー(403 Forbidden)となる。

: :DirectoryCallback
: :FileCallback
: :HandlerCallback
: :HandlerTable
: :NondisclosureName
インデックスに表示したくないファイルの指定。値は文字列の配列。
表示したくないファイルをワイルドカードで指定する。

: :UserDir
ユーザ毎のドキュメントルートのディレクトリ名。値は文字列。

ユーザfooのホームディレクトリが/home/fooで、:UserDirにpublic_htmlを設定した場合、
クライアントから/~foo/index.htmlがリクエストされると/home/foo/public_html/index.htmlの内容を表示される。

この設定を有効にするには以下の条件が必要。  * [[lib:etc]]ライブラリが使える状態である。  * 環境変数 SCRIPT_NAME が空(空文字列)である。

--- BasicAuth -> Hash

[[c:WEBrick::HTTPAuth::BasicAuth]] の設定のデフォルト値を保持したハッシュです。

    WEBrick::Config::BasicAuth = {
      :AutoReloadUserDB     => true,
    }

--- DigestAuth -> Hash

[[c:WEBrick::HTTPAuth::DigestAuth]] の設定のデフォルト値を保持したハッシュです。

    WEBrick::Config::DigestAuth = {
      :Algorithm            => 'MD5-sess', # or 'MD5'
      :Domain               => nil,        # an array includes domain names.
      :Qop                  => [ 'auth' ], # 'auth' or 'auth-int' or both.
      :UseOpaque            => true,
      :UseNextNonce         => false,
      :CheckNc              => false,
      :UseAuthenticationInfoHeader => true,
      :AutoReloadUserDB     => true,
      :NonceExpirePeriod    => 30*60,
      :NonceExpireDelta     => 60,
      :InternetExplorerHack => true,
      :OperaHack            => true,
    }

--- LIBDIR -> String

이 파일이 있는 디렉토리의 경로를 리턴합니다.

