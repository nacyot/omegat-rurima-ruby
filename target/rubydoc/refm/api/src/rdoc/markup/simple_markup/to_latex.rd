#@# 1.9 系の to_latex.rb については、../to_latex.rd をご覧ください。#@# 分岐しても共有できるドキュメントが少なかったため、ファイルを分けました。

require cgi

RDoc 形式のドキュメントを LaTeX に整形するためのサブライブラリです。

[[m:SM::SimpleMarkup#convert]] の引数に [[c:SM::ToLaTeX]] のインスタンス
を渡して使用します。

  require 'rdoc/markup/simple_markup'
  require 'rdoc/markup/simple_markup/to_latex'

  m = SM::SimpleMarkup.new
  h = SM::ToLaTeX.new
  puts m.convert(input_string, h)

変換した結果は文字列で取得できます。

= class SM::ToLaTeX

RDoc 形式のドキュメントを LaTeX 形式に整形するクラスです。

[注意] 1.9 系では、require 先やクラス名が以下のように変更になりました。

 * require 先: rdoc/markup/to_latex
 * クラス名: RDoc::Markup::ToLaTeX


== Class Methods

--- new -> SM::ToLaTeX

객체를 초기화합니다.

実際に文字列を変換する際には、[[m:SM::SimpleMarkup#convert]] の引数に自
身を渡します。

@see [[m:SM::SimpleMarkup#convert]]


== Instance Methods

--- add_tag(name, start, stop) -> ()

name で登録された規則で取得された文字列を start と stop で囲むように指
定します。

@param name [[c:SM::ToLaTeX]] などのフォーマッタに識別させる時の名前を
            [[c:Symbol]] で指定します。

@param start tag의 시작을 나타내는 문자열을 지정합니다.

@param stop 태그의 끝을 나타내는 문자열 지정합니다.
