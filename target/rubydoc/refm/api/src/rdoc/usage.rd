require rdoc/markup/simple_markup
require rdoc/markup/simple_markup/to_flow
#@# require rdoc/ri/ri_formatter
#@# require rdoc/ri/ri_options

프로그램의 사용법(RDoc.usage 을 호출한 소스 파일의 맨 앞에 있는 코멘트)를 표시하기 위한 서브라이브러리입니다.

[주의] rdoc/usage 라이브러리는 1.9 버전대에선 사용되지 않습니다.

===[a:usage] 사용법

아래의 같이 실행합니다.exit_status、section 두 인수 모두 생략가능합니다.

  RDoc.usage(exit_status, section, ...)
  RDoc.usage_no_exit(section, ...)

각각의 인수는 다음과 같은 의미를 가집니다.

: exit_status

  프로그램의 종료 상태를 수치로 변환 가능한 객체로 지정합니다.
  지정하지 않으면 기본설정을 0입니다.

: section

  見出し部に指定した名前を 1 つ、または複数指定します。指定があれば、そ
  の見出しの部分だけを表示し、指定しなかった場合は全て表示します。見出
  しレベルや名前の大文字、小文字の区別はありません。

=== 예

아래와 같이 사용합니다.실제로 사용하실 때는  RDoc::usage 행을 주석 처리하고 사용해주세요.

  # Comment block describing usage
  # with (optional) section headings
  #
  # = Summary
  # . . .
  # == Author
  # . . .
  # == Copyright
  # . . .

  require 'rdoc/usage'

  # 프로그램 사용법을 전부 출력한 후 종료상태를 0으로 프로그램 종료.
  RDoc::usage

  # 프로그램의 사용법을 전부 출력한 후 종료상태를 99로 프로그램을
  # 종료.
  RDoc::usage(99)

  # '=Summary'에서 '==Author' 직전까지 출력한 후 종료상태를
  # 99로 프로그램 종료.
  RDoc::usage(99, 'Summary')

  # Author, Copyright을 출력한 후 종료 상태 0으로 프로그램 종료.
  RDoc::usage('Author', 'Copyright')

  # Author, Copyright을 출력한 후 프로그램을 진행.
  RDoc::usage_no_exit('Author', 'Copyright')

= reopen RDoc

== Singleton Methods

--- usage(*args) -> ()

프로그램의 사용법(RDoc.usage 을 호출한 소스 파일의 맨 앞에 있는 코멘트)를 표준출력으로 출력한 후 프로그램을 종료합니다.

수치로 변환 가능한 객체를 arg[0]에 지정한 경우에는 종료 상태를 arg[0]에 지정한 값으로 지정합니다.지정하지 않으면 기본설정을 0입니다.

@param args 프로그램 종료상태와 출력할 부분들을 배열로 
            지정합니다.자세한 사항은 [[ref:lib:rdoc/usage#usage]]을
            읽어주세요.

--- usage_no_exit(*args) -> ()

프로그램의 사용법(RDoc.usage 을 호출한 소스 파일의 맨 앞에 있는 코멘트)를 표준 출력으로 출력합니다.

@param args 출력할 부분을 배열로 지정합니다.자세한 사항은
            [[ref:lib:rdoc/usage#usage]] 을 읽어주세요.
