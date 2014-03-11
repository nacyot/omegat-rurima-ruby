#@since 1.9.1
require rdoc/parser
#@else
#@# require rdoc/code_objects
#@# require rdoc/markup/simple_markup/preprocess
#@end

ソースコード以外のファイルを解析するためのサブライブラリです。

ファイルの内容すべてを 1 つの大きなコメントとして処理します。ただし、ファ
イルの先頭が # で始まっていた場合、先頭行は削除されます。

#@since 1.9.1
= class RDoc::Parser::Simple < RDoc::Parser
#@else
= class RDoc::SimpleParser
#@end

ソースコード以外のファイルを解析するためのクラスです。


== Class Methods

#@since 1.9.1
--- new(top_level, file_name, body, options, stats) -> RDoc::Parser::Simple
#@else
--- new(top_level, file_name, body, options, stats) -> RDoc::SimpleParser
#@end

객체를 초기화합니다.

@param top_level [[c:RDoc::TopLevel]] 객체를 지정합니다.

@param file_name 파일명을 나타내는 문자열을 지정합니다.

@param body 内容を文字列で指定します。

#@since 1.9.1
@param options [[c:RDoc::Options]] 객체를 지정합니다.
#@else
@param options [[c:Options]] 객체를 지정합니다.
#@end

@param stats [[c:RDoc::Stats]] 객체를 지정합니다.


== Instance Methods

--- scan -> RDoc::TopLevel

自身の持つ [[c:RDoc::TopLevel]] のコメントとしてファイルの内容を解析し
ます。

@return [[c:RDoc::TopLevel]] 객체를 리턴합니다.

--- remove_private_comments(comment) -> String

行頭の "--" から "++" で囲まれたコメントを comment から削除した結果を返
します。

@param comment 対象の文字列を指定します。

@return コメントが削除された文字列を返します。
