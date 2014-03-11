category Text

#@since 1.8.6
require digest/md5
require digest/rmd160
require digest/sha1
require digest/sha2
#@end

메세지 digest  라이브러리 입니다.

[[c:Digest::MD5]] 이나 [[c:Digest::SHA1]] 의
모든 메세지 digest의 구현클래스는
기저 클래스인 [[c:Digest::Base]]와 같은 인터페이스를 가집니다.
기본적인 사용법은 MD5나 SHA1 어떤 알고르즘을 사용하건 같습니다.
자세한 사항은 [[c:Digest::Base]] 를 참조해주세요

또한 메시지 digest란, 데이터로부터 고정길이의 임의난수를 생성하는 연산방법입니다.

= module Digest

#@since 1.8.6
== Module Functions

--- hexencode(string) -> String

주어진 문자열에 대응하는 해쉬값을 ASCII코드를 사용해 16진수를 사용하는 문자열로 인코딩합니다.

@param string 해쉬값의 생성대상은 문자열입니다.

사용예(MD5의 경우)

        require 'digest/md5'
        Digest::MD5.hexdigest("ruby") # => "58e53d1324eef6265fdb97b08ed9aadf"

@see [[m:Digest::Base#hexdigest]]

#@end

#@if(version >= "1.8.6")
= class Digest::Class < Object

= module Digest::Instance

= class Digest::Base < Digest::Class
include Digest::Instance

#@else
= class Digest::Base < Object

#@end

모든 Digest:XXX 클래스의 부모 클래스입니다.

예를 들어 MD5 값이 필요한 경우 아래와 같이 사용합니다.
#@if(version >= "1.8.6")
  require 'digest/md5'

  p Digest::MD5.hexdigest('abc')               #=> '900150983cd24fb0d6963f7d28e17f72'
  p Digest::MD5.file('ruby-1.8.5.tar.gz').to_s #=> '3fbb02294a8ca33d4684055adba5ed6f'
#@else
        require 'digest/md5'
        p Digest::MD5.hexdigest(File.open('ruby-1.8.5.tar.gz','rb').read)

        # => "3fbb02294a8ca33d4684055adba5ed6f"

또는(큰 문자열을 생성하지 않는 방법)

        require 'digest/md5'

        class Digest::Base
          def self.open(path)
            obj = new

            File.open(path, 'rb') {|f|
              buf = ""
              while f.read(256, buf)
                obj << buf
              end
            }
            obj
          end
        end

        p Digest::MD5.open("ruby-1.8.5.tar.gz").hexdigest

        # => "3fbb02294a8ca33d4684055adba5ed6f"
#@end

모든 Digest::XXX 클래스는 아래와 같은 공통 인터페이스를 가집니다.


== Class Methods

#@until 1.8.6
--- new(str = nil) -> Digest::Base

새로운 digest 객체를 생성합니다.str에 문자열 인수가 주어지면
문자열을 추가합니다.([[m:Digest::Base#update]] 참조)。#@else
--- new            -> Digest::Base
새로운 암호화 객체를 생성합니다.
#@end

--- digest(str) -> String

주어진 문자열에 대한 해쉬값을 문자열로 리턴합니다.
new(str).digest と等価です。

--- hexdigest(str) -> String

주어진 문자열에 대한 해쉬값을 ASCII 코드를 사용해서
16진수로 구성된 문자열로 인코드해서 리턴합니다.
new(str).hexdigest와 같습니다.

#@since 1.8.6
--- file(path) -> object

새로운 암호화 객체를 만들고
path에 지정한 파일 내용을 읽어와 이 내용에 대한
암호화 객체를 리턴합니다.

@param path 읽어올 파일의 경로입니다.
@return 암호화 객체를 리턴합니다.

SHA256를 사용하는 예

        digest = Digest::SHA256.file("X11R6.8.2-src.tar.bz2")
        digest.hexdigest
        # => "f02e3c85572dc9ad7cb77c2a638e3be24cc1b5bea9fdbb0b0299c9668475c534"
#@end


== Instance Methods

--- dup   -> Digest::Base
--- clone -> Digest::Base

암호화 객체를 복사합니다.

--- digest -> String

update 함수나 << 연산자로 추가한 문자열에 대한 해쉬값을 문자열로 리턴합니다.

리턴하는 문자열의 길이는 MD5는 16바이트, SHA1와 RMD160는 20 바이트
SHA256는 32바이트, SHA384는 48바이트, SHA512는 64바이트입니다.

예:

  # MD5를 사용하는 예
  require 'digest/md5'
  digest = Digest::MD5.new
  digest.update("ruby")
  p digest.digest # => "X\345=\023$\356\366&_\333\227\260\216\331\252\337"

@see [[m:Digest::Base#hexdigest]]

#@since 1.8.6
--- digest!-> String

update 함수나 << 연산자로 추가한 문자열에 대한 해쉬값을 문자열로 리턴합니다.
[[m:Digest::Base#digest]] 메소드와 달리
메소드를 실행한 후에
객체를 new 생성한 직후의 초기상태로 되돌립니다.


리턴하는 문자열의 길이는 MD5는 16바이트, SHA1와 RMD160는 20 바이트
SHA256는 32바이트, SHA384는 48바이트, SHA512는 64바이트입니다.

예:

  # MD5를 사용하는 예
  require 'digest/md5'
  digest = Digest::MD5.new
  digest.update("ruby")
  p digest.digest!# => "X\345=\023$\356\366&_\333\227\260\216\331\252\337"
  p digest.digest!# => "\324\035\214\331\217\000\262\004\351\200\t\230\354\370B~"

@see [[m:Digest::Base#digest]]、[[m:Digest::Base#hexdigest!]]

#@end

--- hexdigest -> String
--- to_s -> String

update 함수나 << 연산자로 추가한 문자열에 대한 해쉬값을 
ASCII코드를 사용해 16진수를 사용하는 문자열로 인코딩합니다.

리턴하는 문자열의 길이는
MD5는 32바이트、SHA1와 RMD160는 40바이트, SHA256는 64바이트,
SHA384는 96바이트, SHA512는 128바이트입니다.

아래와 같이 사용합니다.

  def hexdigest
    digest.unpack("H*")[0]
  end

예:

  # MD5를 사용하는 예
  require 'digest/md5'
  digest = Digest::MD5.new
  digest.update("ruby")
  p digest.hexdigest # => "58e53d1324eef6265fdb97b08ed9aadf"

@see [[m:Digest::Base#digest]]

#@since 1.8.6
--- hexdigest!-> String

update 함수나 << 연산자로 추가한 문자열에 대한 해쉬값을 
ASCII코드를 사용해 16진수를 사용하는 문자열로 인코딩합니다.
[[m:Digest::Base#digest]] 메소드와 달리
메소드를 실행한 후에
객체를 new로 생성한 직후의 초기상태로 되돌립니다.

예:

  # MD5를 사용하는 예
  require 'digest/md5'
  digest = Digest::MD5.new
  digest.update("ruby")
  p digest.hexdigest!# => "58e53d1324eef6265fdb97b08ed9aadf"
  p digest.hexdigest!# => "d41d8cd98f00b204e9800998ecf8427e"

@see [[m:Digest::Base#hexdigest]]、[[m:Digest::Base#digest!]]

#@end

--- update(str) -> self
--- <<(str)     -> self

문자열을 추가합니다.self를 리턴합니다.
한 번에 긴 문자열을 update하는 것이나 문자열을 나눠서 update를 여러번 실행하는 것이나 같습니다.
예를 들어 m.update(a); m.update(b)는
m.update(a + b)나 m << a << b は m << a + b 와 같은 표현입니다.

@param str 추가하려는 문자열

        require 'digest/md5'

        digest = Digest::MD5.new
        digest.update("r")
        digest.update("u")
        digest.update("b")
        digest.update("y")
        p digest.hexdigest # => "58e53d1324eef6265fdb97b08ed9aadf"

        digest = Digest::MD5.new
        digest << "r"
        digest << "u"
        digest << "b"
        digest << "y"
        p digest.hexdigest # => "58e53d1324eef6265fdb97b08ed9aadf"

--- ==(md)  -> bool

self와 md(암호화 객체)가 같은지 비교합니다.

@param md 비교하려는 암호화 객체

        require 'digest/md5'
        digest1 = Digest::MD5.new
        digest1.update("ruby")
        digest2 = Digest::MD5.new
        digest2.update("ruby")
        p digest1 == digest2 # => true
        [fuzzy]digest2.update("ruby")digest2.update("RUBY")
        p digest1 == digest2 # => false

--- ==(str) -> bool

#@if(version >= "1.8.6")
주어진 str을 hexdigest 값으로 보고 self와 hexdigest 값을 비교합니다.

@param str 比較対象の hexdigest 文字列
#@else
与えられた文字列を digest 値、もしくは hexdigest 値と比較します。
いずれの値と見るかは与えられた文字列の長さによって自動判別
されます。

@param str 비교하려는 암호화된 문자열을 지정합니다.
#@end

        require 'digest/md5'
        digest = Digest::MD5.new
        digest.update("ruby")
        p digest == "58e53d1324eef6265fdb97b08ed9aadf" # => true

#@since 1.8.6
--- file(path) -> self

ファイル名 file で指定したファイルの内容を読み込んでダイジェストを更新し、
オブジェクト自身を返します。

@param path 읽어올 파일의 경로입니다.
@return 암호화 객체를 리턴합니다.

MD5 예

  require 'digest/md5'
  digest = Digest::MD5.new
  digest.file("/path/to/file") # => Digest::MD5의 인스턴스
  digest.hexdigest # => "/path/to/file"의 MD5 값

--- block_length -> Integer

암호화 블록의 길이를 리턴합니다.
예를 들어 Digest::MD5면 64、Digest::SHA512면 128입니다.

本メソッドは、Digest::MD5などのダイジェストのサブクラスにより、
それぞれの実装に適したものにオーバーライドされます。

例: Digest::MD、Digest::SHA1、Digest::SHA512のブロック長を順番に調べる。

  ["MD5", "SHA1", "SHA512"].map{|a| Digest(a).new().block_length } # => [64, 128, 128]

--- digest_length -> Integer
--- length -> Integer
--- size -> Integer

암호화 해쉬의 바이트 길이를 리턴합니다.
예를 들어 Digest::MD5는 16, Digest::SHA1는 20입니다.

本メソッドは、Digest::MD5などのダイジェストのサブクラスにより、
それぞれの実装に適したものにオーバーライドされます。

例: Digest::MD、Digest::SHA1、Digest::SHA512のハッシュ値のバイト長を順番に調べる。

  ["MD5", "SHA1", "SHA512"].map{|a| Digest(a).new().digest_length } # => [16, 20, 64]

#@end

--- reset -> self

オブジェクトの状態を初期状態(newした直後と同様の状態)に戻し、
オブジェクト自身を返します。

本メソッドは、Digest::MD5などのダイジェストのサブクラスにより、
それぞれの実装に適したものにオーバーライドされます。

#@since 1.8.6
= reopen Kernel
== Private Instance Methods
--- Digest(name) -> object

"MD5"や"SHA1"などのダイジェストを示す文字列 name を指定し、
対応するダイジェストのクラスを取得します。

@param name "MD5"や"SHA1"などのダイジェストを示す文字列を指定します。
@return Digest::MD5やDigest::SHA1などの対応するダイジェストのクラスを返します。インスタンスではなく、クラスを返します。注意してください。

例: Digest::MD、Digest::SHA1、Digest::SHA512のクラス名を順番に出力する。

  for a in ["MD5", "SHA1", "SHA512"]
    p Digest(a) # => Digest::MD5, Digest::SHA1, Digest::SHA512
  end

#@end
