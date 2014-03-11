
irb 명령어를 확장하는 라이브러리의 기반이 되는 클래스를 다루는 서브 라이브러리입니다.

이 라이브러리에 정의된 메소드는 직접 사용할 수 없습니다.

= class IRB::ExtendCommand::Nop

irb 명령어를 확장하는 클래스의 기반이 되는 클래스입니다.서브 클래스를 정의하는 방법으로
명렁어를 확장할 수 있습니다.


== Class Methods

--- execute(conf, *opts) -> ()

명령어를 실행합니다.사용자가 직접 사용해선 안 됩니다.

@param conf [[c:IRB::Context]] 객체를 지정합니다.

@param opts irb 확장 명령어에 넘길 인수를 지정합니다.

--- new(conf) -> IRB::ExtendCommand::Nop

객체를 초기화합니다.사용자가 직접 사용해선 안 됩니다.

@param conf [[c:IRB::Context]] 객체를 지정합니다.


== Instance Methods

--- irb_context -> IRB::Context

irb의 현재 설정을 담고 있는 [[c:IRB::Context]] 객체를 리턴합니다.

#@# 사용되지 않는 관계로 생략했습니다.
#@# --- irb -> IRB::Irb

--- execute(*opts) -> ()

아무것도 하지 않습니다.서브 클래스에서 재작성해야합니다.

@param opts irb 확장 명령어에 넘길 인수를 지정합니다.
