require e2mmap
require irb/slex
require rdoc/code_objects
#@# require rdoc/markup/simple_markup/preprocess
#@since 1.9.1
require rdoc/parser
#@else
require rdoc/parsers/parserfactory
#@end
#@since 1.9.3
require rdoc/token_stream
#@else
require rdoc/tokenstream
#@end

Ruby 소스코드를 분석하는 서브 라이브러리입니다.

확장자가 .rb, .rbw인 파일을 분석할 수 있습니다.

#@since 1.9.1
=== 메타프로그래밍으로 만들어지는 메소드

動的に定義されたメソッドをドキュメントに含めたい場合、## でコメントを開始します。

  ##
  # This is a meta-programmed method!

  add_my_method :meta_method, :arg1, :arg2

[[c:RDoc::Parser::Ruby]] は上記の :meta_method ようにメソッドの定義を行
うような識別子の後に続くトークンをメソッド名として解釈します。メソッド
名が見つからなかった場合、警告が表示されます。また、この場合はメソッド
名は 'unknown' になります。

:method: 命令を使う事でメソッド名を指定する事もできます。

  ##
  # :method: woo_hoo!

デフォルトでは動的に定義されたメソッドはインスタンスメソッドとして解析
されます。特異メソッドとしたい場合は、:singleton-method: 命令を指定しま
す。

  ##
  # :singleton-method:

以下のようにメソッド名を指定する事もできます。

  ##
  # :singleton-method: woo_hoo!

また、属性についても同様に :attr:、 :attr_reader:、 :attr_writer:、
:attr_accessor: を指定する事ができます。属性の名前は省略できます。

  ##
  # :attr_reader: my_attr_name

=== 隠しメソッド、属性

:method:、 :singleton-method: や :attr: 命令を使う事で実際には定義され
ていないメソッドもドキュメントに含める事ができます。

  ##
  # :attr_writer: ghost_writer
  # There is an attribute here, but you can't see it!

  ##
  # :method: ghost_method
  # There is a method here, but you can't see it!

  ##
  # this is a comment for a regular method

  def regular_method() end
#@end

#@since 1.9.1
= module RDoc::RubyToken
#@else
= module RubyToken
#@end

라이브러리 내부에서 사용합니다.

#@since 1.9.1
= class RDoc::RubyLex
#@else
= class RubyLex
#@end

라이브러리 내부에서 사용합니다.

#@until 1.9.1
= reopen RDoc

#@#== Constants

#@include(../RDoc__constants)
#@end

#@since 1.9.1
= class RDoc::Parser::Ruby < RDoc::Parser

include RDoc::RubyToken
include RDoc::TokenStream
#@since 1.9.2
include RDoc::Parser::RubyTools
#@end
#@else
= class RDoc::RubyParser

extend RDoc::ParserFactory

include RubyToken
include TokenStream
#@end

Ruby のソースコードを解析するためのクラスです。

#@since 1.9.1
== Constants

--- NORMAL -> "::"

RDoc::NormalClass type

--- SINGLE -> "<<"

RDoc::SingleClass type

#@end


== Class Methods

#@since 1.9.1
--- new(top_level, file_name, body, options, stats) -> RDoc::Parser::Ruby
#@else
--- new(top_level, file_name, body, options, stats) -> RDoc::RubyParser
#@end

객체를 초기화합니다.

@param top_level [[c:RDoc::TopLevel]] 객체를 지정합니다.

@param file_name 파일명을 나타내는 문자열을 지정합니다.

@param body 소스 코드를 문자열로 지정합니다.

#@since 1.9.1
@param options [[c:RDoc::Options]] 객체를 지정합니다.
#@else
@param options [[c:Options]] 객체를 지정합니다.
#@end

@param stats [[c:RDoc::Stats]] 객체를 지정합니다.


== Instance Methods

--- scan -> RDoc::TopLevel

Ruby のソースコードからクラス/モジュールのドキュメントを解析します。

@return [[c:RDoc::TopLevel]] 객체를 리턴합니다.
