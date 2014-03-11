require rubygems/command
require rubygems/builder

Gem 패키지를 빌드하기 위한 라이브러립니다.


  Usage: gem build GEMSPEC_FILE [options]
#@include(common_options)
    Arguments:
      GEMSPEC_FILE  Gem 패키지를 빌드하는 데 필요한 gemspec 파일명을 지정합니다.
    Summary:
      gemspec 파일에 따라 Gem 패키지를 빌드합니다.


= class Gem::Commands::BuildCommand < Gem::Command

Gem 패키지를 빌드하기 위한 클래스입니다.

== Public Instance Methods

--- execute -> ()

명령어를 실행합니다.

--- load_gemspecs(filename) -> Array

gemspec 파일을 읽어옵니다.

@param filename 파일명을 지정합니다.

--- usage -> String

사용방법을 나타내는 문자열을 리턴합니다.

--- arguments -> String

인수의 설명을 나타내는 문자열을 리턴합니다.

--- yaml?(filename) -> bool

주어진 파일이 yaml 파일이면 true를 리턴합니다.

@param filename 파일명을 지정합니다.
