require rdoc/markup

RDoc 문서를 HTML로 만드는 서브 라이브러리입니다.

= class RDoc::Markup::Formatter

RDoc 문서를 HTML 문서로 만드는 기본 클래스입니다.

문서를 실제로 변환하기 위해선 [[c:RDoc::Markup::ToHtml]] 메소드를 
를 계승한 클래스에서 convert 메소드를 호출해주세요.


== Class Methods

#@since 1.9.3
--- new(markup = nil) -> RDoc::Markup::Formatter
#@else
--- new -> RDoc::Markup::Formatter
#@end

객체를 초기화합니다.

#@since 1.9.3
@param markup [[c:RDoc::Markup]] 객체를 지정합니다.지정되지 않으면
              새로운 객체를 생성합니다.
#@end


== Instance Methods

--- convert(content) -> ()

content에 지정된 문자열을 변환합니다.

@param content 변환하려는 문자열을 지정하빈다.

#@since 1.9.2
--- add_tag(name, start, stop) -> ()

name で登録された規則で取得された文字列を start と stop で囲むように指
定します。

@param name [[c:RDoc::Markup::ToHtml]] などのフォーマッタに識別させる時
            の名前を [[c:Symbol]] で指定します。

@param start tag의 시작을 나타내는 문자열을 지정합니다.

@param stop 태그의 끝을 나타내는 문자열 지정합니다.

예:

  require 'rdoc/markup/to_html'

  # :STRIKE のフォーマットを <strike> 〜 </strike> に指定。  h = RDoc::Markup::ToHtml.new
  h.add_tag(:STRIKE, "<strike>", "</strike>")

#@end
