#@since 1.9.1
require rdoc/parser
#@else
require rdoc/code_objects
#@end

Fortran95의 소스코드를 분석하는 서브 라이브러리입니다.

확장자가 .f90, .F90, .f95, .F95인 파일을 분석할 수 있습니다.정상적인 분석을 위해선 Fortran95의 @@@

[주의] rdoc 2.4.0부터 rdoc-f95로 분리 되었으므로 Ruby 1.9.2 버전부터는
#@since 1.9.1
[[lib:rdoc/parser/f95]]는 Ruby 표준 라이브러리에 포함되지 않습니다.
#@else
더 이상 [[lib:rdoc/parsers/parse_f95]]는 표준 라이브러리에 포함되지 않습니다.
#@end
Ruby 1.9.2 이수 버전을 사용하고 계시면 rdoc-f95를 RubyGems에서 설치해주세요.

=== Fortran95 프로그램 지원 @@@

#@since 1.9.1
[[lib:rdoc/parser/f95]]에서 분석 가능한 것들입니다.
#@else
[[lib:rdoc/parsers/parse_f95]]에서 분석가능한 것들입니다.
#@end

 * main 프로그램
 * module
 * subroutine
 * function
 * 파생형 @@@
 * public 변수
 * public 상수
 * 사용자 정의 단항 연산자
 * 사용자 정의 대입

Ruby와 비교해보면 아래와 같은 대응 관계를 가집니다.

: 파일

  파일(Ruby와 같음)

: 클래스

  module

: 메소드

  subroutine, function, 변수, 상수, 파생형@@@, 사용자 정의 단항 연산자, 사용자 정의 대입

: require된 파일

  use 문으로 읽어온 module, external 선언된 subroutine, function

: include된 모듈

  use 문으로 읽어온 module

: 속성

  파생형@@@ use 문으로 읽어온 module

=== 분석 가능한 정보

아래의 정보들은 자동적으로 분석됩니다.

 * 인수의 타입
 * 변수와 상수의 타입
 * 派生型の型や初期値
 * NAMELIST 안의 변수의 타입과 초기값

interface 문에 정의된 alias는 위의 '메소드'와 같은 방식으로 처리됩니다.

=== 주석의 형식

기본은 Ruby 소스코드 안에 문서를 기술하는 방식과 같습니다.Ruby와 다른 점은 Fortran95에서는 주석을 나타내는 문자로 '!'를 사용합니다.コメントは文の後(もしくは下)に記
述します。

字下げは任意の位置に行う事ができます。

     !(Top of file)
     !     !このファイルに対するコメントを記述します。     !     !--
     !"!--" から "!++" で囲まれたコメントは無視されます。     !++
     !     module hogehoge
       !       !この module(もしくは、program) に対するコメントを記述します。       !

       private

       logical            :: a     !private 변수
       real, public       :: b     !public 변수
       integer, parameter :: c = 0 !public 상수

       public :: c
       public :: MULTI_ARRAY
       public :: hoge, foo

       type MULTI_ARRAY
         !         !派生型に対するコメントを記述します。         !         real, pointer :: var(:) =>null() !변수에 대한 주석
         integer       :: num = 0
       end type MULTI_ARRAY

     contains

       subroutine hoge( in,   &   !문장이 이어지는 행 사이의 주석은 무시됩니다.
           &            out )
         !         !subroutine이나 function에 대한 주석을 적습니다.
         !         character(*),intent(in):: in !인수에 대한 주석을 적습니다.
         character(*),intent(out),allocatable,target  :: in

         character(32) :: file !아래 열거된 NAMELIST의 변수에 대한 주석으로 처리됩니다.
         integer       :: id

         namelist /varinfo_nml/ file, id
                 !                 !NAMELIST에 대한 주석을 적습니다.
                 !위 변수에 대한 주석을 적습니다.
                 !

       ....

       end subroutine hoge

       integer function foo( in )
         !         !이 행은 처리되지만

         !이 행처럼 빈 행 바로 아래에 입력한 주석을 무시됩니다.
         !         integer, intent(in):: inA !이 행은 처리되지만

                                   !이 행은 무시됩니다.

       end function foo

       subroutine hide( in,   &
         &              out )      !:nodoc:
         !         !위의 예처럼 subroutine의 마지막 행에 "!:nodoc:"을 입력하면
         !문서로 처리되지 않습니다.

       ....

       end subroutine hide

     end module hogehoge

#@since 1.9.1
= class RDoc::Parser::F95 < RDoc::Parser
#@else
= class RDoc::Fortran95parser

extend RDoc::ParserFactory
#@end

Fortran95 소스코드를 분석하는 클래스입니다.

#@#== Constants

--- COMMENTS_ARE_UPPER -> false

라이브러리 내부에서 사용합니다.

--- INTERNAL_ALIAS_MES -> "Alias for"

라이브러리 내부에서 사용합니다.

--- EXTERNAL_ALIAS_MES -> "The entity is"

라이브러리 내부에서 사용합니다.

#@until 1.9.1
== Class Methods

--- new(top_level, file_name, body, options, stats) -> RDoc::Fortran95parser

객체를 초기화합니다.

@param top_level [[c:RDoc::TopLevel]] 객체를 지정합니다.

@param file_name 파일명을 나타내는 문자열을 지정합니다.

@param body 소스 코드를 문자열로 지정합니다.

@param options [[c:Options]] 객체를 지정합니다.

@param stats [[c:RDoc::Stats]] 객체를 지정합니다.
#@end


== Instance Methods

--- scan -> RDoc::TopLevel

소스코드 안의 문서를 분석합니다.

@return [[c:RDoc::TopLevel]] 객체를 리턴합니다.
