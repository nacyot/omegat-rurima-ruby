각종 assert 메소드를 제공합니다.

#@until 1.9.1
= class Test::Unit::AssertionFailedError < StandardError
Assertion에 실패한 경우에 [[c:Test::Unit::Assertions]]에서 이 예외가 발생합니다.
#@end

= module Test::Unit::Assertions

#@since 1.9.1
include MiniTest::Assertions
#@end

각종 assert 메소드를 제공하는 모듈입니다.

Test::Unit::TestCase에 include되어서 사용됩니다.
[[lib:test/unit]]의 다른 클래스들에 독립적으로 제공되는 assert 메소드만 사용하는 것도 가능합니다.
assert_block 메소드를 사용해 새로운 assert 메소드를 추가하는 것도 가능합니다.

#@since 1.9.1
assert가 실패하면 [[c:MiniTest::Assertion]] 예외를 발생시킵니다.
#@else
assert가 실패하면 [[c:Test::Unit::AssertionFailedError]] 예외를 발생시킵니다.
#@end
각 assert 메소드의 마지막 인수 message는 테스트가 실패한 경우 표시되는 메세지입니다.


#@until 1.9.1
== Singleton Methods

--- use_pp=(value)

[[lib:pp]]을 통해 출력할지 지정합니다.false를 지정하면 [[lib:pp]]는 require되지 않습니다.

@param value [[lib:pp]]를 사용여부를 나타내는 boolean 변수.
#@end


== Instance Methods

#@until 1.9.1
--- assert(boolean, message = nil)    -> ()

boolean 값이 true이면 테스트가 통과합니다.

@param boolean 테스트할 객체를 지정합니다.

@param message assert가 실패하면 나타낼 메세지를 문자열로 지정
               합니다.지정하지 않은 경우 표시되지 않습니다.

@raise Test::Unit::AssertionFailedError assert가 실패하면 발생하는 예외입니다.

--- assert_instance_of(klass, object, message = "")    -> ()

object가 klass의 직접적인 인스턴스인 경우 테스트가 통과합니다.
[[m:Object#instance_of?]]를 참조해주세요.

@param klass $$$

@param object 테스트할 객체를 지정합니다.

@param message assert가 실패하면 나타낼 메세지를 문자열로 지정
               합니다.지정하지 않은 경우 표시되지 않습니다.

[[m:Test::Unit::Assertions#assert_kind_of]]와 차이가 있으므로 주의해주세요.

@raise Test::Unit::AssertionFailedError assert가 실패하면 발생하는 예외입니다.

--- assert_nil(object, message = "")    -> ()

object가 nil이면 테스트가 통과합니다.

@param object 테스트할 객체를 지정합니다.

@param message assert가 실패하면 나타낼 메세지를 문자열로 지정
               합니다.지정하지 않은 경우 표시되지 않습니다.

@raise Test::Unit::AssertionFailedError assert가 실패하면 발생하는 예외입니다.

@see [[m:Test::Unit::Assertions#assert_not_nil]]

--- assert_kind_of(klass, object, message = "")    -> ()

object.kind_of?(klass)가 true이면 테스트가 통과합니다.

정확히는 object가 klass의 인스턴스거나 서브 클래스의 인스턴스이면 테스트가 통과합니다.
또한 klass가 모듈인 경우에는 object가 klass를 include한 클래스이거나 그 서브 클래스의 인스턴스이면
테스트가 통과합니다.

[[m:Test::Unit::Assertions#assert_instance_of]]와 차이가 있으므로 주의해주세요.

@param klass $$$

@param object 테스트할 객체를 지정합니다.

@param message assert가 실패하면 나타낼 메세지를 문자열로 지정
               합니다.지정하지 않은 경우 표시되지 않습니다.

@raise Test::Unit::AssertionFailedError assert가 실패하면 발생하는 예외입니다.

@see [[m:Object#kind_of?]]

--- assert_respond_to(object, method, message = "")    -> ()

object.respond_to?(method)가 true이면 테스트가 통과합니다.

@param object 테스트할 객체를 지정합니다.

@param method 테스트하는 메소드를 [[c:Symbol]]이나 문자열로 지정합니다.

@param message assert가 실패하면 나타낼 메세지를 문자열로 지정
               합니다.지정하지 않은 경우 표시되지 않습니다.

@raise Test::Unit::AssertionFailedError assert가 실패하면 발생하는 예외입니다.

@see [[m:Object#respond_to?]]

--- assert_match(pattern, string, message = "")    -> ()

string =~ pattern가 true이면 테스트가 통과합니다.

@param pattern 期待するパターンを文字列か正規表現で指定します。문자열을
               지정하면 내부에서 정규표현으로 변환됩니다.

@param string 테스트하려는 문자열을 지정합니다.

@param message assert가 실패하면 나타낼 메세지를 문자열로 지정
               합니다.지정하지 않은 경우 표시되지 않습니다.

@raise Test::Unit::AssertionFailedError assert가 실패하면 발생하는 예외입니다.

@see [[m:Test::Unit::Assertions#assert_no_match]]

--- assert_same(expected, actual, message = "")    -> ()

actual.equal?(expected)가 true이면 테스트가 통과합니다.

[[m:Test::Unit::Assertions#assert_equal]]와 차이가 있으므로 주의해주세요.

@param expected 期待するオブジェクトを指定します。

@param actual 테스트하려는 객체를 지정합니다.

@param message assert가 실패하면 나타낼 메세지를 문자열로 지정
               합니다.지정하지 않은 경우 표시되지 않습니다.

@raise Test::Unit::AssertionFailedError assert가 실패하면 발생하는 예외입니다.

@see [[m:Object#equal?]], [[m:Test::Unit::Assertions#assert_not_same]]

--- assert_operator(object1, operator, object2, message = "")    -> ()

object1.send(operator, object2)가 true이면 테스트가 통과합니다.

@param object1 테스트하려는 객체를 지정합니다.

@param operator 테스트하려는 연산자(메소드)르 [[c:Symbol]]이나
                to_str 메소드를 사용할 수 있는 객체로 지정합니다.

@param object2 테스트하려는 객체를 지정합니다.

@param message assert가 실패하면 나타낼 메세지를 문자열로 지정
               합니다.지정하지 않은 경우 표시되지 않습니다.

@raise Test::Unit::AssertionFailedError assert가 실패하면 발생하는 예외입니다.

--- assert_raises(*args, &block)    -> object

[[m:Test::Unit::Assertions#assert_raise]]의 별칭입니다.

@param args [[m:Test::Unit::Assertions#assert_raise]]에 그대로 넘겨줍니다.

@raise Test::Unit::AssertionFailedError assert가 실패하면 발생하는 예외입니다.

@see [[m:Test::Unit::Assertions#assert_raise]]

--- flunk(message = "Flunked")    -> ()

항상 테스트에 실패합니다.

완성된 테스트를 작성하기 전에 테스트를 일부러 실패시키기 위해 사용합니다.

@param message assert가 실패하면 나타낼 메세지를 문자열로 지정
               합니다.지정하지 않은 경우 표시되지 않습니다.

@raise Test::Unit::AssertionFailedError 무조건 발생합니다.

--- assert_throws(expected_symbol, message = "") { ... }    -> ()

블록을 실행해서 :expected_symbol이 thorw되면 테스트가 통과합니다.

@param expected_symbol throw されると期待するシンボルを指定します。

@param message assert가 실패하면 나타낼 메세지를 문자열로 지정
               합니다.지정하지 않은 경우 표시되지 않습니다.

@raise Test::Unit::AssertionFailedError assert가 실패하면 발생하는 예외입니다.

--- assert_in_delta(expected_float, actual_float, delta, message = "")    -> ()

(expected_float.to_f - actual_float.to_f).abs <= delta.to_f
가 true이면 테스트가 통과합니다.

@param expected_float 期待する実数値を指定します。

@param actual_float 테스트하는 실수값을 지정합니다.

@param delta 허용되는 오차 범위를 절대값으로 지정합니다.

@param message assert가 실패하면 나타낼 메세지를 문자열로 지정
               합니다.지정하지 않은 경우 표시되지 않습니다.

@raise Test::Unit::AssertionFailedError assert가 실패하면 발생하는 예외입니다.

--- assert_send(send_array, message = "")    -> ()

send_array[0].__send__(send_array[1], *send_array[2..-1])
가 true이면 테스트가 통과합니다.

@param send_array 検証するオブジェクトを [レシーバ、メソッド、メソッドの引数]
                  で指定します。

@param message assert가 실패하면 나타낼 메세지를 문자열로 지정
               합니다.지정하지 않은 경우 표시되지 않습니다.

@raise Test::Unit::AssertionFailedError assert가 실패하면 발생하는 예외입니다.

--- assert_block(message = "assert_block failed.") { ... }    -> ()

블록을 실행하고 그 결과가 true이면 테스트가 통과합니다.

새로운 assert 메소드를 정의할 때 사용합니다.

  def deny(boolean, message = nil)
    message = build_message message, '<?> is not false or nil.', boolean
    assert_block message do
      not boolean
    end
  end

@param message assert가 실패하면 나타낼 메세지를 문자열로 지정
               합니다.지정하지 않은 경우 표시되지 않습니다.

@raise Test::Unit::AssertionFailedError assert가 실패하면 발생하는 예외입니다.
#@end

--- assert_equal(expected, actual, message = nil)    -> ()

expected == actual 이면 테스트가 통과합니다.

#@since 1.9.1
[[m:MiniTest::Assertions#assert_same]]와 차이가 있으므로 주의해주세요.
#@else
[[m:Test::Unit::Assertions#assert_same]]와 차이가 있으므로 주의해주세요.
#@end

@param expected 期待するオブジェクトを指定します。

@param actual 테스트하려는 객체를 지정합니다.

@param message assert가 실패하면 나타낼 메세지를 문자열로 지정
               합니다.지정하지 않은 경우 표시되지 않습니다.

#@since 1.9.1
@raise MiniTest::Assertion assert가 실패하면 발생합니다.
#@else
@raise Test::Unit::AssertionFailedError assert가 실패하면 발생합니다.
#@end

@see [[m:Test::Unit::Assertions#assert_not_equal]], [[m:Object#==]]

--- assert_not_equal(expected, actual, message = "")    -> ()

expected != actual이면 테스트가 통과합니다.

@param expected 同じものではないと期待するオブジェクトを指定します。

@param actual 테스트하려는 객체를 지정합니다.

@param message assert가 실패하면 나타낼 메세지를 문자열로 지정
               합니다.지정하지 않은 경우 표시되지 않습니다.

#@since 1.9.1
@raise MiniTest::Assertion assert가 실패하면 발생합니다.
#@else
@raise Test::Unit::AssertionFailedError assert가 실패하면 발생합니다.
#@end

@see [[m:Test::Unit::Assertions#assert_equal]]

--- assert_not_nil(object, message = "")    -> ()

object가 nil이 아니면 테스트가 통과합니다.

@param object 테스트할 객체를 지정합니다.

@param message assert가 실패하면 나타낼 메세지를 문자열로 지정
               합니다.지정하지 않은 경우 표시되지 않습니다.

#@since 1.9.1
@raise MiniTest::Assertion assert가 실패하면 발생합니다.

@see [[m:MiniTest::Assertions#assert_nil]]
#@else
@raise Test::Unit::AssertionFailedError assert가 실패하면 발생합니다.

@see [[m:Test::Unit::Assertions#assert_nil]]
#@end

--- assert_no_match(regexp, string, message = "")    -> ()

regexp !~ string가 true이면 테스트가 통과합니다.

@param regexp マッチしないと期待するパターンを正規表現で指定します。

@param string 테스트하려는 문자열을 지정합니다.

@param message assert가 실패하면 나타낼 메세지를 문자열로 지정
               합니다.지정하지 않은 경우 표시되지 않습니다.

#@since 1.9.1
@raise MiniTest::Assertion assert가 실패하면 발생합니다.

[[m:MiniTest::Assertions#assert_match]]와 달리 regexp에는 정규표현 객체만
지정할 수 있습니다.
#@else
@raise Test::Unit::AssertionFailedError assert가 실패하면 발생합니다.

[[m:Test::Unit::Assertions#assert_match]]와 달리 regexp에는 정규표현 객체만
지정할 수 있습니다.
#@end

--- assert_not_same(expected, actual, message = "")    -> ()

!actual.equal?(expected)가 true이면 테스트가 통과합니다.

@param expected 期待するオブジェクトを指定します。

@param actual 테스트하려는 객체를 지정합니다.

@param message assert가 실패하면 나타낼 메세지를 문자열로 지정
               합니다.지정하지 않은 경우 표시되지 않습니다.

#@since 1.9.1
@raise MiniTest::Assertion assert가 실패하면 발생합니다.

@see [[m:Object#equal?]], [[m:MiniTest::Assertions#assert_same]]
#@else
@raise Test::Unit::AssertionFailedError assert が失敗した時に発生します。

@see [[m:Object#equal?]], [[m:Test::Unit::Assertions#assert_same]]
#@end

#@since 1.8.1

--- assert_raise(message = "") { ... }    -> object
--- assert_raise(klass1, klass2, ..., message = "") { ... }    -> object

블록을 실행해서 예외가 발생하고 그 예외가
klass1, klass2,.... 중 하나의 인스턴스이면 테스트가 통과합니다.

assert가 통과되면 실제로 발생된 예외를 리턴합니다.

@param klassX 예외 클래스를 지정합니다.

@param message assert가 실패하면 나타낼 메세지를 문자열로 지정
               합니다.지정하지 않은 경우 표시되지 않습니다.

#@since 1.9.1
@raise MiniTest::Assertion assert가 실패하면 발생합니다.
#@else
@raise Test::Unit::AssertionFailedError assert가 실패하면 발생합니다.
#@end

#@end

--- build_message(head, template = nil, *arguments)

테스트가 실패하면 표시되는 메세지를 작성합니다.

@param head templateから作成するメッセージの前に表示する文字列を指定します。

@param template 作成するメッセージのテンプレートを文字列で指定します。

@param arguments template 内の '?' を置き換えるオブジェクトを配列で指定します。

@return 作成したメッセージをTest::Unit::Assertions::AssertionMessageの
        インスタンスで返します。

head は template の前に追加されます。template に指定した文字列に '?' が
含まれていた場合は、arguments に指定したオブジェクトでそれぞれ置き換え
られます。

--- assert_nothing_raised(message = "") { ... }
--- assert_nothing_raised(klass1, klass2, ..., message = "") { ... }

ブロックを実行して例外が起きなければパスします。

ブロックを実行して発生した例外が klass1, klass2, ..., のいずれかのクラスの
インスタンスである場合は、assert は失敗扱いとなり、Test::Unit::AssertionFailedError
を投げます。そうでない場合は、エラー扱いとなり発生した例外を再び投げます。

@param klassX 예외 클래스를 지정합니다.

@param message assert가 실패하면 나타낼 메세지를 문자열로 지정
               합니다.지정하지 않은 경우 표시되지 않습니다.

#@since 1.9.1
@raise MiniTest::Assertion assert가 실패하면 발생합니다.
#@else
@raise Test::Unit::AssertionFailedError assert가 실패하면 발생합니다.
#@end

--- assert_nothing_thrown(message = "") { ... }    -> ()

블록을 실행해서 throw가 발생하지 않으면 테스트가 통과합니다.

@param message assert가 실패하면 나타낼 메세지를 문자열로 지정
               합니다.지정하지 않은 경우 표시되지 않습니다.

#@since 1.9.1
@raise MiniTest::Assertion assert가 실패하면 발생합니다.
#@else
@raise Test::Unit::AssertionFailedError assert가 실패하면 발생합니다.
#@end

#@since 1.9.1
--- mu_pp(obj)     -> String

obj를 사람이 이해하기 쉬운 문자열로 리턴합니다.

@param obj 임의의 객체

@return obj를 사람이 이해하기 쉬운 문자열로 변환해서 리턴.
#@end
