#@since 1.8.0

ヤコビ行列を計算する機能を提供します。

実行例:

  require "bigdecimal"require "bigdecimal"
  require "bigdecimal/jacobian"
#@until 1.9.2
  include Jacobian
#@end

  ...

#@since 1.9.2
  dfdx = Jacobian.jacobian(f,fx,x)
#@else
  dfdx = jacobian(f,fx,x)
#@end

引数 f には関数を表すオブジェクトを指定します。以下のメソッドに応答でき
る必要があります。

: f.values(x)

  点 x における関数の値を数値の配列で返します。

: f.zero

  0.0 を示す値を返します。

: f.one

  1.0 を示す値を返します。

: f.two

  2.0 を示す値を返します。

: f.ten

  10.0 を示す値を返します。

: f.eps

  収束の基準になる epsilon 値を返します。2 つの値が異なる値かどうかを比
  較するのに使用されます。|a - b| < f.eps となる 2 つの値は同じ値である
  とみなされます。

引数 fx には f.values(x) の結果を指定します。

引数 x にはヤコビ行列を求める点 x にあたるベクトルを指定します。

戻り値 dfdx はヤコビ行列を数値オブジェクトの配列で返します。(各要素を
Row-major order で 1 次元の配列にしたオブジェクトを指定します)

= module Jacobian

ヤコビ行列を計算する機能を提供するモジュールです。

#@since 1.9.2
== Module Functions
#@else
== Instance Methods
#@end

--- isEqual(a, b, zero = 0.0, e = 1.0e-8) -> bool

引数 a、b が等しいかどうかを返します。라이브러리 내부에서 사용됩니다.

--- dfdxi(f, fx, x, i) -> [Numeric]

関数 f の 微分係数を計算します。라이브러리 내부에서 사용됩니다.

--- jacobian(f, fx, x) -> [Numeric]

ヤコビ行列を計算します。

@param f ヤコビ行列を求めたい関数を表すオブジェクトを指定します。자세한 사항은
         [[lib:bigdecimal/jacobian]] をご覧ください。

@param fx f.values(x) の結果を表すベクトルを数値の配列で指定します。

@param x ヤコビ行列を求める点 x にあたるベクトルを数値の配列で指定します。

@return ヤコビ行列を返します。(各要素を Row-major order で 1 次元の配列
        にしたオブジェクトを指定します)

#@since 2.0.0
@raise RuntimeError 計算結果が特異ヤコビ行列になった場合に発生します。#@end

#@end
