category CUI

IOオブジェクトから指定したパターンが読み込まれるまで待つ機能を提供します。

#@#Author: A. Ito

Expect ライブラリは、tcl の expect パッケージと似たような機能を IO クラスに追加します。

$expect_verbose というグローバル変数に真をセットすると、
レシーバから文字を読み込む度に読み込んだ文字を標準出力に表示するようになります。

= reopen IO
== Instance Methods
--- expect(pattern, timeout = 9999999) -> Array | nil
--- expect(pattern, timeout = 9999999){|array| ... } -> nil

レシーバから指定したパターンを読み込むまで待ちます。

このメソッドがブロックなしで呼ばれた場合、まずレシーバである
IO オブジェクトから pattern にマッチするパターンが読みこまれる
まで待ちます。

このメソッドをブロック付きで呼びだした場合は、マッチした要素の
配列をブロックに渡して評価します。


@param pattern 文字列か正規表現を指定します。               文字列を指定した場合は、正規表現に変換されます。               
@param timeout タイムアウトする秒数。省略すると 9999999 秒後にタイムアウトします。

@return パターンが得られたら、そのパターンに関する配列を返します。        配列の最初の要素は、pattern にマッチするまでに読みこんだ文字列です。        2番目以降の要素は、pattern の正規表現中のアンカーにマッチした部分です。        タイムアウトした場合は nil を返します。

#@# sample を書く
