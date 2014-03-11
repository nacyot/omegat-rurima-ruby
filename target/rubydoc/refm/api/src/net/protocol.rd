category Network

ネットワークライブラリ共通の例外クラスを
定義しています。このライブラリで定義された例外は
直接は利用されません。実際に発生する例外は
それらを継承したものです。

[[lib:net/http]] や [[lib:net/pop]] などでこのライブラリで
定義された例外クラスを継承した例外クラスを
利用しています。

= class Net::ProtocolError < StandardError
ネットワークプロトコル上のエラーが起きた場合に
発生する例外です。

= class Net::ProtoSyntaxError < Net::ProtocolError
プロトコル上の文法が正しくない場合に発生する
例外です。

Rubyの現在の標準添付ライブラリ内では使われていません。

= class Net::ProtoFatalError < Net::ProtocolError
サーバへのリクエストが間違っているなど、致命的エラーの
場合に発生するエラーです。

= class Net::ProtoUnknownError < Net::ProtocolError
サーバからのレスポンスが解釈できないなど、不明のエラーが
出た場合に発生する例外です。

= class Net::ProtoServerError < Net::ProtocolError
サーバー側の問題により要求が達成できない場合に
発生する例外です。

= class Net::ProtoAuthError < Net::ProtocolError
認証に問題があった場合に発生する例外です。

= class Net::ProtoCommandError < Net::ProtocolError
Rubyの現在の標準添付ライブラリ内では使われていません。

= class Net::ProtoRetriableError < Net::ProtocolError
alias Net::ProtocRetryError
なんらかの再試行をすることで、処理の継続が可能であるような
エラーが発生した場合に発生する例外です。
