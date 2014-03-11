코멘트 텍스트를 처리하기 위한 서브 라이브러리입니다.

= module RDoc::Text

코멘트 텍스트를 처리하는 클래스입니다.


== Instance Methods

--- expand_tabs(text) -> String

text 인수에 있는 탭을 연속하는 8문자 공백문자로 바꿉니다.

@param text 문자열을 지정합니다.

--- flush_left(text) -> String

text 인수에서 각행의 맨 앞에 있는 공백문자를 삭제합니다.

@param text 문자열을 지정합니다.

--- markup(text) -> String

text 인수를 가공합니다.

include 한 클래스에 self#formatter 메소드가 필요합니다.

@param text 문자열을 지정합니다.

--- normalize_comment(text) -> String

text 인수에서 맨 앞에 있는 공백문자나 개행문자를 삭제합니다.

자세한 내용은 [SEE ALSO]의 각 메소드를 참조해주세요.

@param text 문자열을 지정합니다.

@see [[m:RDoc::Text#strip_hashes]], [[m:RDoc::Text#expand_tabs]],
     [[m:RDoc::Text#flush_left]], [[m:RDoc::Text#strip_newlines]]

--- parse(text) -> RDoc::Markup::Document | Array

text 인수에서 [[m:RDoc::Text#normalize_comment]]으로 공백문자와 개행문자를 삭제한 후 $$$

@param text 문자열을 지정합니다.

@see [[m:RDoc::Text#normalize_comment]]

--- strip_hashes(text) -> String

text 인수에서 각 행의 맨 앞에 있는 #를 삭제합니다.

@param text 문자열을 지정합니다.

--- strip_newlines(text) -> String

text 인수에서 맨앞과 맨 뒤에 있는 개행문자를 삭제합니다.

@param text 문자열을 지정합니다.

--- strip_stars(text) -> String

text 인수에서 /* ~ */ 형식의 코멘드를 삭제합니다.

@param text 문자열을 지정합니다.
