#@since 1.9.1

Base64 エンコード / デコードを行うメソッドを定義したモジュールを提供するライブラリです。

Base64 は、3 オクテット (8bits * 3 = 24bits) のバイナリコードを
ASCII 文字のうちの 65 文字 ([A-Za-z0-9+/] の 64 文字と '=')
だけを使用して 4 オクテット (6bits * 4 = 24bits)
の印字可能文字列に変換するエンコーディング法です。[[RFC:2045]], [[RFC:4648]]에 정의되어있습니다.

このライブラリは 1.8 系統に添付されていた base64 ライブラリとは違います。
もはやサンプルスクリプトではありません。

=== 사용 방법

   require "base64"

   enc   = Base64.encode64('Send reinforcements')
                       # => "U2VuZCByZWluZm9yY2VtZW50cw==\n"
   plain = Base64.decode64(enc)
                       # => "Send reinforcements"


データをエンコードするために Base64 エンコードを使用するのは、あらゆるバイナリデータを
表示可能な文字列に変換するためです。

#@else

MIME Base64のデコード/エンコードを行うメソッドが定義されています。
このライブラリは Base64 エンコーディングの
サンプルスクリプトとして書かれました。

Base64 は、3 オクテット (8bits * 3 = 24bits) のバイナリコードを
ASCII 文字のうちの 65 文字 ([A-Za-z0-9+/] の 64 文字と '=')
だけを使用して 4 オクテット (6bits * 4 = 24bits)
の印字可能文字列に変換するエンコーディング法です。[[RFC:2045]]에 정의되어있습니다.

=== 사용 방법

  require 'base64'
  # EUC-JP의 경우
  p Base64.b64encode("日本語")      # => "xvzL3Ljs\n"
  p Base64.decode64('xvzL3Ljs')    # => "日本語"
  p Base64.decode_b("한국어")       # => "한국어"
  p Base64.decode_b("C 언어 포인터 완전 정복")
                             # => "C 언어 포인터 완전 정복"

#@end

#@include(base64/Base64)
