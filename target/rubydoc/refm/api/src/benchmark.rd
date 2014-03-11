#@since 1.8.0
category Development

벤치마크 라이브러리입니다.

= module Benchmark

벤치마크 모듈입니다.

#@# == Class Methods
#@# 
#@# --- times -> Struct::Tms
#@# 
#@# [[m:Process.#times]] を呼び出しています。


== Module Functions

--- measure(label = "") { ... }  -> Benchmark::Tms

주어진 블록을 실행해서 경과한 시간을 [[m:Process.#times]]으로 측정해서
[[c:Benchmark::Tms]] 객체를 생성해 리턴합니다.

Benchmark::Tms 객체는 to_s 메소드가 정의되어있으므로 
아래와 같이 사용할 수 있습니다.

  require 'benchmark'
  
  puts Benchmark::CAPTION
  puts Benchmark.measure { "a"*1_000_000 }
  
  #=>
  
      user     system      total        real
  1.166667   0.050000   1.216667 (  0.571355)


--- realtime { ... } -> Float

주어진 블록을 평가해서 실행시간을 측정합니다.



--- bm(label_width = 0, *labels) {|rep| ... } -> bool

[[m:Benchmark.#benchmark]] 메소드에서 인수를 줄인 메소드입니다.

[[m:Benchmark.#benchmark]] 메소드와 내부 동작은 같습니다.

@param label_width 라벨의 폭을 지정합니다.
@param labels     블록이 [[c:Benchmark::Tms]] 객체 배열을 리턴할 때 지정합니다.

@return STDIN.sync의 값을 리턴하므로 리턴값에 큰 의미는 없습니다.

예:

  require 'benchmark'
  
  n = 50000
  Benchmark.bm do |x|
    x.report { for i in 1..n; a = "1"; end }
    x.report { n.times do   ; a = "1"; end }
    x.report { 1.upto(n) do ; a = "1"; end }
  end
  
  #=>
  
        user     system      total        real
    1.033333   0.016667   1.016667 (  0.492106)
    1.483333   0.000000   1.483333 (  0.694605)
    1.516667   0.000000   1.516667 (  0.711077)

아래와 같이 사용할 수 있습니다.

  require 'benchmark'
  
  n = 50000
  Benchmark.bm(7) do |x|
    x.report("for:")   { for i in 1..n; a = "1"; end }
    x.report("times:") { n.times do   ; a = "1"; end }
    x.report("upto:")  { 1.upto(n) do ; a = "1"; end }
  end
  
  #=>
               user     system      total        real
  for:     1.050000   0.000000   1.050000 (  0.503462)
  times:   1.533333   0.016667   1.550000 (  0.735473)
  upto:    1.500000   0.016667   1.516667 (  0.711239)

集計を付けた場合
  
  require 'benchmark'
  
  n = 50000
  Benchmark.bm(7) do |x|
    tf = x.report("for:")   { for i in 1..n; a = "1"; end }
    tt = x.report("times:") { n.times do   ; a = "1"; end }
    tu = x.report("upto:")  { 1.upto(n) do ; a = "1"; end }
    [tf + tt + tu, (tf + tt + tu) / 3]
  end
  
  #=>
               user     system      total        real
  for:     0.040000   0.000000   0.040000 (  0.141902)
  times:   0.010000   0.000000   0.010000 (  0.043335)
  upto:    0.020000   0.000000   0.020000 (  0.089806)
  >total:  0.070000   0.000000   0.070000 (  0.275044)
  >avg:    0.023333   0.000000   0.023333 (  0.091681)

@see [[m:Benchmark.#benchmark]]

--- bmbm(width = 0) {|job| ... } -> [Benchmark::Tms]

[[c:Benchmark::Job]] 객체를 생성해, 이 객체를 인수로 블록을 실행합니다.

벤치마크 결과는 GC 작동의 영향으로 왜곡될 수도 있습니다.
이 메소드에 주어진 블록을 2번 실행하는 방법으로 영향을 최소화합니다.
첫번째는 실행환경을 안정화하기 위한 예비 작업으로서 실행합니다.두번째는 실제 측정을 위해 실행합니다.

두번째 실행하기 전에 [[m:GC.start]]를 실행하지만 실행시간에는 포함되지 않습니다.하지만 이 메소드를 사용해도 GC 실행에 따른 영향이 분리되나는
보증은 없습니다.


@param width 라벨 폭을 지정합니다.

  require 'benchmark'
  
  array = (1..1000000).map { rand }
  
  Benchmark.bmbm do |x|
    x.report("sort!") { array.dup.sort!}
    x.report("sort")  { array.dup.sort  }
  end
  
  #=>
  
  Rehearsal -----------------------------------------
  sort!11.928000   0.010000  11.938000 ( 12.756000)
  sort   13.048000   0.020000  13.068000 ( 13.857000)
  ------------------------------- total: 25.006000sec
  
              user     system      total        real
  sort!12.959000   0.010000  12.969000 ( 13.793000)
  sort   12.007000   0.000000  12.007000 ( 12.791000)

--- benchmark(caption = "", label_width = nil, fmtstr = nil, *labels){|rep| ...} -> bool

[[c:Benchmark::Report]] 객체를 생성하고, 이 객체를 인수로 블록을 실행합니다.

아래와 같이 사용합니다.
ブロックが [[c:Benchmark::Tms]] オブジェクトの配列を返した場合は、
それらの数値も追加の行に表示されます。

@param caption     레포트 첫 행에 표시되는 문자열을 지정합니다.
@param label_width 라벨의 폭을 지정합니다.
@param fmtstr      포맷 문자열을 지정합니다.
#@since 1.9.3
                   이 인수를 지정하지 않으면 [[m:Benchmark::FORMAT]]가 사용됩니다.
#@else
                   이 인수를 지정하지 않으면 [[m:Benchmark::FMTSTR]]가 사용됩니다.
#@end
@param labels  블록이 [[c:Benchmark::Tms]] 객체의 배열을 리턴할 때 지정합니다.

@return STDIN.sync의 값을 리턴하므로 리턴값에 큰 의미는 없습니다.


===== 포맷 문자열

포맷 문자열로는 아래의 문자들을 사용할 수 있습니다.

: %u
  user CPU time으로 치환됩니다.[[m:Benchmark::Tms#utime]]
: %y
  system CPU time で置き換えられます(Mnemonic: y of "s*y*stem")。[[m:Benchmark::Tms#stime]]
: %U
  자식 프로세스의 user CPU time으로 치환됩니다.[[m:Benchmark::Tms#cutime]]
: %Y
  자식 프로세스의 system CPU time으로 치환됩니다.[[m:Benchmark::Tms#cstime]]
: %t
  total CPU time으로 치환됩니다.[[m:Benchmark::Tms#total]]
: %r
  실제 경과시간으로 치환됩니다.[[m:Benchmark::Tms#real]]
: %n
  라벨로 치환됩니다.(Mnemonic: n of "*n*ame")。[[m:Benchmark::Tms#label]]

===== 例

  require 'benchmark'
  
  n = 50000
  
  # 아래 예는
  #    Benchmark.bm(7, ">total:", ">avg:") do |x| ... end
  # 아래와 같습니다.
  Benchmark.benchmark(" "*7 + Benchmark::CAPTION,
                      7,
                      Benchmark::FMTSTR,
                      ">total:",
                      ">avg:") do |x|
    
    tf = x.report("for:")   { for i in 1..n; a = "1"; end }
    tt = x.report("times:") { n.times do   ; a = "1"; end }
    tu = x.report("upto:")  { 1.upto(n) do ; a = "1"; end }
    
    [tf+tt+tu, (tf+tt+tu)/3]
  end
  
  #=>
  
               user     system      total        real
  for:     1.016667   0.016667   1.033333 (  0.485749)
  times:   1.450000   0.016667   1.466667 (  0.681367)
  upto:    1.533333   0.000000   1.533333 (  0.722166)
  >total:  4.000000   0.033333   4.033333 (  1.889282)
  >avg:    1.333333   0.011111   1.344444 (  0.629761)

#@end


#@#== Constants

--- CAPTION -> String

[[m:Benchmark.#bm]] 내부에서 사용됩니다.

실제로는 [[m:Benchmark::Tms::CAPTION]]에 정의되어있습니다.

@see [[m:Benchmark::Tms::CAPTION]]

#@since 1.9.3
--- FORMAT -> String
#@else
--- FMTSTR -> String
#@end

[[m:Benchmark.#benchmark]] 메소드 세번째 인수의 기본설정값.

: %u
  user CPU time으로 치환됩니다.[[m:Benchmark::Tms#utime]]
: %y
  system CPU time で置き換えられます(Mnemonic: y of "s*y*stem")。[[m:Benchmark::Tms#stime]]
: %U
  자식 프로세스의 user CPU time으로 치환됩니다.[[m:Benchmark::Tms#cutime]]
: %Y
  자식 프로세스의 system CPU time으로 치환됩니다.[[m:Benchmark::Tms#cstime]]
: %t
  total CPU time으로 치환됩니다.[[m:Benchmark::Tms#total]]
: %r
  실제 경과시간으로 치환됩니다.[[m:Benchmark::Tms#real]]
: %n
  라벨로 치환됩니다.(Mnemonic: n of "*n*ame")。[[m:Benchmark::Tms#label]]

上記のフォーマット文字列を使用しています。이 상수의 내용은 아래와 같습니다.

  "%10.6u %10.6y %10.6t %10.6r\n"

#@since 1.9.3
@see [[m:Benchmark.#benchmark]], [[m:Benchmark::Tms::FORMAT]]
#@else
@see [[m:Benchmark.#benchmark]], [[m:Benchmark::Tms::FMTSTR]]
#@end

--- BENCHMARK_VERSION -> String

benchmark 라이브러리의 버전을 나타냅니다.


= class Benchmark::Tms < Object

벤치마크 측정에 관련된 여러가지 시간드을 표현하는 클래스입니다.


== Class Methods

--- new(utime = 0.0, stime = 0.0, cutime = 0.0, cstime = 0.0, real = 0.0, label = nil) -> Benchmark::Tms

[[c:Benchmark::Tms]] 객체를 생성합니다.

@param utime  User CPU time
@param stime  System CPU time
@param cutime 자식 프로세스 User CPU time
@param cstime 자식 프로세스 System CPU time
@param real   실제 경과시간
@param label  라벨



== Instance Methods

--- *(x) -> Benchmark::Tms

self와 x의 곱을 계산합니다.

@param x [[c:Benchmark::Tms]] 객체나 [[c:Float]]으로 암묵적인 변환이 가능한 객체를 지정합니다.

@return 계산 결과를 담은 새로운 [[c:Benchmark::Tms]] 객체를 리턴합니다.

@see [[m:Benchmark::Tms#memberwise]]

--- +(x) -> Benchmark::Tms

self와 x의 합을 계산합니다.

@param x [[c:Benchmark::Tms]] 객체나 [[c:Float]]으로 암묵적인 변환이 가능한 객체를 지정합니다.

@return 계산 결과를 담은 새로운 [[c:Benchmark::Tms]] 객체를 리턴합니다.

@see [[m:Benchmark::Tms#memberwise]]

--- -(x) -> Benchmark::Tms

self와 x의 차를 계산합니다.

@param x [[c:Benchmark::Tms]] 객체나 [[c:Float]]으로 암묵적인 변환이 가능한 객체를 지정합니다.

@return 계산 결과를 담은 새로운 [[c:Benchmark::Tms]] 객체를 리턴합니다.

@see [[m:Benchmark::Tms#memberwise]]

--- /(x) -> Benchmark::Tms

self를 x로 나눈 값을 계산합니다.

@param x [[c:Benchmark::Tms]] 객체나 [[c:Float]]으로 암묵적인 변환이 가능한 객체를 지정합니다.

@return 계산 결과를 담은 새로운 [[c:Benchmark::Tms]] 객체를 리턴합니다.

@see [[m:Benchmark::Tms#memberwise]]

--- add { ... } -> Benchmark::Tms

넘겨받은 블록의 실행시간을 self에 대해서 새로운
[[c:Benchmark::Tms]] 객체를 만들어 리턴합니다.

@see [[m:Benchmark.#measure]]

--- add!{ ... } -> self

넘겨받은 블록의 실행시간을 self에 더해서 리턴합니다.

이 메소드는 self를 파괴적으로 변경합니다.

@see [[m:Benchmark.#measure]]


--- format(fmtstr = nil, *args) -> String

self를 지정한 포맷으로 변환해 리턴합니다.

이 메소드는 [[m:Kernel.#format]]와 같이 객체를 포맷 문자열의 규칙에 따라 변환합니다.
추가로 아래 문자들을 사용할 수 있습니다.

: %u
  user CPU time으로 치환됩니다.[[m:Benchmark::Tms#utime]]
: %y
  system CPU time で置き換えられます(Mnemonic: y of "s*y*stem")。[[m:Benchmark::Tms#stime]]
: %U
  자식 프로세스의 user CPU time으로 치환됩니다.[[m:Benchmark::Tms#cutime]]
: %Y
  자식 프로세스의 system CPU time으로 치환됩니다.[[m:Benchmark::Tms#cstime]]
: %t
  total CPU time으로 치환됩니다.[[m:Benchmark::Tms#total]]
: %r
  실제 경과시간으로 치환됩니다.[[m:Benchmark::Tms#real]]
: %n
  라벨로 치환됩니다.(Mnemonic: n of "*n*ame")。[[m:Benchmark::Tms#label]]

@param fmtstr 포멧 문자열을 지정합니다.
#@since 1.9.3
              이 인수를 지정하지 않으면 [[m:Benchmark::FORMAT]]가 사용됩니다.
#@else
              이 인수를 지정하지 않으면 [[m:Benchmark::FORMAT]]가 사용됩니다.
#@end
@param args  주어진 포맷 문자열에 따라 변환될 인수입니다.

--- to_a -> Array

6개의 요소를 배열로 만들어 리턴합니다.

배열은 아래의 순서에 따라 요소들을 포함하고 있습니다.
  * 라벨
  * user CPU time
  * system CPU time,
  * 자식 프로세스의 user CPU time
  * 자식 프로세스의 system CPU time,
  * 실제 경과시간

--- to_s -> String

인수를 생략하면  [[m:Benchmark::Tms#format]] 메소드를 호출하는 것과 같습니다.


--- utime -> Float

User CPU time

--- stime -> Float

System CPU time

--- cutime -> Float

자식 프로세스의 User CPU time

--- cstime -> Float

자식 프로세스의 System CPU time

--- real -> Float

실제 경과시간

--- total -> Float

시간 합계(utime + stime + cutime + cstime)

--- label -> String

라벨.


== Protected Instance Methods

--- memberwise(op, x) -> Benchmark::Tms

[[c:Benchmark::Tms]]객체의 사칙 연산을 가능하게 하기 위해 내부에서 사용되는 메소드입니다.

@param op 연산자를 심볼로 지정합니다.
@param x [[c:Benchmark::Tms]] 객체나 [[c:Float]]으로 암묵적인 변환이 가능한 객체를 지정합니다.

@return 계산 결과를 담은 새로운 [[c:Benchmark::Tms]] 객체를 리턴합니다.


#@#== Constants

--- CAPTION -> String

[[m:Benchmark.#bm]] 내부에서 사용됩니다.

@see [[m:Benchmark::CAPTION]]

#@since 1.9.3
--- FORMAT -> String
#@else
--- FMTSTR -> String
#@end

[[m:Benchmark.#benchmark]] 메소드 세번째 인수의 기본설정값.

: %u
  user CPU time으로 치환됩니다.[[m:Benchmark::Tms#utime]]
: %y
  system CPU time で置き換えられます(Mnemonic: y of "s*y*stem")。[[m:Benchmark::Tms#stime]]
: %U
  자식 프로세스의 user CPU time으로 치환됩니다.[[m:Benchmark::Tms#cutime]]
: %Y
  자식 프로세스의 system CPU time으로 치환됩니다.[[m:Benchmark::Tms#cstime]]
: %t
  total CPU time으로 치환됩니다.[[m:Benchmark::Tms#total]]
: %r
  실제 경과시간으로 치환됩니다.[[m:Benchmark::Tms#real]]
: %n
  라벨로 치환됩니다.(Mnemonic: n of "*n*ame")。[[m:Benchmark::Tms#label]]

上記のフォーマット文字列を使用しています。이 상수의 내용은 아래와 같습니다.

  "%10.6u %10.6y %10.6t %10.6r\n"

#@since 1.9.3
@see [[m:Benchmark.#benchmark]], [[m:Benchmark::FORMAT]]
#@else
@see [[m:Benchmark.#benchmark]], [[m:Benchmark::FMTSTR]]
#@end


= class Benchmark::Job < Object

[[m:Benchmark.#bmbm]] 메소드 내부에서 사용되는 클래스입니다.

사용자가 직접 이 라이브러리를 사용할 일은 없습니다.


== Class Methods

--- new(width) -> Benchmark::Job

[[c:Benchmark::Job]] 객체를 생성합니다.

일반적으로 사용자가 직접 이 메소드를 호출할 일은 없습니다.

@param width [[m:Benchmark::Job#list]]의 사이즈


== Instance Methods

--- item(label = ""){ ... } -> self
--- report(label = ""){ ... } -> self

주어진 라벨과 블록을 잡 리스트에 등록합니다.

@param label 라벨

--- list -> [String, Proc]

등록된 잡 리스트를 리턴합니다.

각각의 요소는 라벨과 블록 두 요소로 이루어진 배열입니다.

--- width -> Integer

[[m:Benchmark::Job#list]]의 사이즈를 리턴합니다.


= class Benchmark::Report < Object

[[m:Benchmark.#benchmark]] 메소드나 [[m:Benchmark.#bm]] 메소드 내부에서
사용되는 클래스입니다.

사용자가 직접 이 라이브러리를 사용할 일은 없습니다.


== Class Methods

--- new(width = 0, fmtstr = nil) -> Benchmark::Report

[[c:Benchmark::Report]] 객체를 생성합니다.

일반적으로 사용자가 직접 이 메소드를 호출할 일은 없습니다.

@param width  라벨의 넓이
@param fmtstr 포맷 문자열


== Instance Methods

--- item(label = "", *fmt){ ... } -> Benchmark::Tms
--- report(label = "", *fmt){ ... } -> Benchmark::Tms

라벨과 주어진 블록의 실행시간을 표준출력으로 출력합니다.

출력의 포맷은 [[m:Benchmark::Tms#format]] 메소드를 따릅니다.

@param label 라벨
@param fmt   결과를 출력하고 싶은 객체

@see [[m:Benchmark::Tms#format]]

#@since 1.9.3
--- list -> [Benchmark::Tms]

[[m:Benchmark::Report#item]] 실행 중에 생성된 [[c:Benchmark::Tms]] 객체
목록을 리턴합니다.

@see [[m:Benchmark::Report#item]]
#@end
