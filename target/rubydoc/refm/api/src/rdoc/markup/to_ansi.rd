RDoc 形式のドキュメントを ANSI エスケープシーケンスで色付けするサブライ
ブラリです。

#@until 1.9.3
  require 'rdoc/markup/formatter'
#@end
  require 'rdoc/markup/to_ansi'

  h = RDoc::Markup::ToAnsi.new
  puts h.convert(input_string)

変換した結果は文字列で取得できます。

= class RDoc::Markup::ToAnsi < RDoc::Markup::ToRdoc

RDoc 形式のドキュメントを ANSI エスケープシーケンスで色付けするクラスで
す。


== Class Methods

#@since 1.9.3
--- new(markup = nil) -> RDoc::Markup::ToAnsi
#@else
--- new -> RDoc::Markup::ToAnsi
#@end

객체를 초기화합니다.

#@since 1.9.3
@param markup [[c:RDoc::Markup]] 객체를 지정합니다.지정되지 않으면
              새로운 객체를 생성합니다.
#@end
