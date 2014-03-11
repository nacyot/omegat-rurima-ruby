#@since 1.8.1

BigDecimalを使った数学的な機能を提供します。

以下の計算が行えます。

 * sqrt(x, prec)
 * sin (x, prec)
 * cos (x, prec)
 * atan(x, prec)
#@until 1.9.3
 * exp (x, prec)
 * log (x, prec)
#@end
 * PI  (prec)
 * E   (prec)

인수:

: x

  계산이 될 BigDecimal 객체

: prec

  계산 결과의 정밀도

예:

  require "bigdecimal"require "bigdecimal"
  require "bigdecimal/math"

  include BigMath

  a = BigDecimal((PI(100)/2).to_s)
  puts sin(a,100) #=> 0.10000000000000000000......E1

#@since 1.9.3
= reopen BigMath
#@else
#@include(BigMath)
#@end

#@since 1.9.2
== Module Functions
#@else
== Instance Methods
#@end

--- sqrt(x, prec) -> BigDecimal

x의 제곱근을 prec 에 지정한 정밀도로 계산합니다. 

@param x 제곱을을 구할 값

@param prec 계산결과의 정밀도

@railse FloatDomainError x에 0 이하의 값이나 NaN이 입력되는 경우 발생합니다.

@raise ArgumentError prec 에 0 미만의 값이 입력되는 경우 발생합니다.

예:

#@since 1.9.2

  require "bigdecimal/math"

  puts BigMath::sqrt(BigDecimal.new('2'), 10) #=> 0.14142135623730950488016883515E1

#@else

  require "bigdecimal"require "bigdecimal"
  require "bigdecimal/math"

  include BigMath
  puts sqrt(BigDecimal.new('2'), 10) #=> 0.14142135623730950488016883515E1

#@end

--- sin(x, prec) -> BigDecimal

x の正弦関数を prec で指定した精度で計算します。単位はラジアンです。x
に無限大や NaN を指定した場合には NaN を返します。

@param x 計算対象の BigDecimal オブジェクト。単位はラジアン。

@param prec 계산결과의 정밀도

@raise ArgumentError prec に 0 以下が指定された場合に発生します。

예:

#@since 1.9.2

  require "bigdecimal/math"

  puts BigMath::sin(BigDecimal.new('0.5'), 10) #=> 0.479425538604203000273287935689073955184741E0

#@else

  require "bigdecimal"require "bigdecimal"
  require "bigdecimal/math"

  include BigMath
  puts sin(BigDecimal.new('0.5'), 10) #=> 0.479425538604203000273287935689073955184741E0

#@end

--- cos(x, prec) -> BigDecimal

x の余弦関数を prec で指定した精度で計算します。単位はラジアンです。x
に無限大や NaN を指定した場合には NaN を返します。

@param x 計算対象の BigDecimal オブジェクト。単位はラジアン。

@param prec 계산결과의 정밀도

@raise ArgumentError prec に 0 以下が指定された場合に発生します。

예:

#@since 1.9.2

  require "bigdecimal/math"

  puts BigMath::cos(BigDecimal.new('0.5'), 10) #=> 0.8775825618903727161162815826327690580439923E0

#@else

  require "bigdecimal"require "bigdecimal"
  require "bigdecimal/math"

  include BigMath
  puts cos(BigDecimal.new('0.5'), 10) #=> 0.8775825618903727161162815826327690580439923E0

#@end

--- atan(x, prec) -> BigDecimal

x の逆正接関数を prec で指定した精度で計算します。単位はラジアンです。
x に無限大や NaN を指定した場合には NaN を返します。

@param x 計算対象の BigDecimal オブジェクト。単位はラジアン。

@param prec 계산결과의 정밀도

@raise ArgumentError x の絶対値が1以上の場合に発生します。

@raise ArgumentError prec に 0 以下が指定された場合に発生します。

예:

#@since 1.9.2

  require "bigdecimal/math"

  puts BigMath::atan(BigDecimal.new('0.5'), 10) #=> 0.463647609000806116214256237466868871528608E0

#@else

  require "bigdecimal"require "bigdecimal"
  require "bigdecimal/math"

  include BigMath
  puts atan(BigDecimal.new('0.5'), 10) #=> 0.463647609000806116214256237466868871528608E0

#@end

===== 주의

x の絶対値を 0.9999 のような 1 に近すぎる値にすると計算結果が収束しない
可能性があります。

--- PI(prec) -> BigDecimal

円周率を prec で指定した精度で計算します。

@param prec 계산결과의 정밀도

@raise ArgumentError prec に 0 以下が指定された場合に発生します。

예:

#@since 1.9.2

  require "bigdecimal/math"

  puts BigMath::PI(10) #=> 0.314159265359224236485984067E1

#@else

  require "bigdecimal"require "bigdecimal"
  require "bigdecimal/math"

  include BigMath
  puts PI(10) #=> 0.314159265359224236485984067E1

#@end

--- E(prec) -> BigDecimal

自然対数の底 e を prec で指定した精度で計算します。

@param prec 계산결과의 정밀도

@raise ArgumentError prec に 0 以下が指定された場合に発生します。

예:

#@since 1.9.2

  require "bigdecimal/math"

  puts BigMath::E(10) #=> 0.271828182845904523536028752390026306410273E1

#@else

  require "bigdecimal"require "bigdecimal"
  require "bigdecimal/math"

  include BigMath
  puts E(10) #=> 0.271828182845904523536028752390026306410273E1

#@end

#@end
