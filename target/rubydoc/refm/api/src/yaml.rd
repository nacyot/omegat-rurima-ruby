category FileFormat

#@since 1.8.0

#@until 1.9.2
require stringio
require yaml/error
require yaml/tag
require yaml/stream
require yaml/constants

#@# yaml/encoding は内部でしか使用しないため省略。#@end

構造化されたデータを表現するフォーマットであるYAML (YAML Ain't Markup Language) を扱うためのライブラリです。

例1: 構造化された配列
  require 'yaml'

  data = [ "Taro san", "Jiro san", "Saburo san"]
  str_r = YAML.dump(data)

  str_l =<<EOT
  --- 
  - Taro san
  - Jiro san
  - Saburo san
  EOT

  p str_r == str_l #=> true

例2: 構造化されたハッシュ

  require 'yaml'
  require 'date'

  str_l =<<YAML_EOT
  Tanaka Taro: { age: 35, birthday: 1970-01-01}
  Suzuki Suneo: {
    age: 13,
    birthday: 1992-12-21
  }
  YAML_EOT

  str_r = {}
  str_r["Tanaka Taro"] = {
    "age" => 35,
    "birthday" => Date.new(1970, 1, 1)
  }
  str_r["Suzuki Suneo"] = {
    "age" => 13,
    "birthday" => Date.new(1992, 12, 21)
  }

  p str_r == YAML.load(str_l) #=> true

例3: 構造化されたログ

  require 'yaml'
  require 'stringio'

  strio_r = StringIO.new(<<EOT
  ---
  time: 2008-02-25 17:03:12 +09:00
  target: YAML
  version: 4
  log: | 
    例を加えた。    アブストラクトを修正した。  ---
  time: 2008-02-24 17:00:35 +09:00
  target: YAML
  version: 3
  log: | 
    アブストラクトを書いた。 

  EOT
  )

  YAML.load_stream(strio_r).documents.sort{|a, b| a["version"] <=> b["version"]}.each{|obj|
    printf "version %d\ntime %s\ntarget:%s\n%s\n", obj["version"], obj["time"], obj["target"], obj["log"]
  }

=== バックエンドの選択

[[lib:yaml]] ライブラリでは、以下のライブラリをバックエンドとして使用します。

#@until 2.0.0
 * [[lib:syck]] ライブラリ: YAML バージョン 1.0 を扱う事ができます。#@end
#@since 1.9.2
 * [[lib:psych]] ライブラリ: YAML バージョン 1.1 を扱う事ができます。

#@until 2.0.0
require "yaml" した場合、特に何もしなければ
#@since 1.9.3
[[lib:psych]] ライブラリを使用します。#@else
[[lib:syck]] ライブラリを使用します。#@end

デフォルト以外のバックエンドを使用したい場合、[[lib:yaml]] ライブラリを
require する前に [[lib:psych]] か [[lib:syck]] を require してください。

例1: [[lib:psych]] を使用する場合

  require "psych"
  require "yaml"
  YAML.load(...)

例2: [[lib:syck]] を使用する場合

  require "syck"
  require "yaml"
  YAML.load(...)

また、[[lib:yaml]] を require した後でも、YAML::ENGINE.yamler に
"psych" を代入する事で [[lib:psych]] を使用できます。([[lib:syck]] の場
合も同様です)

  require "yaml"
  require "psych"
  YAML::ENGINE.yamler = "psych"
  YAML.load(...)

#@end
#@end

=== タグの指定

!ruby/sym :foo などのようにタグを指定することで、読み込み時に記述した値
の型を指定できます。

예:

  require 'yaml'
  p YAML.load(<<EOS)
  ---
  !ruby/sym :foo
  EOS
  # => :foo

[[lib:yaml]] では、Ruby 向けに以下のローカルタグを扱えます。

 * !ruby/array: [[c:Array]] 객체
 * !ruby/class: [[c:Class]] 객체
 * !ruby/hash:  [[c:Hash]] 객체
 * !ruby/module:  [[c:Module]] 객체
 * !ruby/regexp:  [[c:Regexp]] 객체
 * !ruby/range: [[c:Range]] 객체
 * !ruby/string: [[c:String]] 객체
 * !ruby/struct: [[c:Struct]] 객체
 * !ruby/sym(もしくは !ruby/symbol): [[c:Symbol]] 객체
 * !ruby/exception: 예외 객체
 * !ruby/object:<클래스 이름>: 위에 열거한 것들 이외의 객체

예:

  require 'yaml'
  p YAML.load(<<EOS)
  ---
  array: !ruby/array [1, 2, 3]
  hash: !ruby/hash {foo: 1, bar: 2}
  regexp: !ruby/regexp /foo|bar/
  range: !ruby/range 1..10
  EOS
  # => {"regexp"=>/foo|bar/, "hash"=>{"foo"=>1, "bar"=>2}, "array"=>[1, 2, 3], "range"=>1..10}

これらは tag:ruby.yaml.org,2002:array のように指定する事もできます。

예:

  require 'yaml'
  p YAML.load(<<EOS)
  ---
  array: !tag:ruby.yaml.org,2002:array [1, 2, 3]
  hash: !tag:ruby.yaml.org,2002:hash {foo: 1, bar: 2}
  EOS
  # => {"hash"=>{"foo"=>1, "bar"=>2}, "array"=>[1, 2, 3]}

自分で定義したクラスなどは !ruby/object:<クラス名> を指定します。なお、
読み込む場合には既にそのクラスが定義済みでないと読み込めません。

また、キーと値を指定する事でインスタンス変数を代入できます。

예1:

  require 'yaml'
  
  class Foo
    def initialize
      @bar = "test"
    end
  end
  
  p YAML.load(<<EOS)
  ---
  !ruby/object:Foo
  bar: "test.modified"
  EOS
  # => #<Foo:0xf743f754 @bar="test.modified">

예2:

  require 'yaml'
  
  module Foo
    class Bar
    end
  end
  
  p YAML.load(<<EOS)
  ---
  !ruby/object:Foo::Bar
  EOS
  # => #<Foo::Bar:0xf73907b8>

#@until 2.0.0
また、YAML 形式に変換する際のタグを変更したい場合、to_yaml_type メソッ
ドをオーバライドしてください。
#@since 1.9.2
([[lib:syck]] のみ)
#@end

예:

#@since 1.9.3
  require "syck"
#@end
  require "yaml"
  class Foo
    def to_yaml_type
      return "!tag:example.com,2002:foo"
    end
  end
  p Foo.new.to_yaml # => "--- !example.com,2002/foo {}\n\n"
#@end

=== 주의

無名クラスを YAML 形式に変換すると [[c:TypeError]] が発生します。また、
[[c:IO]] や [[c:Thread]] オブジェクトなどはインスタンス変数がオブジェク
トの状態を保持していないため、変換はできますが、YAML.load した時に完全
に復元できない事に注意してください。

標準添付の yaml 関連ライブラリには以下のようなRuby 独自の拡張、制限があ
ります。標準添付ライブラリ以外で yaml を扱うライブラリを使用する場合な
どに注意してください。

 * ":foo" のような文字列はそのまま [[c:Symbol]] として扱える
 * "y" や "n" は真偽値として扱われない
#@until 2.0.0
 * !!str のような短縮系のグローバルタグは扱われない
#@since 1.9.2
   ([[lib:syck]] のみ)
#@end
#@end
 * !<tag:yaml.org,2002:str> "foo" のようにタグを扱えない。   !tag:yaml.org,2002:str "foo" のように記述する必要がある

#@# 最後のものは当初からの不具合だと思われます。psych ライブラリなどで
#@# 対応される事があれば、分岐を追加する必要があります。
#@# また、!str "foo" のようなローカルタグを元に型を指定する方法について
#@# は触れない方が適切と考え、記述していません。

=== 참고

YAML Specification

 * [[url:http://www.yaml.org/spec/]]
 * [[url:http://www.yaml.org/type/]]

YAML4R

 * [[url:http://yaml4r.sourceforge.net/]]
 * [[url:http://yaml4r.sourceforge.net/cookbook/]]([[url:http://yaml.org/YAML_for_ruby.html]])
 * [[url:http://yaml4r.sourceforge.net/doc/]]

Rubyist Magazine: [[url:http://jp.rubyist.net/magazine/]]

 * 프로그래머를 위한 YAML 입문 (초급편): [[url:http://jp.rubyist.net/magazine/?0010-YAML]]
 * 프로그래머를 위한 YAML 입문 (중급편): [[url:http://jp.rubyist.net/magazine/?0010-YAML]]
 * 프로그래머를 위한 YAML 입문 (실천편): [[url:http://jp.rubyist.net/magazine/?0010-YAML]]
 * 프로그래머를 위한 YAML 입문 (검증편): [[url:http://jp.rubyist.net/magazine/?0010-YAML]]
 * 프로그래머를 위한 YAML 입문 (탐색편): [[url:http://jp.rubyist.net/magazine/?0010-YAML]]

기타

 * Ruby with YAML: [[url:http://www.namikilab.tuat.ac.jp/~sasada/prog/yaml.html]]

= module YAML

YAML (YAML Ain't Markup Language)을 다루는 모듈입니다.

#@since 1.9.2
#@since 2.0.0
YAML オブジェクトは実際は [[c:Psych]] オブジェクトです。その他のオブジェ
クトも同様に実体は別のオブジェクトです。もし確認したいメソッドの記述が
見つからない場合は、[[lib:psych]] ライブラリを確認してください。

  require "yaml"

  p YAML::ENGINE.yamler # => "psych"
  p YAML                # => Psych
  p YAML::Stream        # => Psych::Stream
#@else
YAML オブジェクトは実際は [[c:Psych]] オブジェクト、[[c:Syck]] オブジェ
クトのどちらかです。その他のオブジェクトも同様に実体は別のオブジェクト
です。もし確認したいメソッドの記述が見つからない場合は、それぞれのライ
ブラリを確認してください。

  require "psych"
  require "syck"
  require "yaml"

  YAML::ENGINE.yamler = "psych"
  p YAML         # => Psych
  p YAML::Stream # => Psych::Stream

  YAML::ENGINE.yamler = "syck"
  p YAML         # => Syck
  p YAML::Stream # => Syck::Stream
#@end

#@#== Constants

--- ENGINE -> YAML::EngineManager

[[c:YAML::EngineManager]] を返します。

@see [[m:YAML::EngineManager#yamler]], [[m:YAML::EngineManager#yamler=]]

= class YAML::EngineManager

[[lib:yaml]] のバックエンドを管理するクラスです。


== Class Methods

--- new -> YAML::EngineManager

객체를 초기화합니다.


== Instance Methods

--- yamler -> String

사용중인 처리엔진을 문자열로 리턴합니다.

예:

#@until 2.0.0
  require "psych"
#@end
  require "yaml"
  p YAML::ENGINE.yamler # => "psych"

--- yamler=(engine)

#@since 2.0.0
사용되지 않습니다.
#@else
사용할 처리엔진을 지정합니다.

また、engine がまだ require されていなかった場合は require します。#@end

@param engine バックエンドを文字列で指定します。

@raise ArgumentError 未対応のバックエンドを指定した場合に発生します。

#@until 2.0.0
예

  require "psych"
  require "yaml"
  p YAML # => Psych

  YAML::ENGINE.yamler = "syck"
  p YAML # => Syck
#@end

--- syck?-> bool

#@since 2.0.0
항상 false를 리턴합니다.
#@else
[[lib:syck]] 라이브러리를 사용하고 있으면 true를 리턴합니다.그렇지 않으면 false를 리턴합니다.

  require "psych"
  require "yaml"
  p YAML::ENGINE.syck?# => false

  YAML::ENGINE.yamler = "syck"
  p YAML::ENGINE.syck?# => true
#@end

#@else
#@include(yaml/YAML.inside)
#@include(yaml/Kernel)
#@end
#@end
