net/ftp に TLS 拡張を実装するライブラリです。

[[RFC:4217]] で定義されている FTP over SSL/TLS (FTPS) を実装しています。
コントロールコネクションを SSL/TLS で暗号化します。

RFCではデータコネクションを TLS で暗号化する機能が定義されていますが、
このライブラリでは実装されていません。

また、SSL/TLS 接続の各パラメータを変更する方法はありません。

上記の問題などより、このライブラリは 1.9.1 以降廃止されます。

= class Net::FTPTLS < Net::FTP
FTP over SSL/TLS を実装したクラスです。

[[c:Net::FTP]] を継承しているため、FTP クラスのメソッドが利用できます。


== Instance Methods

#@since 1.8.6
--- connect(host, port=Net::FTP::FTP_PORT) -> ()
host で指定されたホストに接続します。

[[m:Net::FTP#connect]] とは、発生する例外も含めほぼ同じです。

@param host 접속하려는 호스트를 지정합니다.
@param port 접속하려는 포트 번호를 지정합니다.
@see [[m:Net::FTP#connect]]

#@end

--- login(user = "anonymous", passwd = nil, acct = nil) -> ()
호스트에 로그인합니다.

ログインの前に SSL/TLS で暗号化通信を開始します。その他は
[[m:Net::FTP#login]] と同様です。

@param user 로그일을 시도할 경우 사용자명을 지정합니다.
@param passwd 로그인을 시도할 경우 패스워드를 지정합니다.
@param acct 로그인 다음에 보내는 ACCT 명령어의 인수를 지정합니다.
@see [[m:Net::FTP#login]]



