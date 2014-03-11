category Network

FTP 프로토콜을 다루는 라이브러리입니다.

기본적으로 unix의 ftp 명령어 처럼
command-line interface의 FTP 클라이언트를 경험해본 사람에게는
매우 이해하기 쉬운 인터페이스를 가지고 있습니다.
또한 더 Ruby스러운 인터페이스도 마련되어 있습니다.

FTP에 관해선 [[RFC:959]], [[RFC:3659]]를 참조해주세요.

=== 바이너리 모드와 텍스트 모드
FTP의 데이터 전송은 바이너리 모드나 텍스트 모드로 이루어집니다.텍스트 모드로 전송하는 줄바꿈을 적절히 CRLF로 변환합니다.바이너리 모드에선 어떠한 변환도 이루어지지 않습니다.

일반적으로 바이너리 모드를 사용합니다.

[[m:Net::FTP#get]]와 [[m:Net::FTP#put]] 메소드는
[[m:Net::FTP#binary]]의 값에 의해 텍스트 모드를 사용할 지
바이너리 모드를 사용할 지 결정됩니다.또한 
[[m:Net::FTP#getbinaryfile]]와 [[m:Net::FTP#putbinaryfile]]
메소드는 [[m:Net::FTP#binary]] 값에 상관없이 바이너리 모드로 전송이 이루어지며[[m:Net::FTP#gettextfile]]와 [[m:Net::FTP#puttextfile]] 메소드는
[[m:Net::FTP#binary]] 값에 상관없이 텍스트 모드로 전송됩니다.

=== 패시브 모드와 엑티브 모드
FTP는 파일 전송과 디렉토리 정보 취즉을 위한 데이터 전송용 TCP 연결과
서버를 제어하는 명령어를 다루기 위한 연결을 별개로 생성합니다.

이 데이터 전송용 연결을 생성할 때 엑티브 모드에서는
서버 쪽에서 클라이언트 쪽으로 연결을 만들며,
패시브 모드에서는 클라이언트 쪽에서 서버 쪽으로 연결을 만듭니다.

따라서 엑티브 모드에서는 서버와 클라이언트 사이의 통신이 
방화벽이나 NAT에 의해 제한되는 경우가 있습니다.이런 경우엔 패시브 모드를 사용해주세요.

=== 예

예1:
  require 'net/ftp'
  ftp = Net::FTP.new('ftp.example.org')
  ftp.login
  ftp.passive = true
  ftp.chdir('pub/ruby')
  files = ftp.list('ruby*')
  ftp.getbinaryfile('ruby-1.9.1-p243.tar.bz2', 'ruby.bz2', 1024)
  ftp.close

예2:
  require 'net/ftp'
  Net::FTP.open('ftp.example.org') do |ftp|
    ftp.login
    ftp.passive = true
    ftp.chdir('pub/ruby')
    files = ftp.list('*.bz2')
    ftp.getbinaryfile('ruby-1.9.1-p243.tar.bz2', 'ruby.bz2', 1024)
  end

= class Net::FTP < Object
FTP을 구현한 클래스입니다.



== Class Methods

--- new(host = nil, user = nil, passwd = nil, acct = nil) -> Net::FTP

새로운 Net::FTP 인스턴트를 생성합니다.

host가 지정되어있는 경우 생성된 인스턴트에 대해서
[[m:Net::FTP#connect]] 메소드를 호출하며 user가 함께 지정된 경우엔 [[m:Net::FTP#login]] 메소드를 호출합니다.

@param host 접속하려는 호스트를 지정합니다.
@param user 로그일을 시도할 경우 사용자명을 지정합니다.
@param passwd 로그인을 시도할 경우 패스워드를 지정합니다.
@param acct 로그인 다음에 보내는 ACCT 명령어의 인수를 지정합니다.

@see [[m:Net::FTP.open]]

--- open(host, user = nil, passwd = nil, acct = nil) -> Net::FTP
--- open(host, user = nil, passwd = nil, acct = nil){|ftp| ... } -> object

새로운 Net::FTP 인스턴트를 생성합니다.

[[m:Net::FTP.new]]와는 달리 host를 생략할 수 없습니다.

블록이 넘겨지는 경우 생산된 인스턴트를 블록에 넘겨 호출합니다.이 때 블록이 종료 될 [[m:Net::FTP#close]]를 호출하며
블록의 값을 반환합니다.

블록을 넘기지 않는 경우엔 생성된 인스턴트를 반환합니다.

user가 지정되지 않는 경우엔 [[m:Net::FTP#login]]를 호출합니다.

@param host 접속하려는 호스트를 지정합니다.
@param user 로그일을 시도할 경우 사용자명을 지정합니다.
@param passwd 로그인을 시도할 경우 패스워드를 지정합니다.
@param acct 로그인 다음에 보내는 ACCT 명령어의 인수를 지정합니다.

@raise Net::FTPTempError 응답 코드가 4yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 5yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 RFC에 의거해 정상적이지 않을 경우 발생합니다.
@raise Net::FTPReplyError 응답 코드가 위에 열거한 경우 이외에 올바르지 않은 경우에 발생합니다.


== Instance Methods

--- connect(host, port = FTP_PORT) -> ()

지정한 host로 접속합니다.

환경변수 SOCK_SERVER가 지정되어있지 않은 경우 SOCKS 프록시를 통해 접속이 이루어집니다.

#@since 1.9.2
이 메소드를 호출하기 전에 통신을 시도하면
[[c:Net::FTPConnectionError]] 예외가 발생합니다.
#@end

@param host 접속하려는 호스트를 지정합니다.
@param port 접속하려는 포트 번호를 지정합니다.

@raise Net::FTPTempError 응답 코드가 4yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 5yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 RFC에 의거해 정상적이지 않을 경우 발생합니다.
@raise Net::FTPReplyError 응답 코드가 위에 열거한 경우 이외에 올바르지 않은 경우에 발생합니다.

--- sendcmd(cmd) -> String
cmd에 지정한 명령어를 서버로 보내며
서버가 보내온 응답을 리턴합니다.

@param cmd 명령어를 문자열로 지정합니다.

@raise Net::FTPTempError 응답 코드가 4yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 5yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 RFC에 의거해 정상적이지 않을 경우 발생합니다.


cmd로 지정한 명령어를 서버에 보냅니다.

@param cmd 명령어를 문자열로 지정합니다.

@raise Net::FTPReplyError 응답 코드가 2yz 이외인 경우에 발생합니다.

--- login(user = "anonymous", passwd = nil, acct = nil) -> ()
호스트에 로그인합니다.

이 메소드는 호스트에 접속이 된 이후에만 사용할 수 있습니다.

user, passwd가 생략된 경우 사용자명은
 "anonymous", 패스워드는 user@host가 지정됩니다.

acct 인수가 있는 경우엔 ACCT 명령어를
acct에 지정한 값을 인수로 보냅니다.

@param user 로그일을 시도할 경우 사용자명을 지정합니다.
@param passwd 로그인을 시도할 경우 패스워드를 지정합니다.
@param acct 로그인 다음에 보내는 ACCT 명령어의 인수를 지정합니다.

@raise Net::FTPTempError 응답 코드가 4yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 5yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 RFC에 의거해 정상적이지 않을 경우 발생합니다.
@raise Net::FTPReplyError 응답 코드가 위에 열거한 경우 이외에 올바르지 않은 경우에 발생합니다.

--- retrbinary(cmd, blocksize, rest_offset = nil) -> nil
--- retrbinary(cmd, blocksize, rest_offset = nil){|data| ...} -> nil

서버에 cmd로 지정된 명령어를 보내며 바이너리 데이터를 받아옵니다.

blocksize에 지정한 바이트 단위로 읽어와 블록을 기록합니다.

rest_offset 인수가 있는 경우엔 cmd 명령어를 보내기 전에
REST 명령어를 보내며 지정한 위치에서 부터
전송을 시작합니다.

@param cmd 명령어를 문자열로 지정합니다.
@param blocksize 읽어올 블록 단위를 바이트 단위로 지정합니다.
@param rest_offset REST 명령어에 지정할 옵셋을 지정합니다.

@raise Net::FTPTempError 응답 코드가 4yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 5yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 RFC에 의거해 정상적이지 않을 경우 발생합니다.
@raise Net::FTPReplyError 응답 코드가 위에 열거한 경우 이외에 올바르지 않은 경우에 발생합니다.

@see [[m:Net::FTP#getbinaryfile]]

--- retrlines(cmd){|line| ...} -> nil
서버에 cmd에 지정된 명령어를 보내며 텍스트 데이터를 받아옵니다.

한 행 씩 텍스트를 읽어오며 블록에 기록합니다.

@param cmd 명령어를 문자열로 지정합니다.

@raise Net::FTPTempError 응답 코드가 4yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 5yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 RFC에 의거해 정상적이지 않을 경우 발생합니다.
@raise Net::FTPReplyError 응답 코드가 위에 열거한 경우 이외에 올바르지 않은 경우에 발생합니다.

@see [[m:Net::FTP#gettextfile]]

--- storbinary(cmd, file, blocksize, rest_offset = nil) -> nil
--- storbinary(cmd, file, blocksize, rest_offset = nil){|data| ...} -> nil
서버에 cmd에 지정된 명령어를 보내며, 바이너리 데이터를
보냅니다.

보내는 데이터는 [[c:IO]]의 인스턴트를 file로 지정합니다.
([[c:StringIO]]와 같이 IO와 메소드 레벨에서
호환되는 객체면 어떤 객체든 상관없습니다.)

blocksize로 지정된 바이트 단위로 file에서 데이터를 읽어와
서버에 전송합니다.

rest_offset 인수가 있는 경우엔 cmd 명령어를 보내기 전에
REST 명령어를 보내며 지정한 위치에서 부터
전송을 시작합니다.

블록이 넘겨지면 전송하는 데이터를 blocksize마다
블록에 인자로 넘겨줍니다.

@param cmd 명령어를 문자열로 지정합니다.
@param file 보내려는 데이터를 지정합니다.
@param blocksize 읽어올 블록 단위를 바이트 단위로 지정합니다.
@param rest_offset REST 명령어에 지정할 옵셋을 지정합니다.

@raise Net::FTPTempError 응답 코드가 4yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 5yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 RFC에 의거해 정상적이지 않을 경우 발생합니다.
@raise Net::FTPReplyError 응답 코드가 위에 열거한 경우 이외에 올바르지 않은 경우에 발생합니다.

@see [[m:Net::FTP#putbinaryfile]]

--- storlines(cmd, file) -> nil
--- storlines(cmd, file){|line| ...} -> nil
サーバーに cmd で指定されたコマンドを送り、テキストデータを
送ります。

file에서 한 줄씩 읽어들여 서버로 전송합니다.

보내는 데이터는 [[c:IO]]의 인스턴트를 file로 지정합니다.
([[c:StringIO]]와 같이 IO와 메소드 레벨에서
호환되는 객체면 어떤 객체든 상관없습니다.)

블록이 넘겨지면 각 행을 블록에 인자로 넘깁니다.

@param cmd 명령어를 문자열로 지정합니다.
@param file 보내려는 데이터를 지정합니다.

@raise Net::FTPTempError 응답 코드가 4yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 5yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 RFC에 의거해 정상적이지 않을 경우 발생합니다.
@raise Net::FTPReplyError 응답 코드가 위에 열거한 경우 이외에 올바르지 않은 경우에 발생합니다.

@see [[m:Net::FTP#puttextfile]]

--- getbinaryfile(remotefile, localfile = File.basename(remotefile), blocksize = DEFAULT_BLOCKSIZE){|data| ...} -> nil
--- getbinaryfile(remotefile, localfile = File.basename(remotefile), blocksize = DEFAULT_BLOCKSIZE) -> nil

서버에 있는 파일을 바이너리 모드로 받아옵니다.

서버에 있는 remotefile의 이름을 가진 파일을 받아와
로컬에 localfile이라는 이름으로 저장합니다.

localfile이 nil이면 저정하지 않습니다.

데이터 전송은 blocksize 바이트 단위로 이루어집니다.

블록이 넘겨지면
데이터를 blocksize 바이트 단위로 받아와 블록에 인자로 넘깁니다.

@param remotefile 받으려는 서버의 파일 이름을 지정합니다.
@param localfile 받은 파일을 저장할 파일 이름을 지정합니다.
@param blocksize 데이터 전송 단위를 바이트 단위로 지정합니다.


@raise Net::FTPTempError 응답 코드가 4yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 5yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 RFC에 의거해 정상적이지 않을 경우 발생합니다.
@raise Net::FTPReplyError 응답 코드가 위에 열거한 경우 이외에 올바르지 않은 경우에 발생합니다.

--- gettextfile(remotefile, localfile = File.basename(remotefile)) -> nil
--- gettextfile(remotefile, localfile = File.basename(remotefile)){|line| ...} -> nil

서버에 있는 파일을 텍스트 모드로 받아옵니다.

서버에 있는 remotefile의 이름을 가진 파일을 받아와
로컬에 localfile이라는 이름으로 저장합니다.

localfile이 nil이면 저정하지 않습니다.

블록이 넘겨지면
데이터를 한 줄씩 블록에 인자로 넘깁니다.

@param remotefile 받으려는 서버의 파일 이름을 지정합니다.
@param localfile 받은 파일을 저장할 파일 이름을 지정합니다.


@raise Net::FTPTempError 응답 코드가 4yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 5yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 RFC에 의거해 정상적이지 않을 경우 발생합니다.
@raise Net::FTPReplyError 응답 코드가 위에 열거한 경우 이외에 올바르지 않은 경우에 발생합니다.

--- putbinaryfile(localfile, remotefile = File.basename(localfile), blocksize = DEFAULT_BLOCKSIZE) -> nil
--- putbinaryfile(localfile, remotefile = File.basename(localfile), blocksize = DEFAULT_BLOCKSIZE) {|data| ...} -> nil

서버에 파일을 바이너리 모드로 전송합니다.

로컬에 있는 localfile이라는 파일명을 가진 파일을 읽어와
서버에 remotefile이라는 파일명으로 저장합니다.

데이터 전송은 blocksize 바이트 단위로 이루어집니다.

블록이 넘겨지면
데이터를 blocksize 바이트 단위로 전송하고 해당하는 데이터를
블록에 인자로 넘깁니다.

@param localfile 로컬에 있는 전송하려는 파일명을 지정합니다.
@param remotefile 서버에 저장할 파일명을 지정합니다.
@param blocksize 데이터 전송 단위를 바이트 단위로 지정합니다.

@raise Net::FTPTempError 응답 코드가 4yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 5yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 RFC에 의거해 정상적이지 않을 경우 발생합니다.
@raise Net::FTPReplyError 응답 코드가 위에 열거한 경우 이외에 올바르지 않은 경우에 발생합니다.

--- puttextfile(localfile, remotefile = File.basename(localfile)) -> nil
--- puttextfile(localfile, remotefile = File.basename(localfile)) {|line| ... } -> nil
서버에 파일을 텍스트 모드로 전송합니다.

로컬에 있는 localfile이라는 파일명을 가진 파일을 읽어와
서버에 remotefile이라는 파일명으로 저장합니다.

블록이 넘겨지면
데이터를 한 줄씩 블록에 인자로 넘깁니다.

@param localfile 로컬에 있는 전송하려는 파일명을 지정합니다.
@param remotefile 서버에 저장할 파일명을 지정합니다.

@raise Net::FTPTempError 응답 코드가 4yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 5yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 RFC에 의거해 정상적이지 않을 경우 발생합니다.
@raise Net::FTPReplyError 응답 코드가 위에 열거한 경우 이외에 올바르지 않은 경우에 발생합니다.

--- acct(account) -> nil

서버에 ACCT 명령어를 보내 계정 정보를 전송합니다.

@param account 보내려는 계정 정보를 문자열로 지정합니다.

@raise Net::FTPReplyError 응답 코드가 2yz가 아니면 발생합니다.

--- nlst(dir = nil) -> [String]

dir로 지정한 디렉토리의 파일을 배열로 리턴합니다.

dir이 생략되면 현재 작업 디렉토리가 지정됩니다.

@param dir 디렉토리를 문자열로 지정합니다.

@raise Net::FTPTempError 응답 코드가 4yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 5yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 RFC에 의거해 정상적이지 않을 경우 발생합니다.
@raise Net::FTPReplyError 응답 코드가 위에 열거한 경우 이외에 올바르지 않은 경우에 발생합니다.

--- list(*args) -> [String]
--- list(*args) {|line| ... } -> nil
--- ls(*args) -> [String] 
--- ls(*args) {|line| ... } -> nil
--- dir(*args) -> [String]
--- dir(*args) {|line| ...} -> nil

LIST 명령어를 전송하고 그 결과를 리턴합니다.

블록이 넘겨지면 각 행을 블록에 인자로 넘깁니다.블록이 없으면 문자열로 구성된 배열로 실행 결과를 리턴합니다.

@param args LIST 의 인수를 문자열로 지정합니다.여러 개의 인수를 지정할 수 있습니다.

@raise Net::FTPTempError 응답 코드가 4yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 5yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 RFC에 의거해 정상적이지 않을 경우 발생합니다.
@raise Net::FTPReplyError 응답 코드가 위에 열거한 경우 이외에 올바르지 않은 경우에 발생합니다.

--- rename(fromname, toname) -> nil
파일의 이름을 변경합니다.

서버에 있는 fromname을 가진 파일의 이름을
toname으로 변경합니다.

@param fromname 이름을 바꿀 파일을 지정합니다.
@param toname 새로운 파일 이름을 지정합니다.

@raise Net::FTPReplyError 응답 코드가 정상적이지 않은 경우나이름을 변경하는데 실패하면 발생합니다.

--- delete(filename) -> nil
파일을 삭제합니다.

서버에 있는 filename이라는 이름을 가진 파일을 삭제합니다.

삭제에 실패하면 예외가 발생합니다.

@param filename 삭제하려는 파일의 이름을 지정합니다.

@raise Net::FTPPermError 응답코드가 5yz이면 발생합니다.
@raise Net::FTPReplyError 응답코드가 5yz이외에 정상적이지 않은 경우에 발생합니다.

--- chdir(dirname) -> nil
서버 상의 작업 디렉토리를 dirname으로 변경합니다.

@param dirname 변경할 디렉토리를 지정합니다.
@raise Net::FTPReplyError 응답코드가 정상적이지 않거나작업 디렉토리 변경에 실패하면 발생합니다.

--- size(filename) -> Integer
서버의 filename 이름을 가진 파일의 사이즈를 리턴합니다.

@param filename 사이즈를 알아내려는 파일명을 지정합니다.

@raise Net::FTPTempError 응답 코드가 4yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 5yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 RFC에 의거해 정상적이지 않을 경우 발생합니다.
@raise Net::FTPReplyError 응답코드가 위에 열거한 경우들 외에 정상적이지 않은 경우에 발생합니다.

--- mtime(filename, local = false) -> Time

filename 파일의 갱신시각을 Time 객체로 리턴합니다.

local を真とすると、得られた更新時刻を地方時とみなします。
偽の場合は更新時刻を協定世界時とみなします。

@param filename 更新時刻を得たいファイルの名前を文字列で与えます。
@param local 返り値の時刻を地方時とみなすかどうかを真偽値で与えます。

@raise Net::FTPTempError 응답 코드가 4yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 5yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 RFC에 의거해 정상적이지 않을 경우 발생합니다.
@raise Net::FTPReplyError 응답코드가 위에 열거한 경우들 외에 정상적이지 않은 경우에 발생합니다.

--- mkdir(dirname) -> String
서버에 dirname 이름을 가진 디렉토리를 만듭니다.

디렉토리를 작성에 실패하면 예외가 발생합니다.

@param dirname 만드려는 디렉토리 이름을 문자열로 지정합니다.

@raise Net::FTPTempError 응답 코드가 4yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 5yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 RFC에 의거해 정상적이지 않을 경우 발생합니다.
@raise Net::FTPReplyError 응답코드가 위에 열거한 경우들 외에 정상적이지 않은 경우에 발생합니다.

--- rmdir(dirname) -> nil
서버에 있는 디렉토리를 삭제합니다.

@param dirname 삭제하려는 디렉토리의 이름을

@raise Net::FTPReplyError 응답 코드가 정상적이지 않은 경우나삭제에 실패하면 발생합니다.

--- pwd -> String
--- getdir -> String
작업 디렉토리를 리턴합니다.

@raise Net::FTPTempError 응답 코드가 4yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 5yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 RFC에 의거해 정상적이지 않을 경우 발생합니다.
@raise Net::FTPReplyError 응답코드가 위에 열거한 경우들 외에 정상적이지 않은 경우에 발생합니다.

--- system -> String
서버의 OS 타입을 리턴합니다.

@raise Net::FTPTempError 응답 코드가 4yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 5yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 RFC에 의거해 정상적이지 않을 경우 발생합니다.
@raise Net::FTPReplyError 응답코드가 위에 열거한 경우들 외에 정상적이지 않은 경우에 발생합니다.

--- abort -> String
데이터 전송을 중지합니다.

@return 서버에서 보내온 응답을 문자열로 리턴합니다.

@raise Net::FTPReplyError 응답 코드가 정상적이지 않은 경우나

--- status -> String
현재 상태를 리턴합니다.

@raise Net::FTPTempError 응답 코드가 4yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 5yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 RFC에 의거해 정상적이지 않을 경우 발생합니다.

--- mdtm(filename) -> String
MDTM 명령어를 보내고 결과를 리턴합니다.

@param filename 명령어의 인수가 되는 파일명을 문자열로 지정합니다.
@raise Net::FTPTempError 응답 코드가 4yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 5yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 RFC에 의거해 정상적이지 않을 경우 발생합니다.

--- passive -> bool
passive 모드이면 true를 리턴하고, 그렇지 않으면
false를 리턴합니다.

기본 설정은 false입니다.

@see [[m:Net::FTP#passive=]]
--- passive=(bool)
passive 모드를 설정합니다.

@see [[m:Net::FTP#passive]]

--- return_code -> String
이 메소드는 더 이상 사용되지 않습니다.사용하지 마시기 바랍니다.

"\n" 를 리턴합니다.

--- return_code=(string)
이 메소드는 더 이상 사용되지 않습니다.사용하지 마시기 바랍니다.

--- lastresp -> String
--- last_response_code -> String

서버에서 마지막으로 보내온 응답 코드를 문자열로 리턴합니다.

예를 들어 로그인 ([[m:Net::FTP#login]])에 성공했으면
"230"을 리턴합니다.

숫자들의 의미는 [[rfc:959]]를 참조해주세요.

@see [[m:Net::FTP#last_response]]
--- last_response -> String
서버에서 마지막으로 보내온 응답을 문자열로 리턴합니다.

예를 들어 로그인 ([[m:Net::FTP#login]])에 성공했으면
"230"을 리턴합니다.
"230 Login successful.\n"을 리턴합니다.

@see [[m:Net::FTP#last_response_code]]
--- welcome -> String
서버의 환영 메시지를 리턴합니다.

이 메시지는 로그인 ([[m:Net::FTP#login]])할 때
서버에서 보내옵니다.

--- help(arg = nil) -> String
서버에서 help 정보를 리턴합니다.

@param arg HELP 명령어의 인수를 지정합니다.

@raise Net::FTPTempError 응답 코드가 4yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 5yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 RFC에 의거해 정상적이지 않을 경우 발생합니다.

--- quit -> nil
FTP 세션에서 로그아웃합니다.

--- close -> ()
서버에서 접속을 끊습니다.

다시 [[m:Net::FTP#connect]] 메소드로 서버에 접속하지 않으면
어떠한 명령도 사용할 수 없습니다.

--- closed?-> bool
서버와 접속이 끊어져있으면 true를 리턴합니다.

--- resume -> bool
現在のリジュームモードの状態を返します。

リジュームモードが有効であるならば、
いくつかの転送メソッドにおいて
転送が中断され不完全な転送しかできなかった場合に
再開が可能になります。

기본 설정은 false입니다.

転送の中断と再開が可能なのは以下のメソッドです。  * [[m:Net::FTP#get]]
  * [[m:Net::FTP#put]]
  * [[m:Net::FTP#getbinaryfile]]
  * [[m:Net::FTP#putbinaryfile]]

転送が中断したかどうかは転送先に問題のファイルが存在するか
どうかで判定され、そのファイルサイズで再開する位置を
決めます。

@see [[m:Net::FTP#resume=]]
#@# リジュームモードとは途中で中断された
#@# データ転送を再開するためのものです。デフォルトの値は false です。
#@# この値が真であるとき、いくつかの転送メソッドは事前に REST コマンドを
#@# 発行することによって転送元と転送元のオフセットをセットします。
#@# これにより、すでに転送されたデータは転送されなくなります。
#@# 具体的には以下のメソッドが影響を受けます。

#@# getbinaryfile はローカルファイルのサイズをオフセットとします。

#@# putbinaryfile はリモートファイルのサイズをオフセットとします。

--- resume=(boolean)
現在のリジュームモードを設定します。

@param boolean trueならばリジュームモードを on にします。@see [[m:Net::FTP#resume]]

--- debug_mode -> bool
デバッグモードであれば真を、そうでなければ偽を返します。

値が真であるとき、送受信の記録と ABOR, STAT の結果が
[[m:$stdout]] に随時表示されます。

기본 설정은 false입니다.
@see [[m:Net::FTP#debug_mode=]]

--- debug_mode=(boolean)

デバッグモードの on/off を設定します。

@param boolean 真ならばデバッグモードを on にします。@see [[m:Net::FTP#debug_mode]]

--- set_socket(sock, get_greeting = true) -> nil
FTP のコントロール接続の
ソケットを TCPSocket オブジェクト sock に設定します。

get_greeting に偽が与えられると、
set_socket は通信先を設定するだけで sock に対する操作を
何も行ないません。
get_greeting が真ならば、通信先を sock に
設定したあと、通常FTPサーバが接続時に送ってくるメッセージを読み込みます。

通常このメソッドは使うべきではありません。このライブラリの
実装を理解した上で必要な場合のみ利用してください。

@param sock コントロール接続に使うソケットを指定します。
@param get_greeting ソケットを設定した後接続時メッセージをソケットから読みこむかどうかを指定します。

--- get(remotefile, localfile = File.basename(remotefile), blocksize = DEFAULT_BLOCKSIZE) -> nil
--- get(remotefile, localfile = File.basename(remotefile), blocksize = DEFAULT_BLOCKSIZE) { |data| .... } -> nil

サーバ上のファイルを取得します。

[[m:Net::FTP#binary]] の値に従って
[[m:Net::FTP#getbinaryfile]] もしくは
[[m:Net::FTP#gettextfile]] を呼びだします。

binary가 false이면(텍스트 모드일 때)
blocksize는 무시됩니다.

@param remotefile 받으려는 서버의 파일 이름을 지정합니다.
@param localfile 받은 파일을 저장할 파일 이름을 지정합니다.
@param blocksize 데이터 전송 단위를 바이트 단위로 지정합니다.

@raise Net::FTPTempError 응답 코드가 4yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 5yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 RFC에 의거해 정상적이지 않을 경우 발생합니다.
@raise Net::FTPReplyError 응답코드가 위에 열거한 경우들 외에 정상적이지 않은 경우에 발생합니다.


--- put(localfile, remotefile = File.basename(localfile), blocksize = DEFAULT_BLOCKSIZE) -> nil
--- put(localfile, remotefile = File.basename(localfile), blocksize = DEFAULT_BLOCKSIZE) { |data| .... } -> nil

서버에 파일을 전송합니다.

[[m:Net::FTP#binary]] 값에 따라서
[[m:Net::FTP#putbinaryfile]] 메소드나
[[m:Net::FTP#puttextfile]] 메소드를 호출합니다.

binary가 false이면(텍스트 모드일 때)
blocksize는 무시됩니다.

@param localfile 로컬에 있는 전송하려는 파일명을 지정합니다.
@param remotefile 서버에 저장할 파일명을 지정합니다.
@param blocksize 데이터 전송 단위를 바이트 단위로 지정합니다.

@raise Net::FTPTempError 응답 코드가 4yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 5yz일 때 발생합니다.
@raise Net::FTPPermError 응답 코드가 RFC에 의거해 정상적이지 않을 경우 발생합니다.
@raise Net::FTPReplyError 응답코드가 위에 열거한 경우들 외에 정상적이지 않은 경우에 발생합니다.

--- binary -> bool
[[m:Net::FTP#put]], [[m:Net::FTP#get]] による転送を
バイナリモード(IMAGE)で行うかどうかを返します。

デフォルトの値は true です。

偽の場合、テキストモード(ASCII)が仮定されます。

EBCDIC や LOCAL など他の表現タイプはサポートされていません。

@see [[m:Net::FTP#binary=]]
--- binary=(bool)
[[m:Net::FTP#put]], [[m:Net::FTP#get]] による転送を
バイナリモード(IMAGE)で転送するかどうかを指定します。

デフォルトの値は true です。

偽の場合、テキストモード(ASCII)が仮定されます。

EBCDIC や LOCAL など他の表現タイプはサポートされていません。

@param bool 真ならばバイナリモードを on にします。@see [[m:Net::FTP#binary]]

--- noop -> nil
NOOP コマンドを発行します。

サーバから応答が得られる他は何もしません。

@raise Net::FTPReplyError 응답코드가 위에 열거한 경우들 외에 정상적이지 않은 경우에 발생합니다.

--- site(arg) -> nil
SITE コマンドを発行します。

@param arg SITEコマンドのパラメータを指定します。

@raise Net::FTPReplyError 응답코드가 위에 열거한 경우들 외에 정상적이지 않은 경우에 발생합니다.

#@#== Constants

#@# --- CRLF
#@# nodoc

--- DEFAULT_BLOCKSIZE -> Integer
get, put をするときのデフォルトのブロックサイズです。

--- FTP_PORT -> Integer
FTPのデフォルトのポート番号(21)です。

#@# --- MDTM_REGEXP
#@# nodoc

#@# #@since 1.9.2
#@# = class Net::FTP::NullSocket < Object
#@# 
#@# 全てのメソッド呼び出しに対して [[c:Net::FTPConnectionError]] を発生させます。#@# 
#@# #@end

= class Net::FTPError < StandardError
net/ftp ライブラリ関連のエラー全般を表す例外クラスです。

サーバの応答コードがエラーを示している場合に発生します。

例外発生の原因となったサーバ応答は [[m:Exception#message]]
から得られます。

= class Net::FTPReplyError < Net::FTPError
FTPの応答が 1yz や 3yz であり、それが
想定外であることを表わす例外クラスです。

= class Net::FTPTempError < Net::FTPError
FTP の応答コード 4yz 
(Transient Negative Completion reply)
を表す例外クラスです。

詳しくは [[RFC:959]] を参照してください。

= class Net::FTPPermError < Net::FTPError
FTP の応答コード 5yz 
(Permanent Negative Completion reply)
を表す例外クラスです。

詳しくは [[RFC:959]] を参照してください。

= class Net::FTPProtoError < Net::FTPError
サーバの応答が FTP のプロトコルに沿っていない場合に
発生する例外のクラスです。

#@since 1.9.2
= class Net::FTPConnectionError < Net::FTPError
コネクションを確立する前に通信しようとした場合に
発生する例外のクラスです。

#@end
