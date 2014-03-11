category Development

BDD 방식의 테스트를 작성하기 위한 클래스와 메소드가 정의된 라이브러리입니다.

이 라이브러리 [[c:Object]]에 BDD (Bebavior Driven Development)를 위한 테스트 메소드를 추가합니다.
추가된 메소드는 [[c:MiniTest::Assertions]]에 정의된 메소드에 $$$ 

#@# message 를 지정하면 이상하게 작동함.

= reopen Module

== Public Instance Methods

--- infect_with_assertions(positive_prefix, negative_prefix, skip_regexp, map = {}) -> ()

BDD 방식으로 테스트를 작성하기 위해 사용하는 메소드들을 정의합니다.

@param positive_prefix assert 대신에 사용할 prefix를 지정합니다.

@param negative_prefix refute 대신에 사용할 prefix를 지정합니다.

@param skip_regexp 이 정규표현에 들어맞는 메소드는 정의하지 않습니다.

@param map 메소드 이름의 변환 규칙을 해쉬로 지정합니다.

= reopen Object

== Public Instance Methods

--- must_be_empty -> true

self가 비어있을 경우 테스트가 통과합니다.

@raise MiniTest::Assertion self가 empty?메소드가 없는 경우 발생하며,                           self가 비어있지 않을 경우 발생합니다.

@see [[m:MiniTest::Assertions#assert_empty]]

--- must_equal(expected) -> true

self가 비교되는 객체와 같은 경우 테스트가 통과합니다.

@param expected 비교하려는 객체를 지정합니다.

@raise MiniTest::Assertion 주어진 값과 실제 값이 같지 않은 경우 발생합니다.

@see [[m:Object#==]], [[m:MiniTest::Assertions#assert_equal]]

--- must_be_within_delta(expected, delta = 0.001) -> true
--- must_be_close_to(expected, delta = 0.001) -> true

self와 예상값의 차이가 절대치로 주어진 오차범위 내에 있으면 테스트가 통과합니다.

@param expected 예상값을 지정합니다.

@param delta 허용 오차범위를 지정합니다.

@raise MiniTest::Assertion 예상값과 실제 값의 차이가 허용 오차 범위를 벗어났을 때 발생합니다.

@see [[m:MiniTest::Assertions#assert_in_delta]]

--- must_be_within_epsilon(actual, epsilon = 0.001) -> true
self와 실제 값의 상대 오차가 허용 범위 내에 있으면 테스트가 통과합니다.

@param actual 실제 값을 지정합니다.

@param epsilon 허용 상대 오차를 지정합니다.

@raise MiniTest::Assertion 테스트가 실패하면 발생합니다.

--- must_include(object) -> true

自身に与えられたオブジェクトが含まれている場合、検査にパスしたことになります。

@param object 任意のオブジェクトを指定します。

@raise MiniTest::Assertion 自身が include?메소드가 없는 경우 발생하며,                           自身に与えられたオブジェクトが含まれていない場合に発生します。

@see [[m:MiniTest::Assertions#assert_includes]]

--- must_be_instance_of(klass) -> true

自身が与えられたクラスのインスタンスである場合、検査にパスしたことになります。

@param klass 任意のクラスを指定します。

@raise MiniTest::Assertion 自身がが与えられたクラスの直接のインスタンスでない場合に発生します。

@see [[m:MiniTest::Assertions#assert_instance_of]]

--- must_be_kind_of(klass) -> true

自身がが与えられたクラスまたはそのサブクラスのインスタンス
である場合、検査にパスしたことになります。

@param klass 自身が所属することを期待するクラスを指定します。

@raise MiniTest::Assertion 自身が与えられたクラスまたはそのサブクラスのインスタンスではない場合に発生します。

@see [[m:MiniTest::Assertions#assert_kind_of]]

--- must_match(regexp) -> true

自身がが与えられた正規表現にマッチした場合、検査にパスしたことになります。

@param regexp 正規表現か文字列を指定します。文字列を指定した場合は正規表現に変換してから
              使用します。

@raise MiniTest::Assertion 自身が与えられた正規表現にマッチしなかった場合に発生します。

@see [[m:MiniTest::Assertions#assert_match]]

--- must_be_nil -> true

自身が nil である場合、検査にパスしたことになります。

@raise MiniTest::Assertion 自身が nil でない場合に発生します。

@see [[m:MiniTest::Assertions#assert_nil]]

--- must_be -> true

自身の評価結果が死んである場合、検査にパスしたことになります。

@raise MiniTest::Assertion 自身の評価結果が偽である場合に発生します。

@see [[m:MiniTest::Assertions#assert]]

--- must_raise(*args) -> true
自身を評価中に与えられた例外が発生する場合、検査にパスしたことになります。

@param args 自身を評価中に発生する可能性のある例外クラスを一つ以上指定します。

@raise MiniTest::Assertion 自身を評価した結果、例外が発生しない場合に発生します。                           また、自身を評価中に発生した例外が、与えられた例外
                           またはそのサブクラスでない場合に発生します。

@see [[m:MiniTest::Assertions#assert_raises]]

--- must_respond_to(method_name) -> true
自身が与えられたメソッドを持つ場合、検査にパスしたことになります。

@param method_name メソッド名を指定します。

@raise MiniTest::Assertion 自身が与えられたメソッドを持たない場合に発生します。

@see [[m:MiniTest::Assertions#assert_respond_to]]

--- must_be_same_as(actual) -> true
自身と与えられたオブジェクトの [[m:Object#object_id]] が同じ場合、検査にパスしたことになります。

@param actual 任意のオブジェクトを指定します。

@raise MiniTest::Assertion 自身と与えられたオブジェクトが異なる場合に発生します。

--- must_send -> true
#@todo
#@# どうやって使う？#@# 引数から、式を取り出して評価した結果が真の場合、検査にパスしたことになります。#@# 
#@# @param array 第一要素にレシーバとなる任意のオブジェクト、第二要素にメソッド名、
#@#              第三要素にパラメータをそれぞれ指定した配列を指定します。#@# 
#@# @raise MiniTest::Assertion 取り出した式が偽を返す場合に発生します。#@#
#@# @see [[m:MiniTest::Assertions#assert_send]]

--- must_throw(tag) -> true
自身を評価中に、与えられたタグが [[m:Kernel.#throw]] された場合、検査にパスしたことになります。

@param tag 自身を評価中に [[m:Kernel.#throw]] されるタグを任意のオブジェクトとして指定します。

@raise MiniTest::Assertion 与えられたタグが [[m:Kernel.#throw]] されなかった場合に発生します。

@see [[m:MiniTest::Assertions#assert_throws]]

= reopen Kernel

== Private Instance Methods

--- describe(desc){ ... }

与えられた説明文から名前を作成してテストクラスを定義します。

クラスの定義は、与えられたブロックの内容になります。

@param desc ブロックに対する説明を指定します。

= class MiniTest::Unit::TestCase
= class MiniTest::Spec < MiniTest::Unit::TestCase

BDD 風にテストを書くための [[c:MiniTest::Unit::TestCase]] に対するラッパークラスです。

== Singleton Methods

--- new(name)

与えられた名前で自身を初期化します。

--- current -> MiniTest::Spec

現在実行中の [[c:MiniTest::Spec]] のインスタンスを返します。

--- before(type = :each){ ... } -> Proc

各テストの前に実行するブロックを登録します。

@param type :each を指定することができます。

@raise RuntimeError type に :each 以外を指定すると発生します。

--- after(type = :each){ ... } -> Proc

各テストの後に実行するブロックを登録します。

@param type :each を指定することができます。

@raise RuntimeError type に :each 以外を指定すると発生します。

--- it(desc){ ... } -> ()

テストケースを一つ定義します。

与えられたブロックが一つのテストケースに相当します。

@param desc テストケースの説明を指定します。

