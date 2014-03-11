
irb コマンドで実行結果の出力方式(inspect_mode)を定義するためのサブライ
ブラリです。

= reopen IRB

== Singleton Methods

--- Inspector(inspect, init = nil) -> IRB::Inspector

[[c:IRB::Inspector]] オブジェクトを生成します。

@param inspect 実行結果の出力のための手続きオブジェクトを指定します。

@param init inspect_mode の初期化のための手続きオブジェクトを指定します。            あらかじめ require が必要な場合などに、proc { require "foo" }
            といった指定を行います。

= class IRB::Inspector

実行結果の出力を行うためのクラスです。


== Instance Methods

--- init -> ()

라이브러리 내부에서 사용됩니다.

--- inspect_value(v) -> ()

라이브러리 내부에서 사용됩니다.

= object IRB::INSPECTORS

定義された inspect_mode を管理する [[c:Hash]] オブジェクトです。

--- keys_with_inspector(inspector) -> Array

引数で指定した [[c:IRB::Inspector]] に対応する key の配列を返します。

@param inspector [[c:IRB::Inspector]] オブジェクトを指定します。

  IRB::INSPECTORS.keys_with_inspector(IRB::INSPECTORS[true])
  # => [true, :p, "p", :inspect, "inspect"]

--- def_inspector(key, arg = nil) { |v| ... } -> object

新しい実行結果の出力方式を定義します。

@param key conf.inspect_mode や IRB.conf[:INSPECT_MODE] に指定するキー
           オブジェクトを指定します。配列を指定した場合は配列中の要素全
           てが対象になります。

@param arg ブロックを指定する場合には、inspect_mode の初期化のための手続
           きオブジェクトを指定します。あらかじめ require が必要な場合
           などに、proc { require "foo" } といった指定を行います。           ブロックを指定しない場合には、実行結果の出力のための手続きオ
           ブジェクトを指定します。

例.

  # .irbrc
  IRB::INSPECTORS.def_inspector([:test]){|v| v.to_s * 2 }

  $ irb --inspect test
  irb(main):001:0> :abc # => abcabc

@see [[ref:lib:irb#inspect_mode]]
