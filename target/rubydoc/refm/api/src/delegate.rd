#@since 1.8.0
category DesignPattern

메소드 위임(delegation)을 다루는 라이브러리입니다.

[[c:Delegator]] 클래스는 지정된 객체의 메소드 실행을 위임합니다.
[[c:Delegator]] 클래스를 사용하려면 이 클래스를 상속하고
[[m:Delegator#__getobj__]] 메소드를 재정의해서 위임을 받는 객체를 지정해야합니다.


[[c:SimpleDelegator]]는 [[c:Delegator]]를 사용하는 하나의 방법으로
생성자에 넘겨진 객체에 메소드 실행을 위임합니다.



[[m:Kernel#DelegateClass]] は 引数で渡されたクラスのインスタンスをひとつとり、
そのオブジェクトにインスタンスメソッドを委譲するクラスを定義して返します。

=== 참고

  * Rubyist Magazine - 표준 라이브러리 소개【제 6 회】위임 [[url:http://jp.rubyist.net/magazine/?0012-BundledLibraries]]


= reopen Kernel

== Private Instance Methods

--- DelegateClass(superclass) -> object

메소드를 위임받는 superclass 인스턴스에 위임을 하기 위한 클래스를 만들고 그 클래스를 리턴합니다.

@param superclass 메소드를 위임받는 클래스

예:

//emlist{
require 'delegate'

class ExtArray < DelegateClass(Array)
  def initialize
    super([])
  end
end
a = ExtArray.new
p a.class   # => ExtArray
a.push 25
p a         # => [25]
//}


= class Delegator < Object

서브 클래스에 메소드 위임을 하기 위한 추상 클래스

메소드를 위임하려면 이 클래스를 상속하고[[m:Delegator#__getobj__]]을 재정의할 필요가 있습니다.

구체적인 사용법은 [[c:SimpleDelegator]]을 참조해주세요.


== Class Methods

#@if (version <= '1.8.6')

--- new(obj) -> object

委譲を行うメソッドを定義します。

obj のもつインスタンスメソッドのうち、
自オブジェクトに定義されていないメソッドについて、
[[m:Delegator#__getobj__]] が返すオブジェクトへ
メソッド委譲を行うクラスメソッドを定義します。

@param obj 委譲を行うメソッドを決定するために使用するオブジェクト

#@end

#@since 1.9.1

#@#--- delegation_block
#@# 찾을 수 없음

#@#--- public_api
#@# nodoc

#@end
#@since 1.9.2

#@# --- const_missing
#@# 찾을 수 없음

#@end


== Instance Methods

#@since 1.9.1
--- ==(obj) -> bool

self와 obj가 같은 객체이면 true를 리턴합니다.
그렇지 않은 경우엔 false를 반환합니다.

@param obj 비교할 객체를 지정합니다.

#@end

#@since 1.9.2

--- !=(obj) -> bool

self와 obj가 같지 않으면 true를 리턴합니다.
그렇지 않은 경우엔 false를 반환합니다.

@param obj 비교할 객체를 지정합니다.

--- !-> bool

self의 논리값을 반전합니다.

#@end

#@if (version == "1.9.1")
--- clone -> object
--- dup -> object

self를 복사해서 리턴합니다.

@see [[m:Object#clone]], [[m:Object#dup]]

#@end

#@since 1.8.0
--- __getobj__ -> object

위임받는 객체를 리턴합니다.

이 메소드는 서브 클래스에서 재정의할 필요가 있으며
재정의하지 않으면 기본적으로[[c:NotImplementedError]]를 발생시킵니다.

@raise NotImplementedError 서브클래스에서 이 메소드가 제정의되어있지 않으면 발생합니다.

#@end

#@since 1.9.1
--- __setobj__(obj) -> object

위임 받는 객체를 설정합니다.

@param obj 위탁 받는 객체를 지정합니다.

@raise NotImplementedError 서브클래스에서 이 메소드가 제정의되어있지 않으면 발생합니다.

#@end

#@since 1.8.1
--- marshal_dump -> object

직렬화를 지원하기 위해 [[m:Delegator#__getobj__]] 메소드가 리턴하는 객체를 리턴합니다.

--- marshal_load(obj) -> object

직렬화된 객체에서 [[m:Delegator#__getobj__]]가 리턴하는 객체를 복원합니다. @@@

@param obj [[m:Delegator#marshal_dump]] 메소드 리턴값의 복사본

#@end

#@since 1.8.3
--- method_missing(m, *args) -> object

渡されたメソッド名と引数を使って、[[m:Delegator#__getobj__]] が返すオブジェクトへメソッド委譲を行います。

@param m 메소드 이름（심볼）

@param args 메소드에 넘겨질 인수

@return 위임받은 메소드의 리턴값

#@since 1.9.1
@see [[m:BasicObject#method_missing]]
#@else
@see [[m:Object#method_missing]]
#@end

--- respond_to?(m) -> bool

[[m:Delegator#__getobj__]] 메소드가 리턴하는 객체가 m 메소드를 가지고 있으면 true를 리턴합니다.

@param m 메소드 이름

@see [[m:Object#respond_to?]]

#@end

#@since 1.9.2
--- freeze -> self

self의 변경 불가 상태로 만듭니다.

@see [[m:Object#freeze]]

--- methods -> [Symbol]

self 객체에 대해 호출할 수 있는 메소드 목록을 리턴합니다.
이 메소드는 public 메소드와 protected 메소드의 이름을 리턴합니다.

@see [[m:Object#methods]]

--- protected_methods(all = true) -> [Symbol]

self 객체에 정의되어있는 protected 메소드 목록을 리턴합니다.

@param all false를 지정하면 __getobj__ @@@

@see [[m:Object#protected_methods]]

--- public_methods(all = true) -> [Symbol]

self 객체에 대해 호출할 수 있는 public 메소드 목록을 리턴합니다.

@param all false를 지정하면 __getobj__ @@@

@see [[m:Object#public_methods]]

--- respond_to_missing?(m, include_private) -> bool

@param m 메소드 이름을 지정합니다.

@param include_private true를 지정하면 private 메소드도 검색합니다.

#@end

#@#== Constants

#@since 1.8.7
#@until 1.9.1
--- IgnoreBacktracePat -> Regexp

백트레이스에서 무시되는 패턴을 리턴합니다. @@@#@end
#@end

#@include(delegate/SimpleDelegator)

#@end
