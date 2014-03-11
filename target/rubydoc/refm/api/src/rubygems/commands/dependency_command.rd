require rubygems/command
require rubygems/local_remote_options
require rubygems/version_option
require rubygems/source_info_cache

インストールされている Gem パッケージの依存関係を表示するためのライブラリです。

  Usage: gem dependency GEMNAME [options]
    Options:
      -v, --version VERSION            指定したバージョンの依存関係を表示します
          --platform PLATFORM          指定したプラットフォームの依存関係を表示します
      -R, --[no-]reverse-dependencies  この Gem を使用している Gem を表示します
      -p, --pipe                       Pipe Format (name --version ver)
#@include(local_remote_options)
#@include(common_options)
    Arguments:
      GEMNAME       依存関係を表示する Gem の名前を指定します
    Summary:
      インストールされている Gem の依存関係を表示します
    Defaults:
      --local --version '>= 0' --no-reverse-dependencies


= class Gem::Commands::DependencyCommand < Gem::Command
include Gem::LocalRemoteOptions
include Gem::VersionOption

インストールされている Gem パッケージの依存関係を表示するためのクラスです。


== Public Instance Methods

--- usage -> String

사용방법을 나타내는 문자열을 리턴합니다.

--- arguments -> String

인수의 설명을 나타내는 문자열을 리턴합니다.

--- execute -> ()

명령어를 실행합니다.

--- find_gems(name, source_index) -> Hash

与えられた Gem の名前をインデックスから検索します。

@param name Gem の名前を指定します。

@param source_index [[c:Gem::SourceIndex]] のインスタンスを指定します。

@see [[m:Gem::SourceIndex#search]]

--- find_reverse_dependencies(spec) -> Array

与えられた Gem スペックに依存する Gem のリストを返します。

@param spec [[c:Gem::Specification]] 객체를 지정합니다.

--- print_dependencies(spec, level = 0) -> String

依存関係を表す文字列を返します。

@param spec [[c:Gem::Specification]] 객체를 지정합니다.

@param level 依存関係の深さを指定します。
