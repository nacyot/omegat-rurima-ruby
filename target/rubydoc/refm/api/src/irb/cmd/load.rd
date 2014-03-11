require irb/cmd/nop
require irb/ext/loader

irb에서 irb_load, irb_require, irb_source 명령어를 위한 서브 라이브러리입니다.

이 라이브러리에 정의된 메소드는 직접 사용할 수 없습니다.

= class IRB::ExtendCommand::Load < IRB::ExtendCommand::Nop

include IRB::IrbLoader

irb의 irb_load 명령어를 위한 확장 클래스입니다.


== Instance Methods

--- execute(file_name, priv = nil) -> nil

파일 path를 Ruby 스크립트로 인식해 현재 irb 인터프리터 위에서 실행합니다.

[[m:Kernel.#load]] 와 달리 path의 내용을 irb에서 한 행씩 직접 입력하는 것처럼 평가가 이루어집니다.

@param file_name 파일명을 나타내는 문자열을 지정합니다.

@param priv true를 지정한 경우 내부적으로 생성된 이름 없는 모듈 위에서 작업이 이루어져 
            전역 네임스페이스에 영향을 주지 않습니다.

@raise LoadError 읽기 실패한 경우 발생합니다.

= class IRB::ExtendCommand::Require < IRB::ExtendCommand::Nop

include IRB::IrbLoader

irb의 irb_require 명령어를 위한 확장 클래스입니다.


== Instance Methods

--- execute(file_name) -> bool

file_name이 가리키는 파일을 현재 irb 인터프리터 위에서 실행합니다.

file_name에 Ruby 스크립트가 지정된 경우 [[m:Kernel.#load]] 와 달리 path의 내용을 irb에서 한 행씩 직접 입력하는 것처럼 평가가 이루어집니다.require에 성공한 경우 true를 리턴하며, 실패한 경우엔 false를 리턴합니다.

확장 라이브러리(*.so, *., *.dll 등)을 저장한 경우엔 그저 require됩니다.

@param file_name 파일명을 나타내는 문자열을 지정합니다.

= class IRB::ExtendCommand::Source < IRB::ExtendCommand::Nop

include IRB::IrbLoader

irb의 irb_source 명령어를 위한 확장 클래스입니다.


== Instance Methods

--- execute(file_name) -> nil

현재 실행중인 irb 인터프리터 위에서 Ruby 스크립트 path를 평가합니다.

path의 내용을 irb에서 한 행씩 직접 입력하는 것처럼 평가가 이루어집니다.[[m:$"]] 은 갱신되지 않으며 몇번이고 다시 불러올 수 있습니다.

@param file_name 파일명을 나타내는 문자열을 지정합니다.
