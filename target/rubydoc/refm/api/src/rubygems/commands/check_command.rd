require rubygems/command
require rubygems/version_option
require rubygems/validator

설치되어있는 Gem 패키지를 검증하기 위한 라이브러리입니다.

  Usage: gem check [options]
    Options:
          --verify FILE                内部のチェックサムにより Gem パッケージを検証します
      -a, --alien                      管理されていないパッケージを報告します
      -t, --test                       Gem パッケージのユニットテストを実行します
      -v, --version VERSION            特定のバージョンのテストを実行します
#@include(common_options)
    Summary:
      インストールされている Gem パッケージをチェックします


= class Gem::Commands::CheckCommand < Gem::Command

インストールされている Gem パッケージを検証するためのクラスです。

