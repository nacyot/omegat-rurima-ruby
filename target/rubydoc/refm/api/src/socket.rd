category Network

socket은 프로세스 외부와 통신(프로세스간 통신, 호스트간 통신)을 실현해줍니다.


=== 소켓 주소

소켓은 통신에 있어서 제일 끝부분에 해당합니다.
예를 들어 1대1 통신에선 우선 통신로의 양 끝에 각각 소켓을 만들고 두 소켓을 연결하면 상호간의 통신이 가능해집니다.
접속시에는 한 쪽에서 다른 한 족으로 소켓 위치를 알려줄 필요가 있는데 이 때 사용하는 게 소켓 주소입니다. 

소켓 주소는 소켓의 종류에 따라 다르게 구성되어있습니다.
예를 들어  TCP 에서는  IP 주소와 포트번호를 포함하며,
Unix 도메인 소켓은 소켓 파일을 가리키는 패스를 포함합니다.

#@since 1.9.1
소켓 주소를 다룰 수 있는 고수준 클래스 [[c:Addrinfo]] 가 있습니다.
#@end

[[c:IPSocket]] 및 [[c:UNIXSocket]] 아래의 클래스 계층에선
굳이 소켓 어드레스의 형식을 구성하지 않아도 되도록
소켓 어드레스 자체를 직접 다룰 수 잇는 메소드가 준비되어 있습니다.


또한 [[c:IPSocket]] 아래 계층에서 IP 주소나 포트 번호를 지정할 때는 
숫자 뿐만 아니라 호스트 이름이나 서비스 이름을 사용할 수 있습니다.
여기에 관해선 아래의 '호스트 지정 형식'과 '서비스 지정 형식'을 참조해주세요.

또한 C 레벨의 '소켓 어드레스 구조체를 pack한 문자열'도 사용할 수 있습니다.
주로 저레벨 소켓 인터페이스([[c:Socket]])에서 사용됩니다.

====[a:host_format] 호스트 지정 형식

TCP나 UDP와 같이 AF_INET에 해당하는 소켓에서는 호스트 지정을 아래와 같은 방법으로 할 수 있습니다.

  * 호스트 이름 (예: "localhost")
  * octet decimal로 표현된 IP 주소(문자열) (예: "127.0.0.1")
  * 빈 문자열 (""), 문자열 "<any>" - INADDR_ANY에 해당
  * 문자열 "<broadcast>" - INADDR_BROADCAST에 해당
  * IP 주소를 나타내는 32bit 정수 (例: 0x7f000001)

====[a:service_format] 서비스 지정 형식

서비스 지정은 아래와 같은 방법으로 할 수 있습니다.

  * 포트 번호(정수나 문자열) (例: 21, "21")
  * 서비스 이름 (예: "ftp")

====[a:pack_string] 소켓 주소 구조체를 pack한 문자열

소켓 주소 구조체란, C 언어의 구조체 struct sockaddr_in (IPv4)나 
struct sockaddr_un (Unix 도메인)을 의미합니다.
[[c:Socket]] 같은 클래스에서 저레벨 인터페이스에 사용합니다.

#@if (version >= "1.8.0")
[[m:Socket.pack_sockaddr_in]],
[[m:Socket.unpack_sockaddr_in]] 예를 들어 이러한 메소드를 통해
아래와 같은 문자열을 얻을 수 있습니다.

  require 'socket'
  p Socket.pack_sockaddr_in("echo", "127.0.0.1")
  => "\002\000\000\a\177\000\000\001\000\000\000\000\000\000\000\000"

#@else
ruby 1.6 이전에는 아래와 같이 [[m:Array#pack]] 을 사용할 수 있습니다.

  require 'socket'
  p [Socket::AF_INET,
     Socket.getservbyname('echo'),
     127, 0, 0, 1].pack("s n C4 x8")
  => "\002\000\000\a\177\000\000\001\000\000\000\000\000\000\000\000"
#@end

=== 호스트 이름과 IP 주소의 변환

호스트 이름을 IP 주소로 변환(DNS Lookup)하는 메소드는 다음과 같습니다.

#@since 1.9.1
  * [[m:Addrinfo.getaddrinfo]]("www.ruby-lang.org", "http") =>  [#<Addrinfo: 221.186.184.68:80 TCP (www.ruby-lang.org:http)>]
#@end
  * [[m:IPSocket.getaddress]]("www.ruby-lang.org") => "210.163.138.100"
  * [[m:TCPSocket.gethostbyname]]("www.ruby-lang.org") => ["beryllium.ruby-lang.org", [], 2, "210.163.138.100"]
  * [[m:Socket.gethostbyname]]("www.ruby-lang.org") => ["beryllium.ruby-lang.org", [], 2, "\322\243\212d"]
  * [[m:Socket.getaddrinfo]]("www.ruby-lang.org", "http") => [["AF_INET", 80, "beryllium.ruby-lang.org", "210.163.138.100", 2, 1, 6]]

반대로 IP 주소를 호스트 이름으로 변환(Reverse DNS Lookup)하는 메소드는 다음과 같습니다.

#@#* TCPSocket.gethostbyname("210.163.138.100") => ["210.163.138.100", [], 2, "210.163.138.100"]
#@#* Socket.gethostbyaddr(host[, type])
#@#* [[m:Socket.getnameinfo]]([Socket::AF_INET, "http", "210.163.138.100"]) => ["beryllium.ruby-lang.org", "www"]
  * [[m:Socket.getnameinfo]]([nil, nil, nil, "210.163.138.100"]) => ["beryllium.ruby-lang.org", 0]
  * [[m:Addrinfo#getnameinfo]] Addrinfo.ip("127.0.0.1").getnameinfo => ["localhost", "0"]


[[lib:resolv]] 라이브러리를 사용하는 방법도 있습니다.

#@include(socket/SocketError)
#@include(socket/BasicSocket)
#@include(socket/IPSocket)
#@include(socket/SOCKSSocket)
#@include(socket/Socket)
#@include(socket/Socket__Constants)
#@include(socket/TCPServer)
#@include(socket/TCPSocket)
#@include(socket/UDPSocket)
#@include(socket/UNIXServer)
#@include(socket/UNIXSocket)
#@since 1.9.1
#@include(socket/Addrinfo)
#@include(socket/Socket__UDPSource)
#@end
#@since 1.9.2
#@include(socket/Socket__AncillaryData)
#@include(socket/Socket__Option)
#@end
