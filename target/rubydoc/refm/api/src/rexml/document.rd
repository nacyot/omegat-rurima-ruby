= class REXML::Document < REXML::Element

완전한 XML 문서(도큐멘트)를 나타내는 클래스.

XML 처리명령(Processing Instruction, PI),
DTD(문서 형식 정의, Document Type Definition),
를 포함하고 있습니다.
XML 문서는 바로 아래에 root 자식 노드 단 하나만을 가지고 있습니다. 이 노드는 [[m:REXML::Document#root]]를 통해 접근할 수 있습니다. [[m:REXML::Element#add_element]]를 호출하는 등 다른 요소를 추가하려고 하면 ([[c:RuntimeError]]) 예외가 발생합니다.


== Class Methods

--- new(source = nil, context = {}) -> REXML::Document
Document 객체를 생성합니다.

source 에는 [[c:String]], [[c:IO]], [[c:REXML::Document]] 객체 중 하나를 지정합니다. REXML::Document を指定すると
コンテキストと要素、属性が複製されます。文字列の場合はそれを XML と見なしてパースします。IOの場合は、XML文書を読み出してパースします。

context で「コンテキスト」を指定します。テキストノードの空白や
特殊文字の取り扱いを [[c:Hash]] で指定します。#@include(context)

@param source XML文書(文字列, IO)もしくは REXML::Document オブジェクト
@param context コンテキスト

--- parse_stream(source, listener)
#@todo


== Instance Methods

--- node_type -> Symbol
심볼 :document 을 리턴합니다.

self를 복사합니다.

[[m:REXML::Document.new]](self) 와 같습니다.

--- expanded_name -> String
--- name -> String

""(빈 문자열)를 리턴합니다.

XMLの仕様上、このオブジェクトはexpanded name名前を持ちえません。

--- add(child) -> ()
--- <<(child) -> ()
자식 노드를 추가합니다.

추가할 수 있는 것들은
  * XML 선언([[c:REXML::XMLDecl]])
  * DTD([[c:REXML::DocType]])
  * root 요소
중 하나입니다.

#@# REXML::Element#add_element 와 같습니다만 root가 2개 생성될 경우 예외가 발생합니다.
#@# 
#@# --- add_element(arg = nil, arg2 = nil)
#@# #@todo
#@#
 

--- root -> REXML::Element | nil
root 요소를 리턴합니다.

문서에 root 요소가 없으면 nil을 리턴합니다.

--- doctype -> REXML::DocType | nil
문서의 DTD를 리턴합니다.

문서에 DTD가 없는 없으면 nil을 리턴합니다.

--- xml_decl -> REXML::XMLDecl | nil
문서의 XML 선언을 리턴합니다.

문서에 XML 선언이 없으면 nil을 리턴합니다.

--- version -> String
XML 선언에 포함된 XML 문서 버전을 리턴합니다.

문서에 XML 선언이 없으면 기본설정값인 
[[m:REXML::XMLDecl.default]]의 값을 리턴합니다.

==== 예
  require 'rexml/document'
  doc = REXML::Document.new(<<EOS)
  <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
  <e />
  EOS
  doc.version # => "1.0"

--- encoding -> String
XML 선언에 포함된 XML 문서 인코딩을 리턴합니다.

문서에 XML 선언이 없으면 기본설정값인 
[[m:REXML::XMLDecl.default]]의 값을 리턴합니다.

==== 예
  require 'rexml/document'
  doc = REXML::Document.new(<<EOS)
  <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
  <e />
  EOS
  doc.encoding # => "UTF-8"

--- stand_alone?-> String
XML 선언의 standalone 값을 문자열로 리턴합니다.

==== 예
  require 'rexml/document'
  doc = REXML::Document.new(<<EOS)
  <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
  <e />
  EOS
  doc.stand_alone?# => "yes"

#@until 2.0.0
--- write(output = $stdout, indent = -1, transitive = false, ie_hack = false) -> ()
#@else
--- write(output = $stdout, indent = -1, transitive = false, ie_hack = false, encoding=nil) -> ()
--- write(output: $stdout, indent: -1, transitive: false, ie_hack: false, encoding: nil) -> ()
#@end

output에 XML 문서를 출력합니다.

XML宣言、DTD、処理命令を(もしあるならば)含む文書を出力します。

注意すべき点として、
元の XML 文書が XML宣言を含んでいなくとも
出力される XML はデフォルトの XML 宣言を含んでいるべきであるが、
REXML は明示しない限り(つまりXML宣言を [[m:REXML::Document#add]] で
追加しない限り)
それをしない、ということである。XML-RPCのような利用法では
ネットワークバンドを少しでも節約する必要があるためである。

#@since 2.0.0
2.0.0以降ではキーワード引数による引数指定が可能です。#@end

@param output 出力先([[c:IO]] のように << で書き込めるオブジェクト)
@param indent インデントのスペースの数(-1 だとインデントしない)
@param transitive XMLではインデントのスペースでDOMが変化してしまう場合がある。       これに真を渡すと、XMLのDOMに余計な要素が加わらないように
       空白の出力を適当に抑制するようになる
@param ie_hack IEはバージョンによってはXMLをちゃんと解釈できないので、
       それに対応したXMLを出力するかどうかを真偽値で指定する

#@#== Constants

--- DECLARATION -> REXML::XMLDecl
この定数は deprecated です。[[m:REXML::XMLDecl.default]] を
代わりに使ってください。

デフォルトとして使えるXML宣言オブジェクト。


