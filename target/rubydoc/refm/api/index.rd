= Ruby  표준 API 레퍼런스

== 내장 클래스

* ((<Object>))
  * ((<Array>))
  * ((<Binding>))
  * ((<Continuation>))
  * ((<Data>))
  * ((<Exception>)) (((<내장클래스／모듈／예외 클래스/ 예외클래스))参照)
  * ((<Dir>))
  * ((<File::Stat>))
  * ((<Hash>))
  * ((<IO>))
    * ((<File>))
  * ((<MatchData>))
  * ((<Method>))
    * (((<UnboundMethod>)))  (((<ruby 1.7 feature>)) ((*version 1.6이전의 위치*)))
  * ((<Module>))
    * ((<Class>))
  * ((<Numeric>))
    * ((<Integer>))
      * ((<Bignum>))
      * ((<Fixnum>))
    * ((<Float>))
  * ((<Proc>))
  * ((<Process::Status>))  (((<ruby 1.7 feature>)))
  * ((<Range>))
  * ((<Regexp>))
  * ((<String>))
  * ((<Struct>))
  * ((<Symbol>))
  * ((<Thread>))
  * ((<ThreadGroup>))
  * ((<Time>))
  * ((<UnboundMethod>))         (((<ruby 1.7 feature>)))
  * ((<TrueClass>))
  * ((<FalseClass>))
  * ((<NilClass>))

== 내장 모듈

* ((<Comparable>))
* ((<Enumerable>))
* ((<Errno>))
* ((<File::Constants>))
* ((<FileTest>))
* ((<GC>))
* ((<Kernel>))
* ((<Marshal>))
* ((<Math>))
* ((<ObjectSpace>))
* ((<Precision>))
* ((<Process>))
* ((<Process::GID>))
* ((<Process::Sys>))
* ((<Process::UID>))
* ((<Signal>))

== 예외 클래스

* ((<Object>))
  * ((<Exception>))
    * (((<Interrupt>))) (((<ruby 1.7 feature>)) ((*version 1.6이전에 위치*)))
    * ((<NoMemoryError>))
    * ((<ScriptError>))
      * ((<LoadError>))
      * (((<NameError>)))  (((<ruby 1.7 feature>)) ((*version 1.6이전에 위치*)))
      * ((<NotImplementedError>))
      * ((<SyntaxError>))
    * ((<SignalException>))
      * ((<Interrupt>)) (((<ruby 1.7 feature>)))
    * ((<StandardError>))
      * ((<ArgumentError>))
      * ((<IndexError>))
        * ((<KeyError>))        (((<ruby 1.9 feature>)))
      * ((<IOError>))
        * ((<EOFError>))
      * ((<LocalJumpError>))
      * ((<NameError>))  (((<ruby 1.7 feature>)))
        * ((<NoMethodError>)) (((<ruby 1.7 feature>)))
      * ((<RangeError>))
        * ((<FloatDomainError>))
      * ((<RegexpError>))
      * ((<RuntimeError>))
      * ((<SecurityError>))
      * ((<SystemCallError>))
        * ((<Errno::EXXX>))
      * ((<SystemStackError>))
      * ((<ThreadError>))
      * ((<TypeError>))
      * ((<ZeroDivisionError>))
    * ((<SystemExit>))
    * ((<fatal>))

* ((<添付ライブラリ>))

== 독립 항목

남겨둘 만한 항목

  * ((<pack 템플릿 문자열>))
  * ((<sprintf 포멧>))
  * ((<Marshal 포멧>))
  * ((<의사BNF에 의한 Ruby 문법>))

남겨두기 애매한 항목

  * ((<참고문헌・사이트>))
  * ((<Ruby용어집>))
  * ((<색인|method>))

== 변경 사항

옮겨야 되는 것들

* ((<Ruby 변경 사항>))
  * ((<ruby 1.8.5 feature>))
  * ((<ruby 1.9 feature>))

== 옮겨야 함

* ((<메뉴얼 다운로드>))         → 레퍼런스 메뉴얼보다 위로
* ((<레퍼런스 메뉴얼 검색툴 ReFe|ReFe>)) → 다운로드 근처로
* ((<Ruby에 관한 책>))              → www.ruby-lang.org
* ((<Ruby가 사용가능한 플랫폼>)) → www.ruby-lang.org

== 편집자용 정보 (삭제)

* ((<매뉴얼 변경 사항 ML 아카이브|URL:http://www.atdot.net/mla/mandiff@ruby/>))
