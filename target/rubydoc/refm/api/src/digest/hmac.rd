require digest

해쉬 기반 메시지 인증 알고리즘의 구현을 제공하는 라이브러리입니다. @@@

이 라이브러리는 아직 실험적인 구현 단계이므로 [[lib:openssl]]에 포함된 [[c:OpenSSL::HMAC]]을 사용해주세요.

HMAC은 [[RFC:2104]]에 정의되어있습니다.

=== 예

  require 'digest/hmac'

  # one-liner example
  puts Digest::HMAC.hexdigest("data", "hash key", Digest::SHA1)

  # rather longer one
  hmac = Digest::HMAC.new("foo", Digest::RMD160)

  buf = ""
  while stream.read(16384, buf)
    hmac.update(buf)
  end

  puts hmac.bubblebabble

= class Digest::HMAC < Digest::Class

해쉬 기반 메시지 인증 알고리즘의 구현을 제공하는 클래스입니다.


== Class Methods

--- new(key, digester) -> Digest::HMAC

주어진 key와 digester 알고리즘을 사용해 초기화합니다.

@param key 비밀키를 지정합니다.

@param digester 암호화 알고리즘을 담고있는 클래스를 지정합니다.


== Instance Methods

--- block_length -> Integer

Digest의 블럭길이를 리턴합니다.

--- digest_length -> Integer

digest 해쉬값의 바이특 리이를 리턴합니다.

#@#--- update(text)
#@# maybe nodoc

#@#--- reset
#@# maybe nodoc

#@#--- inspect
#@# maybe nodoc
