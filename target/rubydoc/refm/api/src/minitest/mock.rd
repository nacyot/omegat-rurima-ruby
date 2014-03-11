category Development

간단한 Mock 라이브러리입니다.

= class MiniTest::Mock

간단한 Mock을 실행하는 클래스입니다.


== Class Methods

--- new

객체를 초기화합니다.

== Public Instance Methods

--- expect(name, retval, args = []) -> self

モックを構築するメソッドです。

@param name メソッド名を指定します。

@param retval 返り値として期待する値を指定します。

@param args 引数として期待する値を配列で指定します。

--- verify -> true

Mock을 검증합니다.

@raise MockExpectationError Mock의 검증이 실패하면 발생합니다.

= class MockExpectationError < StandardError

Mock의 검증이 실패하면 발생합니다.
