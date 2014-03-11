category I/O

[[m:IO#readbytes]]를 제공하는 라이브러리입니다.

= reopen IO
== Instance Methods

--- readbytes(size) -> String
[[m:IO#read]]와 마찬가지로 size 바이트 읽기를 합니다만,
EOF(end of file)에 도달하면 [[c:EOFError]] 예외가 발생합니다.

@param size 읽어올 길이를 바이트 단위를 나타내는 정수로 지정합니다.nil을 지정하면 EOF까지 읽어옵니다.

@raise EOFError EOF에 도달하면 발생합니다.

@raise TruncatedDataError size 바이트만큼 읽어오지 못하면 발생합니다.

= class TruncatedDataError < IOError

[[m:IO#readbytes]]에서 발생하는 예외입니다.


== Instance Methods

--- data -> String

예외가 발생하기 전까지 읽어온 데이터를 문자열로 리턴합니다.
