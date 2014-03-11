#@since 1.9.1
category Development

코드 커버리지를 측정하는 라이브러리입니다.

=== 사용법

아래의 순서대로 사용합니다.

  (1) require "coverage"
  (2) Coverage.start 실행
  (3) require 혹은 load 
  (4) Coverage.result 으로 결과 확인

=== 예

우선 코드 커버리지 측정 대상이 되는 소스 코드를 준비합니다.

  # foo.rb
  s = 0
  10.times do |x|
    s += x
  end

  if s == 45
    p :ok
  else
    p :ng
  end

아래의 순서대로 사용합니다.

  require "coverage"
  Coverage.start
  require "foo"
  p Coverage.result # => {"foo.rb"=>[1, 1, 10, nil, nil, 1, 1, nil, 0, nil]}

Coverage.result["foo.rb"]에서 반환되는 배열은 각행의 실행회수를 나타냅니다.

= class Coverage

커버리지를 측정하는 기능을 제공하는 클래스입니다.

실험적인 기능이므로 API는 이후 변경될 가능성이 있습니다.


== Class Methods

--- start  -> nil

코드 커버리지의 측정을 시작합니다.이미 실행돼있으면 아무것도 하지 않습니다.

--- result  -> Hash

파일명을 키로 각행의 실행횟수 배열을 값으로 가지는 해쉬를 리턴합니다.줄바꿈 문자나 주석의 측정 결과는 nil입니다.result
메소드가 실행된 이후의 커버리지 측정은 이루어지지 않습니다.

@return 측정 결과를 담은 해쉬

@raise RuntimeError [[m:Coverage.start]]을 실행하기 전에 호출하면
                    발생합니다.

#@end
