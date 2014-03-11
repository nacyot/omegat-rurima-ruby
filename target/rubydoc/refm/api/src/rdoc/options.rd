#@since 1.9.1
#@# require rdoc/ri/paths
require optparse
#@else
#@# require rdoc/ri/ri_paths
require singleton
require getoptlong
#@end

rdoc 명령어의 옵션을 처리하는 서브라이브러리입니다. 

#@since 1.9.1
= class RDoc::Options
#@else
= class Options

include Singleton
#@end

rdoc 명령어의 옵션을 처리하는 클래스입니다.

옵션들의 자세한 내용은 [[ref:lib:rdoc#usage]]을 참조해주세요.

#@until 1.9.1
[주의] 클래스 이름이 RDoc::Opiton이 아닙니다.(1.9 버전대에선
RDoc::Option 으로도 사용할 수 있습니다.
#@end


== Instance Methods

--- exclude -> Regexp

--exclude 옵션으로 지정한 정규표현식을 리턴합니다.
여러 개가 지정되어있는 경우 하나의 [[c:Regexp]] 객체에 통합되어 리턴됩니다.

--- exclude=(val)

--exclude 옵션을 지정합니다.

@param val 정규표현식을 [[c:Regexp]] 객체로 지정합니다.

--- op_dir -> String

--op 옵션에서 지정한 디렉토리를 반환합니다.

--ri, --ri-site, --ri-system 옵션에도 영향을 받습니다.

@return 지정한 디렉토리를 문자열로 리턴합니다.

--- op_dir=(val)

--op 옵션을 지정합니다.

@param val 디렉토리를 문자열로 지정합니다.

--- op_name -> String

--opname 옵션으로 지정한 이름을 문자열로 리턴합니다.

--- show_all -> bool

--all 옵션이 지정되어 있는 경우 return을 리턴합니다.그렇지 않은 경우엔 false를 리턴합니다.

--- show_all=(val)

var에 true를 지정한 경우 --all 옵션과 같은 효과를 가집니다.

@param val --all 을 지정하려면 true를 지정하고 그렇지 않으면
           false를 지정합니다

--- main_page -> String | nil

コマンドライン引数の --main オプションで指定したファイル名、クラス/モ
ジュール名を返します。

指定しなかった場合は nil を返します。

--- main_page=(val)

コマンドライン引数の --main オプションと同様の指定を行います。

@param val 設定するファイル名、クラス/モジュール名を文字列で指定します。

--- merge -> true | nil

コマンドライン引数の --merge オプションを指定していた場合、true を返し
ます。그렇지 않으면 nil을 리턴합니다.

--- quiet -> bool

コマンドライン引数の --quiet オプションを指定していた場合、true を返し
ます。그렇지 않으면 nil을 리턴합니다.

--- generator -> Generator

コマンドライン引数の --fmt オプションで指定した文字列に応じた
Generator を返します。

指定しなかった場合は、HTML に対応する Generator を返します。

--- generator=(val)

コマンドライン引数の --fmt オプションと同様の指定を行います。

@param val 設定する Generator を指定します。

--- files -> [String]

解析するファイルの一覧を文字列の配列で返します。

--- rdoc_include -> [String]

コマンドライン引数の --include オプションで指定したディレクトリを文字列
の配列で返します。

指定しなかった場合は ['.'] を返します。

--- template -> String

コマンドライン引数の --template オプションで指定した名前を文字列の配列
で返します。

指定しなかった場合は 'html' を返します。

--- diagram -> bool

コマンドライン引数の --diagram オプションを指定していた場合、true を返
します。그렇지 않은 경우엔 false를 리턴합니다.

--- fileboxes -> bool

コマンドライン引数の --diagram オプション、--fileboxes オプションを指定
していた場合、true を返します。그렇지 않은 경우엔 false를 리턴합니다.

--- show_hash -> bool

コマンドライン引数の --show-hash オプションを指定していた場合、true を
返します。그렇지 않은 경우엔 false를 리턴합니다.

--- image_format -> String

コマンドライン引数の --image-format オプションで指定した名前を文字列の
配列で返します。

指定しなかった場合は 'png' を返します。

--- charset -> String

コマンドライン引数の --charset オプションで指定した文字コードを文字列で
返します。

指定しなかった場合は、[[m:$KCODE]] に応じた値になります。

--- inline_source -> bool

コマンドライン引数の --inline-source オプションか --one-file を指定して
いた場合、もしくは --fmt オプションに xml 指定した場合に true を返しま
す。그렇지 않은 경우엔 false를 리턴합니다.

--- all_one_file -> bool

コマンドライン引数の --one-file を指定していた場合、もしくは --fmt オプ
ションに xml 指定した場合に true を返します。그렇지 않은 경우엔 false를 리턴합니다.

--- tab_width -> Integer

コマンドライン引数の --tab-width オプションで指定した数値を返します。

--- include_line_numbers -> bool

コマンドライン引数の --include-line-numbers を指定していた場合に true
を返します。그렇지 않은 경우엔 false를 리턴합니다.

--- extra_accessors -> Regexp | nil

コマンドライン引数の --accessor オプションで指定したアクセサの名前すべ
てにマッチする正規表現オブジェクトを返します。

指定しなかった場合は nil を返します。

--- extra_accessor_flags -> {String => String}

コマンドライン引数の --accessor オプションで指定したアクセサがキー、ア
クセサの種類が値のハッシュを返します。

値は r、w、rw のいずれかです。それぞれ attr_reader、attr_writer、
attr_accessor に対応します。

--- css -> String

コマンドライン引数の --style オプションで指定した URL を文字列で返しま
す。

--- webcvs -> String | nil

コマンドライン引数の --webcvs オプションで指定した URL を文字列で返しま
す。

指定しなかった場合は nil を返します。

--- promiscuous

コマンドライン引数の --promiscuous を指定していた場合に true を返します。그렇지 않은 경우엔 false를 리턴합니다.

--- force_update -> bool

コマンドライン引数の --force_update を指定していた場合に true を返しま
す。그렇지 않은 경우엔 false를 리턴합니다.

#@since 1.9.1
--- parse(argv) -> ()
#@else
--- parse(argv, generators) -> ()
#@end

コマンドライン引数を解析します。

@param argv コマンドライン引数を文字列の配列で指定します。

#@until 1.9.1
@param generators Generator の配列を指定します。#@end

また、以下のような指定をした場合は標準エラーに出力を行い、終了コード 1
でプログラムを終了します。

 * --extension オプションに拡張子を 2 つ指定しなかった場合
 * --extension オプションに new=old を指定した時に old を扱えるフォーマッ
   タがない場合
 * --fmt オプションに扱えない出力を指定した場合
#@until 1.9.1
 * --image-format オプションを指定した時に、指定したフォーマットが png、
   gif、jpeg、jpg のいずれでもなかった場合
 * --tab-width オプションに数値以外を指定した場合
#@end

#@since 1.9.1
--- title -> String | nil

ドキュメントのタイトルを返します。指定されていない場合は nil を返します。

#@else
--- title -> String | "RDoc Documentation"

ドキュメントのタイトルを返します。指定されていない場合は "RDoc
Documentation" を返します。#@end

--- title=(string)

ドキュメントのタイトルがまだ設定されていない場合に string で指定した文
字列に設定します。

コマンドライン引数で既に --title オプションが指定されていた場合には、そ
ちらを優先します。

@param string 設定するタイトルを文字列で指定します。

#@since 1.9.1

--- formatter -> nil

使用されていません。常に nil を返します。

#@# 少なくとも --fmt オプションは @generator_name に値を代入する。参照
#@# もない。

--- formatter=(val)

使用されていません。

--- verbosity -> 0 | 1 | 2

プログラムの解析時に表示する情報の詳細さを数値で返します。

以下の値を指定する事ができます。

: 0(--quiet オプションを指定した場合)

  情報を表示しません。

: 1

  通常の表示を行います。

: 2(--verbose オプションを指定した場合)

  詳細な情報を表示します。

--- verbosity=(val)

プログラムの解析時に表示する情報の詳細さを数値で指定します。

@param val 何も表示しない場合は 0、通常の表示を行う場合は 1、詳細な表示
           を行う場合は 2 を指定します。

@see [[m:RDoc::Options#verbosity]]

#@end

#@since 1.9.2
--- pipe -> bool

コマンドライン引数の --pipe オプションを指定していた場合、true を返しま
す。그렇지 않은 경우엔 false를 리턴합니다.

--- pipe=(val)

val に true を指定した場合、コマンドライン引数の --pipe オプションと同
様の指定を行います。

@param val --pipe オプションと同じ指定を行う場合は true、そうでない場合
           false를 지정합니다

#@end

#@since 1.9.3
--- dry_run -> bool

コマンドライン引数の --dry-run オプションを指定していた場合、true を返
します。--no-dry-run オプションを指定していた場合、false を返します。

どちらも指定しなかった場合は false を返します。

--- dry_run=(val)

val に true を指定した場合、コマンドライン引数の --dry-run オプションと
同様の指定を行います。

@param val --dry-run オプションと同じ指定を行う場合は true、そうでない
           場合は false を指定します。

--- encoding -> Encoding

コマンドライン引数の --encoding オプションを指定していた場合、指定した
エンコーディングに対応する [[c:Encoding]] オブジェクトを返します。

指定しなかった場合は [[m:Encoding.default_external]] の値を返します。

--- encoding=(val)

コマンドライン引数の --encoding オプションと同様の指定を行います。

@param val 設定する [[c:Encoding]] オブジェクトを指定します。

--- force_output -> bool

コマンドライン引数の --force_output オプションを指定していた場合、true
を返します。--no-force_output オプションを指定していた場合、false を返
します。

どちらも指定しなかった場合は true を返します。

--- force_output=(val)

val に true を指定した場合、コマンドライン引数の --force_output オプショ
ンと同様の指定を行います。

@param val --force_output オプションと同じ指定を行う場合は true、そうで
           ない場合は false を指定します。

#@# 特に使用していないようなので、記述しない。#@#
#@#--- generator_options
#@#
#@#--- generator_options=(val)
#@#

--- hyperlink_all -> bool

コマンドライン引数の --hyperlink-all オプションを指定していた場合、
true を返します。

指定しなかった場合は false を返します。

--- hyperlink_all=(val)

val に true を指定した場合、コマンドライン引数の --hyperlink-all オプショ
ンと同様の指定を行います。

@param val --hyperlink-all オプションと同じ指定を行う場合は true、そう
           でない場合は false を指定します。

--- line_numbers -> bool

コマンドライン引数の --line-numbers オプションを指定していた場合、true
を返します。--no-line-numbers オプションを指定していた場合、false を返
します。

どちらも指定しなかった場合は false を返します。

--- line_numbers=(val)

val に true を指定した場合、コマンドライン引数の --line-numbers オプショ
ンと同様の指定を行います。

@param val --line-numbers オプションと同じ指定を行う場合は true、そうで
           ない場合は false を指定します。

--- coverage_report -> Integer | false

コマンドライン引数の --coverage-report オプションを指定していた場合、指
定した数値を返します。

指定しなかった場合は false を返します。

--- coverage_report=(val)

コマンドライン引数の --coverage-report オプションと同様の指定を行います。

@param val 数値オブジェクトか false を指定します。

#@# 特に使用していないようなので、記述しない。#@#
#@#--- option_parser
#@#
#@#--- option_parser=(val)
#@#

--- template_dir -> String | nil

コマンドライン引数の --template オプションで指定したテンプレートに対応
するディレクトリを返します。

オプションの解析前は nil を返します。

--- template_dir=(val)

コマンドライン引数の --template オプションで指定したテンプレートに対応
するディレクトリを設定します。

@param val パスを文字列で指定します。

#@# initialize 時に true が指定してあるのみで、他に影響しないため、記述
#@# しない。#@#
#@#--- update_output_dir -> bool
#@#
#@#--- update_output_dir=(val)
#@#

--- visibility -> :public | :protected | :private

コマンドライン引数の --visibility で指定したオプションを [[c:Symbol]]
で返します。

--- visibility=(val)

コマンドライン引数の --visibility オプションと同様の指定を行います。

@param val :public、:protected、:private のいずれかを指定します。#@end

#@# 1.8 系の Options::OptionList については、内部だけで使用しているため、
#@# 記述しない。
