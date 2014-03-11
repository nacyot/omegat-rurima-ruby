HTML에 관련된 유틸리티 함수를 제공합니다.

= module WEBrick::HTMLUtils

HTML에 관련된 유틸리티 함수를 제공합니다.

== Module Functions

--- escape(string)    -> String

指定された文字列に含まれる ", &, <, > を文字実体参照に変換した文字列を
生成して返します。

@param string エスケープしたい文字列を指定します。

  p WEBrick::HTMLUtils.escape('/?q=foo&hl=<ja>')    #=> "/?q=foo&amp;hl=&lt;ja&gt;"
