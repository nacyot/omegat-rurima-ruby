#@#require rexml/child

= class REXML::Comment < REXML::Child
include Comparable

XML 코멘트를 나타내는 클래스.

XML에서 코멘트는 <!-- 와  -->에 둘러쌓인 텍스트입니다.

  require 'rexml/document'
  doc = REXML::Document.new(<<EOS)
  <!-- xx -->
  <root>
  <!-- yy -->
  text
  <!-- zz -->
  </root>
  EOS
  
  doc[0].string # => " xx "
  doc.root[1].string # => " yy "
  doc.root[3].string # => " zz "
  

== Class Methods

#@# --- new(source) -> REXML::Comment
--- new(string, parent = nil) -> REXML::Comment
--- new(comment, parent = nil) -> REXML::Comment

Comment 객체를 생성합니다.

인수에 REXML::Comment 객체를 넘기면 내용이 복사됩니다. 
단, 부모 노드의 정보는 복사되지 않습니다.

@param string 코멘트 문자열
@param comment REXML::Comment 객체
@param parent 부모 노드


== Instance Methods

--- string -> String
--- to_s -> String

코멘트 문자열을 리턴합니다.

--- string=(value)
코멘트 문자열을 지정합니다.

@param value 코멘트 내용을 담은 문자열.

--- clone -> REXML::Comment

내용을 복사한 Comment 객체를 리턴합니다.
단, 부모 노드의 정보는 복사되지 않습니다.

#@# --- write(output, indent = -1, transitive = false, ie_hack = false)
#@# #@todo

--- <=>(other) -> -1 | 0 | 1
other 의 내요오가[[m:REXML::Comment#string]])을 비교합니다.

--- ==(other) -> bool
other의 내용과([[m:REXML::Comment#string]])이 같다면 true를 리턴합니다.

--- node_type -> Symbol
심볼 :comment 을 리턴합니다.

#@#== Constants

#@# --- START
#@# #@todo
#@# 
#@# --- STOP
#@# #@todo
