#@since 1.9.1
require rdoc/parser
require rdoc/parser/ruby
require rdoc/known_classes
#@else
require rdoc/code_objects
require rdoc/parsers/parserfactory
require rdoc/options
require rdoc/rdoc
#@end

C 언어 소스 코드에서 내장 클래스와 모듈의 문서를
분석하는 서브 라이브러리입니다.

C언어로 쓰여진 확장 라이브러를 분석하는 용도로 쓰입니다.
[[f:rb_define_class]]나 [[f:rb_define_method]] 등에 정의된 것들에@@@
대응되는 C 언어의 함수나 주석을 분석합니다.

예: Array#flattenrb_ary_flatten의 주석을 분석합니다.

  /*
   * Returns a new array that is a one-dimensional flattening of this
   * array (recursively). That is, for every element that is an array,
   * extract its elements into the new array.
   *
   *    s = [ 1, 2, 3 ]           #=> [1, 2, 3]
   *    t = [ 4, 5, 6, [7, 8] ]   #=> [4, 5, 6, [7, 8]]
   *    a = [ s, t, 9, 10 ]       #=> [[1, 2, 3], [4, 5, 6, [7, 8]], 9, 10]
   *    a.flatten                 #=> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
   */
   static VALUE
   rb_ary_flatten(ary)
       VALUE ary;
   {
       ary = rb_obj_dup(ary);
       rb_ary_flatten_bang(ary);
       return ary;
   }
   
   ...
   
   void
   Init_Array()
   {
     ...
     rb_define_method(rb_cArray, "flatten", rb_ary_flatten, 0);

위의 예에서 rb_ary_flatten 함수와 Init_Array 함수는 같은 파일에
있어야 합니다.

또한 Ruyb 소스코드와는 별개로 주석에 몇가지 명령을 사용할 수 있습니다.

: Document-class: name

  내용을 name에 지정한 Ruby 클래스에 포함시킵니다.예를 들어 같은
  .c 파일에 여러개의 클래스가 지정할 필요가 있을 때와 같이 Init_xxx 함수의
  xxx 부분이 클래스명과 같지 않을 때 사용합니다.

: Document-method: name

  내용을 name에 지정한 Ruby 메소드에 포함시킵니다.
  RDoc이 자동적으로 대응되는 메소드를 찾지 못할 때 사용합니다.

: call-seq:

  이 명령이 사용된 다음행부터 빈 행이 나올 때까지를 메소드 호출 예로 처리합니다.

또한 RDoc에선 rb_define_method의 정의와 C 언어의 함수 구현이 같은 파일에 있어야합니다.그렇지 않으면 @@@

  rb_define_method(....);  // in 파일명

예:

  /*
   * Document-class:  MyClass
   *
   * Encapsulate the writing and reading of the configuration
   * file. ...
   */
  
  /*
   * Document-method: read_value
   *
   * call-seq:
   *   cfg.read_value(key)            -> value
   *   cfg.read_value(key} { |key| }  -> value
   *
   * Return the value corresponding to +key+ from the configuration.
   * In the second form, if the key isn't found, invoke the
   * block and return its value.
   */

#@since 1.9.1
= class RDoc::Parser::C < RDoc::Parser
#@else
#@include(../RDoc__KNOWN_CLASSES)

= class RDoc::C_Parser

extend RDoc::ParserFactory
#@end

C 言語で記述されたソースコードから組み込みクラス/モジュールのドキュメン
トを解析するためのクラスです。


== Class Methods

#@since 1.9.1
--- new(top_level, file_name, body, options, stats) -> RDoc::Parser::C
#@else
--- new(top_level, file_name, body, options, stats) -> RDoc::C_Parser
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

--- progress=(val)

진행상황을 출력할 [[c:IO]] 객체를 지정합니다.

@param val 진행상황을 출력할 [[c:IO]]를 지정합니다.지정하지 않으면
           [[m:$stderr]]을 사용합니다.

--- scan -> RDoc::TopLevel

C 언어 소스 코드에서 내장 클래스와 모듈의 문서를
분석합니다.

@return [[c:RDoc::TopLevel]] 객체를 리턴합니다.
