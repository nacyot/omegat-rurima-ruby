require irb/cmd/nop
require irb/ext/workspaces

irb에서 사용하는 irb_workspaces、irb_push_workspace、irb_pop_workspace 명령어가
정의된 서브 라이브러입니다.

이 라이브러리에 정의된 메소드는 직접 사용할 수 없습니다.

= class IRB::ExtendCommand::Workspaces < IRB::ExtendCommand::Nop

irb에서 사용하는 irb_workspaces 명령어가 정의된 클래스입니다.


== Instance Methods

--- execute(*obj) -> [IRB::WorkSpace]

현재 작업 공간(workspace)의 목록을 리턴합니다.

@param obj 사용하지 않습니다.

= class IRB::ExtendCommand::PushWorkspace < IRB::ExtendCommand::Nop

irb에서 사용하는 irb_push_workspace 명령어가 정의된 클래스입니다.


== Instance Methods

--- execute(*obj) -> [IRB::WorkSpace]

UNIX 명령어 pushd와 같습니다.

@param obj [[c:IRB::WorkSpace]] 객체를 지정합니다.다수의 객체를 한 번에 지정하면
           맨 앞의 객체만 지정됩니다.

= class IRB::ExtendCommand::PopWorkspace < IRB::ExtendCommand::Nop

irb에서 사용하는 irb_pop_workspace 명령어가 정의된 클래스입니다.


== Instance Methods

--- execute(*obj) -> [IRB::WorkSpace]

UNIX 명령어 popd와 같습니다.

@param obj 사용하지 않습니다.
