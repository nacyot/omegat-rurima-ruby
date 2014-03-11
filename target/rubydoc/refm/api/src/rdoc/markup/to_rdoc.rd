RDoc 形式のドキュメントをマークアップ記法を保持したまま出力させるための
サブライブラリです。

サブクラス([[c:RDoc::Markup::ToAnsi]] など)を作成して使います。

= class RDoc::Markup::ToRdoc < RDoc::Markup::Formatter

RDoc 形式のドキュメントをマークアップ記法を保持したまま出力させるための
クラスです。


== Class Methods

#@since 1.9.3
--- new(markup = nil) -> RDoc::Markup::ToRdoc
#@else
--- new -> RDoc::Markup::ToRdoc
#@end

객체를 초기화합니다.

#@since 1.9.3
@param markup [[c:RDoc::Markup]] 객체를 지정합니다.지정되지 않으면
              새로운 객체를 생성합니다.
#@end
