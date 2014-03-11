require irb/cmd/nop
require irb/ext/change-ws

irb의 irb_current_working_workspace, irb_change_workspace 명령어를 위한 라이브러리입니다.

이 라이브러리에 정의된 메소드는 직접 사용할 수 없습니다.

= class IRB::ExtendCommand::CurrentWorkingWorkspace < IRB::ExtendCommand::Nop

irb의 irb_current_working_workspace 명령어를 위한 클래스입니다.


== Instance Methods

--- execute(*obj) -> obj

irb의 self를 반환합니다.

@param obj 사용하지 않습니다.

= class IRB::ExtendCommand::ChangeWorkspace < IRB::ExtendCommand::Nop

irb의 irb_change_workspace 명령어를 위한 확장 클래스입니다.


== Instance Methods

--- execute(*obj) -> obj

irb의 self를 obj로 지정한 객체를 설정합니다.self에 설정된
객체를 리턴합니다.

@param obj 임의의 객체를 지정할 수 있습니다.여러 개를 지정한 경우엔 
           가장 앞의 객체가 설정됩니다.
