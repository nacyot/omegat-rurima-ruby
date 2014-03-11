require rubygems

Gem パッケージに含まれているファイルのうちロード可能なものを検索するためのライブラリです。

= class Gem::GemPathSearcher

Gem パッケージに含まれているファイルのうちロード可能なものを検索するためのクラスです。

== Public Instance Methods

--- find(path) -> Gem::Specification | nil

与えられたパスにマッチする [[c:Gem::Specification]] を一つだけ返します。

@see [[m:Array#find]]

--- find_all(path) -> [Gem::Specification]

与えられたパスにマッチする [[c:Gem::Specification]] を全て返します。

@see [[m:Array#find_all]]

--- init_gemspecs -> [Gem::Specification]

インストール済みの Gem の [[c:Gem::Specification]] のリストを返します。

リストはアルファベット順かつバージョンの新しい順にソートされています。

--- lib_dirs_for(spec) -> String

ライブラリの格納されているディレクトリを glob に使える形式で返します。

예:
  '/usr/local/lib/ruby/gems/1.8/gems/foobar-1.0/{lib,ext}'


--- matching_file?(spec, path) -> bool

与えられた spec に path が含まれている場合、真を返します。그렇지 않으면 false를 리턴합니다.

@param spec [[c:Gem::Specification]] 객체를 지정합니다.

@param path 探索対象のパスを指定します。

--- matching_files(spec, path) -> [String]

与えられた spec に path が含まれている場合、その path のリストを返します。

@param spec [[c:Gem::Specification]] 객체를 지정합니다.

@param path 探索対象のパスを指定します。


== Singleton Methods

--- new -> Gem::GemPathSearcher

検索を行うのに必要なデータを初期化します。


