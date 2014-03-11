#@# require rdoc/ri/driver
#@# require rdoc/ri/util
require irb/cmd/nop

irb의 help 명령어를 위한 라이브러리입니다.

이 라이브러리에 정의된 메소드는 직접 사용할 수 없습니다.

= class IRB::ExtendCommand::Help < IRB::ExtendCommand::Nop

irb의 help 명령어를 위한 확장 클래스입니다.


== Instance Methods

--- execute(*names) -> nil

RI에서 Ruby 문서를 참조합니다ㅣ

  irb(main):001:0> help String#match
  ...

@param names 참조하고 싶은 클래스 이름이나 메소드 이름을 지정합니다.

#@since 1.9.2
names을 지정하지 않은 경우 RI를 대화형 모드로 실행합니다.메소드 이름을 입력해서 문서를 검색할 수 있습니다.입력 중에 탭을 통해 자동와성 할 수 있습니다.빈 행을 입력하면 irb의 본래 실행 환경으로 돌아갑니다.

  irb(main):001:0> help

  Enter the method name you want to look up.
  You can use tab to autocomplete.
  Enter a blank line to exit.

  >> String#match
  String#match

  (from ruby core)
  ------------------------------------------------------------------------------
    str.match(pattern)        -> matchdata or nil
    str.match(pattern, pos)   -> matchdata or nil
  ...
#@end

#@# TODO: RDoc::RI::Driver.new 이 SystemExit 를 발생시키는 경우를 추가할 것.
