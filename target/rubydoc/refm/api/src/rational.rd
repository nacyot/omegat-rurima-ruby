category Math

유리수를 다루는 라이브러리입니다.

#@since 1.9.1

1.9 이후로 [[c:Rational]] 클래스가 Ruby 내장 클래스가 되었습니다. rational 라이브러리는 호환을 위해 남겨져있습니다.

= reopen Fixnum
== Instance Methods

--- power!(other) -> Numeric
--- rpower(other) -> Numeric

멱승(제곱)을 계산합니다.
[[m:Fixnum#**]] 의 별칭입니다.

@param other 멱승의 지수

--- quof(other) -> Float | Complex

self를 other로 나눈 몫을 리턴합니다.
[[m:Fixnum#fdiv]] 의 별칭입니다.

@param other 나누는 수

--- rdiv(other) -> Rational | Float | Complex

self를 other로 나눈 몫을 리턴합니다.
[[m:Numeric#quo]] 의 별칭입니다.

@param other 나누는 수

= reopen Bignum
== Instance Methods

--- power!(other) -> Numeric
--- rpower(other) -> Numeric

멱승(제곱)을 계산합니다.
[[m:Bignum#**]] 의 별칭입니다.

@param other 멱승의 지수

--- quof(other) -> Float | Complex

self를 other로 나눈 몫을 리턴합니다.
[[m:Bignum#fdiv]] 의 별칭입니다.

@param other 나누는 수

--- rdiv(other) -> Rational | Float | Complex

self를 other로 나눈 몫을 리턴합니다.
[[m:Numeric#quo]] 의 별칭입니다.

@param other 나누는 수

#@else

require 하면 수치계산의 결과를 [[c:Rational]] 객체로 리턴합니다.

  1.quo(2)              # => 0.5
  require 'rational'
  1.quo(2)              # => Rational(1,2)

= reopen Kernel
== Module Functions
--- Rational(num, den = 1) -> Rational | Integer

[[c:Rational]] 객체를 생성합니다.

@param num 분자를 지정합니다.

@param den 분모를 지정합니다.省略した場合は 1 です。

@raise ZeroDivisionError den に 0 を指定した場合に発生します。

引数 num、den の両方を指定した場合、num/den を既約になるまで約分した
[[c:Rational]] オブジェクトを返します。

num と den には整数を指定します。den が 1 の時に限り、num に
[[c:Rational]] オブジェクトを指定する事もできます。

예:

  Rational(1, 3)              # => Rational(1, 3)
  Rational(2, 6)              # => Rational(1, 3)
  Rational(Rational(1, 3), 1) # => Rational(1, 3)

それ以外のオブジェクトを指定すると例外が発生します。

  Rational(Rational(1, 3), 2) # => NoMethodError
  Rational(1.1, 2.3)          # => NoMethodError
  Rational("1/3")             # => NoMethodError
  Rational(nil)               # => NoMethodError

[[lib:mathn]] を require 済みの場合は約分して整数になる値を指定すると
[[c:Integer]] を返します。

  Rational(4, 2)              # => Rational(2, 1)
  require "mathn"
  Rational(4, 2)              # => 2

約分していない [[c:Rational]] オブジェクトを作成する場合は
[[m:Rational.new!]] を使用します。ただし、1.9 以降では使用できない事に
注意してください。

@see [[m:Rational.new!]], [[m:Rational.reduce]], [[lib:mathn]]

= redefine Integer


== Instance Methods

--- /(other)   -> Rational | Float | Integer

self를 other로 나눈 값을 리턴합니다.

@param other 自身を割る数

計算結果は以下のようになります。

  * otherが有理数(Rational)ならば、有理数(Rational)を返す。  * otherがそれ以外なら、[[m:Integer#/]]と同じ。つまり、
    other が整数(Integer)ならば、整数(Integer)を(整除)、浮動小数(Float)ならば、
    浮動小数(Float)を返す。    ただし、いずれも、other == 0 の時は、[[c:ZeroDivisionError]]となる。

@raise ZeroDivisionError other が 0 の時に発生します。

--- **(other)  -> Rational | Float | Integer

멱승(제곱)을 계산합니다.

@param other 自身を other 乗する数

計算結果は以下のようになります。

  * otherが正または0の整数(Integer)ならば、整数(Integer)を返す。  * otherが負の整数(Integer)ならば、有理数(Rational)を返す。  * otherが有理数(Rational)や浮動小数(Float)ならば、浮動小数(Float)を返す。

예:

  2 **  3             #=> 8
  2 ** -3             #=> Rational(1, 8)
  2 ** Rational(3)    #=> 8.0
  2 ** Rational(1, 2) #=> 1.4142135623731

= reopen Integer


== Instance Methods

--- power!(other) -> Integer | Float

멱승(제곱)을 계산합니다.

@param other 自身を other 乗する数

[[lib:rational]]で再定義される前の[[m:Integer#**]]の別名です。
other が正または 0 の整数 (Integer) ならば、整数 (Integer) を、それ以外
なら、浮動小数 (Float) を返します。

--- to_r -> Rational

self를 [[c:Rational]]으로 변환합니다.

예:

  1.to_r        # => Rational(1, 1)
  (1<<64).to_r  # => Rational(18446744073709551616, 1)

--- gcd(n) -> Integer

self와 정수 n의 최대공약수를 리턴합니다.

@param n 自身との最大公約数を計算する数

  2.gcd(2)                    # => 2
  3.gcd(7)                    # => 1
  3.gcd(-7)                   # => 1
  ((1<<31)-1).gcd((1<<61)-1)  # => 1

self나 n에 0이면 0이 아닌 수의 절대값을 리턴합니다.

  3.gcd(0)              # => 3
  0.gcd(-7)             # => 7

@see [[m:Integer#lcm]], [[m:Integer#gcdlcm]]

--- lcm(n) -> Integer

self와 정수 n의 최소공배수를 리턴합니다.

@param n 自身との最小公倍数を計算する数

예:

  2.lcm(2)                    # => 2
  3.lcm(-7)                   # => 21
  ((1<<31)-1).lcm((1<<61)-1)  # => 4951760154835678088235319297

self나 n이 0이면 0을 리턴합니다.

  3.lcm(0)                    # => 0
  0.lcm(-7)                   # => 0

@see [[m:Integer#gcd]], [[m:Integer#gcdlcm]]

--- gcdlcm(n) -> [Integer]

自身と整数 n の最大公約数と最小公倍数の配列 [self.gcd(n), self.lcm(n)]
を返します。

@param n 自身との最大公約数と最小公倍数を計算する数

@raise ArgumentError n에 정수가 아닌 객체를 지정하면 발생합니다.

예:

  6.gcdlcm(9)                    # => [3, 18]
  2.gcdlcm(2)                    # => [2, 2]
  3.gcdlcm(-7)                   # => [1, 21]
  ((1<<31)-1).gcdlcm((1<<61)-1)  # => [1, 4951760154835678088235319297]

@see [[m:Integer#gcd]], [[m:Integer#lcm]]

--- numerator -> Integer

분자를 리턴합니다. 항상 self입니다.

@return 분자를 리턴합니다.

@see [[m:Integer#denominator]]

--- denominator -> Integer

분모를 리턴합니다. 항상 1입니다.

@return 분모를 리턴합니다.

@see [[m:Integer#numerator]]

= redefine Fixnum
== Instance Methods

--- quo(other) -> Rational

self를 other로 나눈 몫을 리턴합니다.

再定義前と違って計算結果が有理数の範囲に収まる場合は [[c:Rational]] オブジェクトを返します。

@param other 自身を割る数

예:

  require 'rational'
  1.quo(2)              # => Rational(1,2)
  1.quo(2.0)            # => 0.5

--- **(other) -> Integer | Float | Rational
--- rpower (other) -> Integer | Float | Rational

멱승(제곱)을 계산합니다.other が負の整数の場合、計算結果を
[[c:Rational]] オブジェクトで返します。

@param other 自身を other 乗する数

  2.rpower(3)           # => 8
  2.rpower(-3)          # => Rational(1, 8)

= reopen Fixnum
== Instance Methods
--- power!(other) -> Integer | Float

멱승(제곱)을 계산합니다.

@param other 自身を other 乗する数

[[lib:rational]]で再定義される前の[[m:Fixnum#**]]の別名です。
other が正または 0 の整数 (Integer) ならば、整数 (Integer) を、それ以外
なら、浮動小数 (Float) を返します。

= redefine Bignum
== Instance Methods
--- quo(other) -> Rational

self를 other로 나눈 몫을 리턴합니다.

再定義前と違って計算結果が有理数の範囲に収まる場合は [[c:Rational]] オブジェクトを返します。

@param other 自身を割る数

예:

  require 'rational'
  (1<<32).quo(2)              # => Rational(2147483648, 1)
  (1<<32).quo(2.0)            # => 2147483648.0

--- **(other) -> Integer | Float | Rational
--- rpower (other) -> Integer | Float | Rational

멱승(제곱)을 계산합니다.other が負の整数の場合、計算結果を
[[c:Rational]] オブジェクトで返します。

  (1<<32).rpower(2)           # => 18446744073709551616
  (1<<32).rpower(-2)          # => Rational(1, 18446744073709551616)

@param other 自身を other 乗する数

= reopen  Bignum
== Instance Methods
--- power!(other) -> Integer | Float

멱승(제곱)을 계산합니다.

@param other 自身を other 乗する数

[[lib:rational]]で再定義される前の[[m:Bignum#**]]の別名です。
other が正または 0 の整数 (Integer) ならば、整数 (Integer) を、それ以外
なら、浮動小数 (Float) を返します。

= class Rational < Numeric

有理数を扱うクラスです。

「1/3」のような有理数を扱う事ができます。[[c:Integer]] や [[c:Float]]
と同様に Rational.new ではなく、 [[m:Kernel.#Rational]] を使用して
[[c:Rational]] オブジェクトを作成します。

Integer < Rational < Float の順に強いです。つまり other が Float なら、
self を Float に変換してから演算子を適用します。other が Integer なら other を
Rational に変換してから演算子を適用します。冪乗は例外です。

== Class Methods
--- new!(num, den = 1) -> Rational

[[c:Rational]] 객체를 생성합니다.

@param num 분자를 지정합니다.

@param den 분모를 지정합니다.省略した場合は 1 です。

[[m:Kernel#Rational]] とは異なり、約分していない [[c:Rational]] オブジェ
クトを返します。

예:

  Rational.new!(1, 3)         # => Rational(1, 3)
  Rational.new!(2, 6)         # => Rational(2, 6)

また、引数のチェックも行われません。

예:

  Rational.new!(1, 0)         # => Rational(1, 0)
  Rational(1, 0)              # => ZeroDivisionError

주의:

Rational.new!は 1.9 で廃止されました。[[m:Kernel.#Rational]] の方を使
用してください。

  # 1.9.1 の場合
  Rational.new!(1, 3)  # => NoMethodError

--- reduce(num, den = 1) -> Rational

約分された [[c:Rational]] オブジェクトを生成します。

@param num 분자를 지정합니다.

@param den 분모를 지정합니다.省略した場合は 1 です。

@raise ZeroDivisionError den に 0 を指定した場合に発生します。

引数 num、den の両方を指定した場合、num/den を既約になるまで約分した
[[c:Rational]] オブジェクトを返します。

[[m:Kernel#Rational]] とは異なり、num と den には整数しか指定できません。

예:

  Rational.reduce(2, 6)              # => Rational(1, 3)
  Rational.reduce(Rational(1, 3), 1) # => NoMethodError: undefined method `gcd' for Rational(1, 3):Rational

주의:

Rational.reduce は 1.9 系 では廃止されました。[[m:Kernel.#Rational]] の
方を使用してください。

  # 1.9.1 の場合
  Rational.reduce(2, 6)  # => NoMethodError


== Instance Methods

--- numerator -> Integer

分子を返します。

@return 분자를 리턴합니다.

예:

  Rational(7).numerator       # => 7
  Rational(7, 1).numerator    # => 7
  Rational(9, -4).numerator   # => -9
  Rational(-2, -10).numerator # => 1

@see [[m:Rational#denominator]]

--- denominator -> Integer

分母を返します。常に正の整数を返します。

@return 분모를 리턴합니다.

예:

  Rational(7).denominator       # => 1
  Rational(7, 1).denominator    # => 1
  Rational(9, -4).denominator   # => 4
  Rational(-2, -10).denominator # => 5

@see [[m:Rational#numerator]]

--- +(other) -> Rational | Float

self에 other를 더한 값을 리턴합니다.

@param other 自身に足す数

other に [[c:Float]] を指定した場合は、計算結果を [[c:Float]] で返しま
す。

예:

  Rational(3, 4) + 2               # => Rational(11, 4)
  Rational(3, 4) + Rational(2, 1)  # => Rational(11, 4)
  Rational(3, 4) + 2.0             # => 2.75

--- -(other) -> Rational | Float

self에서 other를 뺀 값을 리턴합니다.

@param other 自身から引く数

other に [[c:Float]] を指定した場合は、計算結果を [[c:Float]] で返しま
す。

예:

  Rational(3, 4) - 1   # => Rational(-1, 4)
  Rational(3, 4) - 0.5 # => 0.25

--- *(other) -> Rational | Float

self에 other을 곱한 값을 리턴합니다.

@param other 自身に掛ける数

other に [[c:Float]] を指定した場合は、計算結果を [[c:Float]] で返しま
す。

예:

  Rational(3, 4) * 2              # => Rational(3, 2)
  Rational(3, 4) * 4              # => Rational(3, 1)
  Rational(3, 4) * 0.5            # => 0.375
  Rational(3, 4) * Rational(1, 2) # => Rational(3, 8)

other に 0 を指定した場合も [[c:Rational]] を返します。

  Rational(3, 4) * 0              # => Rational(0, 1)

--- /(other)   -> Rational | Float

self를 other로 나눈 값을 리턴합니다.

@param other 自身を割る数

other に [[c:Float]] を指定した場合は、計算結果を [[c:Float]] で返しま
す。

예:

  Rational(3, 4) / 2              # => Rational(3, 8)
  Rational(3, 4) / Rational(2, 1) # => Rational(3, 8)
  Rational(3, 4) / 2.0            # => 0.375
  Rational(3, 4) / 0              # => ZeroDivisionError

@raise ZeroDivisionError other が 0 の時に発生します。

--- %(other)      -> Rational | Float

self를 other로 나눈 나머지를 리턴합니다.絶対値が self の絶対値を越えない、符号が self と同じ
Numeric を返します。

@param other 自身を割る数

예:

  Rational(3, 4) % 2               # => Rational(3, 4)
  Rational(3, 4) % Rational(2, 1)  # => Rational(3, 4)
  Rational(3, 4) % 2.0             # => 0.75

--- **(other) -> Rational | Float

멱승(제곱)을 계산합니다.

@param other 自身を other 乗する数

other に整数を指定した場合は、計算結果を [[c:Rational]] で返します。
other に整数以外を指定した場合は計算結果を [[c:Float]] で返します。

예:

  Rational(3, 4) ** 2              # => Rational(9, 16)
  Rational(3, 4) ** Rational(2, 1) # => 0.5625
  Rational(3, 4) ** 2.0            # => 0.5625

주의:

1.9 以降は計算結果のオブジェクトが異なる場合がある事に注意してください。
other に [[c:Rational]] を指定した場合には戻り値が [[c:Rational]] を返
す場合があります。

  # 1.9.1 の場合
  Rational(3, 4) ** Rational(2, 1)  # => (9/16)

#@since 1.8.7
--- div(other) -> Integer

self を other で割った整数の商を返します。

@param other 自身を割る数

예:

  Rational(1, 2).div(Rational(2, 3)) # => 0

#@end

--- divmod(other) -> [Integer, Float | Rational]

self を other で割った、商と余りの配列を返します。

other に [[c:Float]] を指定した場合は、余りを [[c:Float]] で返します。

@param other 自身を割る数

예:

  Rational(3,4).divmod(Rational(2,3))  # => [1, Rational(1, 12)]
  Rational(-3,4).divmod(Rational(2,3)) # => [-2, Rational(7, 12)]
  Rational(3,4).divmod(Rational(-2,3)) # => [-2, Rational(-7, 12)]

  Rational(9,4).divmod(2)              # => [1, Rational(1, 4)]
  Rational(9,4).divmod(Rational(2, 1)) # => [1, Rational(1, 4)]
  Rational(9,4).divmod(2.0)            # => [1, 0.25]

@see [[m:Numeric#divmod]]

--- abs -> Rational

自身の絶対値を返します。

예:

  Rational(1, 2).abs.to_s  # => 1/2
  Rational(-1, 2).abs.to_s # => 1/2

--- ==(other) -> bool

같은 값인지 판정합니다.

@param other 自身と比較する数値

@return      self と other が等しい場合 true を返します。             그렇지 않으면 false를 리턴합니다.

예:

  Rational(2, 3)  == Rational(2, 3)   # => true
  Rational(5)     == 5                # => true
  Rational(0)     == 0.0              # => true
  Rational(1, 3)  == 0.33             # => false
  Rational(1, 2)  == '1/2'            # => false

주의:

[[m:Rational.new!]] で作成したオブジェクトと比較した場合、同じ数値を表
すオブジェクトでも true を返さない事があります。

  Rational(1,2) == Rational(4,8)          # => true
  Rational(1,2) == Rational.new!(4,8)     # => false

詳しくは [[m:Rational.new!]] を確認してください。

--- <=>(other) -> -1 | 0 | 1 | nil

self と other を比較して、self が大きい時に 1、等しい時に 0、小さい時に
-1 を返します。比較できない場合はnilを返します。

@param other 自身と比較する数値

@return -1 か 0 か 1 か nil を返します。

예:

  Rational(2, 3)  <=> Rational(2, 3)  # => 0
  Rational(5)     <=> 5               # => 0
  Rational(2, 3)  <=> Rational(1,3)   # => 1
  Rational(1, 3)  <=> 1               # => -1
  Rational(1, 3)  <=> 0.3             # => 1
  Rational(1, 3)  <=> nil             # => nil

--- coerce(other) -> Array

自身と other が同じクラスになるよう、自身か other を変換し [other, self] という
配列にして返します。

@param other 比較または変換するオブジェクト

예:

  Rational(1).coerce(2)   # => [Rational(2, 1), Rational(1, 1)]
  Rational(1).coerce(2.2) # => [2.2, 1.0]

#@since 1.8.7
--- floor -> Integer

自身と等しいかより小さな整数のうち最大のものを返します。

예:

  Rational(3).floor     # => 3
  Rational(2, 3).floor  # => 0
  Rational(-3, 2).floor # => -2

[[m:Rational#to_i]] とは違う結果を返す事に注意してください。

예:

  Rational(+7, 4).to_i  # => 1
  Rational(+7, 4).floor # => 1
  Rational(-7, 4).to_i  # => -1
  Rational(-7, 4).floor # => -2

@see [[m:Rational#ceil]], [[m:Rational#round]], [[m:Rational#truncate]]

--- ceil                -> Integer

自身と等しいかより大きな整数のうち最小のものを返します。

예:

  Rational(3).ceil      # => 3
  Rational(2, 3).ceil   # => 1
  Rational(-3, 2).ceil  # => -1

@see [[m:Rational#floor]], [[m:Rational#round]], [[m:Rational#truncate]]

--- round -> Integer

自身ともっとも近い整数を返します。

中央値 0.5, -0.5 はそれぞれ 1,-1 に切り上げされます。

예:

  Rational(3).round     # => 3
  Rational(2, 3).round  # => 1
  Rational(-3, 2).round # => -2

@see [[m:Rational#ceil]], [[m:Rational#floor]], [[m:Rational#truncate]]

--- truncate -> Integer
#@end
--- to_i -> Integer

小数点以下を切り捨てて値を整数に変換します。

예:

  Rational(2, 3).to_i   # => 0
  Rational(3).to_i      # => 3
  Rational(98, 71).to_i # => 1
  Rational(-30, 2).to_i # => -15

#@since 1.8.7
@see [[m:Rational#ceil]], [[m:Rational#floor]]
#@end

--- to_f -> Float

自身を [[c:Float]] に変換します。

@return 実数を返します。

예:

  Rational(9, 4).to_f   # => 2.25
  Rational(-3, 4).to_f  # => -0.75
  Rational(20, 3).to_f  # => 6.666666666666667

--- to_s -> String

自身を人間が読みやすい形の文字列表現にして返します。

"3/5", "-17/7" のように10進数の表記を返します。

@return 有理数の表記にした文字列を返します。

예:

  Rational(-3, 4).to_s # => "-3/4"
  Rational(8).to_s     # => "8"
  Rational(-8, 6).to_s # => "-4/3"

@see [[m:Rational#inspect]]

--- to_r -> Rational

自身を返します。

@return 自身を返します。

--- hash -> Integer

自身のハッシュ値を返します。

@return ハッシュ値を返します。

--- inspect -> String

自身を"Rational(分子, 分母)" 形式の文字列にして返します。

@return 文字列を返します。

예:

  Rational(5, 8).inspect  # => "Rational(5, 8)"
  Rational(2).inspect     # => "Rational(2, 1)"
  Rational(-8, 6).inspect # => "Rational(-4, 3)"

1.9 以降は結果が異なる事に注意してください。

  # 1.9.1の場合
  Rational(5, 8).inspect  # => "(5/8)"
  Rational(2).inspect     # => "(2/1)"
  Rational(-8, 6).inspect # => "(-4/3)"

@see [[m:Rational#to_s]]

#@since 1.9.1
--- -@ -> Rational

自身の符号を反転させたものを返します。

--- zero?-> bool

数値として 0 と等しい場合に真を返します。

예:

  Rational(0, 3).zero?# => true

@see [[m:Rational#nonzero?]]

--- nonzero?-> bool

数値として 0 と等しくない場合に真を返します。

@see [[m:Rational#zero?]]

#@end
#@end
