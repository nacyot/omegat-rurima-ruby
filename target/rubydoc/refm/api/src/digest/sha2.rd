require digest

FIPS PUB 180-2에 나와있는 NIST (the US' National Institute of
Standards and Technology)의 다음과 같은 알고리즘을 구현한 라이브러리입니다.

  * SHA-256 Secure Hash Algorithm
  * SHA-384 Secure Hash Algorithm
  * SHA-512 Secure Hash Algorithm

= class Digest::SHA256 < Digest::Base

FIPS PUB 180-2에 나와있는 NIST (the US' National Institute of
Standards and Technology)의 SHA-256 Secure Hash 알고리즘을 구현한 클래스입니다.


= class Digest::SHA384 < Digest::Base

FIPS PUB 180-2에 나와있는 NIST (the US' National Institute of
Standards and Technology)의 SHA-384 Secure Hash 알고리즘을 구현한 클래스입니다.


= class Digest::SHA512 < Digest::Base

FIPS PUB 180-2에 나와있는 NIST (the US' National Institute of
Standards and Technology)의 SHA-512 Secure Hash 알고리즘을 구현한 클래스입니다.

#@since 1.8.6
= class Digest::SHA2 < Digest::Class
== Class Methods
--- new(bitlen = 256) -> Digest::SHA2

주어진 bitlen에 상응하는 SHA2 해쉬를 생성하는 객체를 지정하고 초기화합니다.

@param bitlen 해쉬의 길이를 지정합니다.256, 384, 512 중에 한 숫자를 선택할 수 있습니다.

@raise ArgumentError bitlen 에 256, 384, 512 이외의 값을 대입했을 때 발생합니다.


== Instance Methods

--- block_length -> Integer

Digest의 블럭길이를 리턴합니다.

--- digest_length -> Integer

digest 해쉬값의 바이특 리이를 리턴합니다.

#@end
