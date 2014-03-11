#@# 1.9 버전대의 to_flow.rb에 대해서는 ../to_flow.rd를 참고해주세요.
#@# 分岐しても共有できるドキュメントが少なかったため、ファイルを分けました。

require cgi

RDoc 形式のドキュメントを表示する一段階前の構造化された状態にするための
サブライブラリです。

[[m:SM::SimpleMarkup#convert]] の引数に [[c:SM::ToFlow]] のインスタンス
を渡して使用します。

  require 'rdoc/ri/ri_formatter'
  require 'rdoc/ri/ri_options'
  require 'rdoc/markup/simple_markup'
  require 'rdoc/markup/simple_markup/to_flow'

  m = SM::SimpleMarkup.new
  h = SM::ToFlow.new
  flow = m.convert(input_string, h)
  options = RI::Options.instance
  formatter = options.formatter.new(options, "")
  formatter.display_flow(flow)

変換した結果は構造体の配列で取得できます。[[c:SM::ToHtml]] などとは異な
り [[m:SM::SimpleMarkup#convert]] が文字列を返さないため、上記のように
フォーマッタに変換した結果を渡す必要があります。

= class SM::ToFlow

RDoc 形式のドキュメントを表示する一段階前の構造化された状態にするための
クラスです。

[注意] 1.9 系では、require 先やクラス名が以下のように変更になりました。

 * require 先: rdoc/markup/to_flow
 * クラス名: RDoc::Markup::ToFlow


== Class Methods

--- new -> SM::ToFlow

객체를 초기화합니다.

実際に文字列を変換する際には、[[m:SM::SimpleMarkup#convert]] の引数に自
身を渡します。

@see [[m:SM::SimpleMarkup#convert]]


== Instance Methods

--- add_tag(name, start, stop) -> ()

name で登録された規則で取得された文字列を start と stop で囲むように指
定します。

@param name [[c:SM::ToFlow]] などのフォーマッタに識別させる時の名前を
            [[c:Symbol]] で指定します。

@param start tag의 시작을 나타내는 문자열을 지정합니다.

@param stop 태그의 끝을 나타내는 문자열 지정합니다.
