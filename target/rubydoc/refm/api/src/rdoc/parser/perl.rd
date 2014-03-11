require rdoc/parser

Perl 소스 코드를 분서하는 서브 라이브러리입니다.Perl 소스코드 안에 있는
POD(Plain old Documentation) 형식의 주석을 분석할
수 있습니다.

확장자가 .pl 혹은 .pm인 파일을 분석할 수 있습니다.

[注意] rdoc 3.0.1부터 rdoc-perl_pod으로 분리되었습니다. 1.9.3부터
[[lib:rdoc/parser/perl]]은 표준 라이브러리에서 제외되었습니다.
1.9.3 이후 버전을 사용하시는 분들은 RubyGems에서 rdoc-perl_pod을 설치해주세요.

= class RDoc::Parser::PerlPOD < RDoc::Parser

Perl의 소스 코드를 분석하는 클래스입니다.


== Class Methods

--- new(top_level, file_name, body, options, stats) -> RDoc::Parser::PerlPOD

객체를 초기화합니다.

@param top_level [[c:RDoc::TopLevel]] 객체를 지정합니다.

@param file_name 파일명을 나타내는 문자열을 지정합니다.

@param body 소스 코드를 문자열로 지정합니다.

@param options [[c:Options]] 객체를 지정합니다.

@param stats [[c:RDoc::Stats]] 객체를 지정합니다.


== Instance Methods

--- scan -> RDoc::TopLevel

Perl 소스코드에 포함된 POD (Plain old Documentation) 형식의
주석을 분석합니다.

@return [[c:RDoc::TopLevel]] 객체를 리턴합니다.

--- filter(comment) -> String

Perl 주석에 포함된 내용을 rdoc 형식으로 변환한 문자열을 리턴합니다.

아직 기본적인 부분만 처리할 수 있습니다.또한 C<<...>> 같은 부분은 제대로
처리되지 않습니다.

@param comment 소스 코드를 문자열로 지정합니다.
