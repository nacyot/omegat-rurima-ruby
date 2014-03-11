category Thread

スレッド同期機構である Mutex のモジュール版を提供するライブラリです。

= module Mutex_m

スレッド同期機構である [[c:Mutex]] のモジュール版です。クラスに
[[m:Module#include]] することでそのクラスに Mutex 機能を持たせることができます。
また、普通のオブジェクトを [[m:Object#extend]] により Mutex にする事ができます。

このモジュールによるロックは再入不可能です。再入可能な同等品が必要な場合は
[[c:Sync_m]] の利用を考えてください。

「mu_」の付かないメソッド([[m:Mutex_m#lock]], [[m:Mutex_m#synchronize]], 
[[m:Mutex_m#locked?]], [[m:Mutex_m#try_lock]], [[m:Mutex_m#unlock]])
はモジュールにincludeした場合には定義されません。

[[ruby-list:1991]]

===예
클래스에 [[m:Module#include]]하는 예
  class Foo
    include Mutex_m
    ...
  end
  obj = Foo.new
  obj.synchronize do 
    # 위험 영역(critical section)
    ...
  end

객체에 [[m:Object#extend]]하는 예
  require "mutex_m"
  obj = Object.new
  obj.extend(Mutex_m)
  obj.lock
  # 위험 영역(critical section)  
  ... 
  obj.unlock

== Singleton Methods

--- append_features(klass) -> Class | nil

직접 호출할 일은 없는 메소드입니다.

@see [[m:Module#append_features]]

--- define_aliases(klass) -> Class

직접 호출할 일은 없는 메소드입니다.

--- extend_object(module) -> Module

직접 호출할 일은 없는 메소드입니다.

@see [[m:Module#extend_object]]


== Instance Methods

--- mu_extended -> Mutex

[[m:Mutex_m.extend_object]]에서 호출됩니다.
직접 호출할 일은 없는 메소드입니다.

--- mu_synchronize{ ... } -> object
--- synchronize{ ... } -> object

self のロックを取得し、ブロックを実行します。実行後に必ずロックを解放します。

ブロックで最後に評価した値を返します。

#@until 1.9.1
--- mu_lock -> self
--- lock -> self
#@else
--- mu_lock -> ()
--- lock -> ()
#@end
self를 잠급니다.一度にひとつのスレッドしかロックできません。既にロックされている mutex に対してロックを行おうとしたスレッドは
ロックが解放されるまで、実行が停止されます。

#@until 1.9.1
self를 리턴합니다.
#@end

--- mu_locked?-> bool
--- locked?-> bool
셀프가 잠겨있으면 true를 리턴합니다.

--- mu_try_lock -> bool
--- try_lock -> bool
self をロックしようとして、成功した場合、真を返し、ロックを得ます。

ロックできなかった場合にはブロックせず偽を返します。

#@until 1.9.1
--- mu_unlock -> self | nil
--- unlock -> self | nil
#@else
--- mu_unlock -> ()
--- unlock -> ()
#@end
잠금을 해제합니다.ロック待ちになっていたスレッドの実行は再開されます。

#@until 1.9.1
self がロックされていなければ nil を返します。そうでなければself を返します。#@else
@raise ThreadError 잠겨있지 않은 상태에서 unlock을 호출하면 발생합니다.
#@end

