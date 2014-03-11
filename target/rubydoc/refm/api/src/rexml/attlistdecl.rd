#@#require rexml/child
#@#require rexml/source

= class REXML::AttlistDecl < REXML::Child
include Enumerable

DTD 속성 리스트 선언을 나타내는 클래스입니다.



== Class Methods

--- new(source) -> REXML::AttlistDecl
이 메소드는 내부에서만 사용되므로 직접 사용하지 말아주세요.



== Instance Methods

--- [](key) -> String | nil
key という属性名のデフォルト値を返します。

key という名前の属性が存在しない、もしくは
デフォルト値を持たない場合は nil を返します。

--- each {|name, value| ... } -> ()
それぞれの属性名、デフォルト値を引数として
ブロックを順に呼び出します。

デフォルト値を持たない属性に関しては nil が渡されます。

--- element_name -> String
属性を定義しているエレメントの名前を返します。

--- include?(key) -> bool
key が属性名であるならば真を返します。

@param key 属性名であるかどうか判定する文字列

--- node_type -> Symbol
[[c:Symbol]] :attlistdecl を返します。

--- write(out, indent = -1) -> ()
self を out に出力します。

@param out 出力先の IO オブジェクト
@param indent インデント数(無視されます)
