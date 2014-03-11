require test/unit
require test/unit/ui/testrunnerutilities

ユニットテストの実行を操作したいときに使います。

#@since 1.8.1
= class Test::Unit::AutoRunner

テストの実行を操作したいときにこの AutoRunner クラスを使います。
大量のテストの中から特定のテストスクリプトのみを実行したい場合、
特定のテストクラスのみを実行したい場合などに使います。
AutoRunner は Collector::Dir オブジェクトなどの Collector に
テストを集めさせて、UI::Console::TestRunner オブジェクトなどの
Runner にテストを実行させているクラスです。

=== 예

ディレクトリ ./somedir 以下にある全てのテストを実行したい場合は次のよう
なファイル(runner.rb)を用意して実行します。テストは test_*.rb というファ
イル名である必要があります。

#@since 1.8.3
第一引数に true を与えると、./somedir 以下にある全てのテストを実行します。  require 'test/unit'require 'test/unit'
  Test::Unit::AutoRunner.run(true, './somedir')
#@else
第一引数に false を与えると、./somedir 以下にある全てのテストを実行します。  require 'test/unit'require 'test/unit'
  Test::Unit::AutoRunner.run(false, './somedir')
#@end

単に実行します。

  $ ruby runner.rb

ディレクトリ ./somedir 以下にあるテストをファイル somefile を除いて実行
したい場合は次のように runner.rb にオプションを与えます。

  $ ruby runner.rb --exclude=somefile

同じことは、runner.rb に直接オプションを書いても実現できます。

#@since 1.8.3
  require 'test/unit'require 'test/unit'
  Test::Unit::AutoRunner.run(true, './somedir', ['--exclude=somefile'])
#@else
  require 'test/unit'require 'test/unit'
  Test::Unit::AutoRunner.run(false, './somedir', ['--exclude=somefile'])
#@end

上のやり方では拡張子が .rb のファイルしか集めません。拡張子が .rbx のファイルも
テストとして集めたい場合は次のようにします。

#@since 1.8.3
  require 'test/unit'require 'test/unit'
  Test::Unit::AutoRunner.run(true, './somedir', ['--pattern=/test_.*\.rbx\Z/'])
#@else
  require 'test/unit'require 'test/unit'
  Test::Unit::AutoRunner.run(false, './somedir', ['--pattern=/test_.*\.rbx\Z/'])
#@end


== Class Methods

#@since 1.8.3
--- run(force_standalone = false, dir = '.', argv = ARGV)    -> bool
#@else
--- run(force_standalone = nil, dir = '.', argv = ARGV)    -> bool
#@end

테스트를 실행합니다.모든 테스트가 성공하면 true를 리턴합니다.그렇지 않으면
false를 리턴합니다.

#@since 1.8.3
@param force_standalone true를 지정하면 dir 이하에 있는 모든 테스트를
                        실행합니다.false를 지정하면 이미 읽어들인
                        파일에서만 테스트를 실행합니다.테스트
                        를 읽어오지 않은 상태에서 스크립트를 -e 옵션과 함께
                        실행하면 dir 아래의 모든 테스트를
                        실행합니다.기본 설정은 false입니다.

@param dir force_standalone に true を与えた時に再帰的に探査するディレクトリ名を
           与えます。デフォルトではカレントディレクトリを再帰的に探査します。#@else
@param force_standalone $0 か false を与えます。$0 を与えた場合は既に読
                        み込まれたファイルの中からテストを探して実行し
                        합니다.false を与えた場合は、dir の中からテスト
                        スクリプトを再帰的に探査して実行します。デフォ
                        ルトではファイル名が test_*.rb のテストスクリプ
                        トしか探査しません。false を与えた場合でも、既
                        に読み込まれたファイルは実行するテストに含まれ
                        합니다.

@param dir force_standalone に false を与えた時に再帰的に探査するディレクトリ名を
           与えます。デフォルトではカレントディレクトリを再帰的に探査します。#@end

@param argv オプションを配列として与えます。解釈するオプションは先に
            出てきたものと同じです。

      -r, --runner=RUNNER              Use the given RUNNER.
                                       (c[onsole], f[ox], g[tk], g[tk]2, t[k])
#@since 1.8.6
      -b, --basedir=DIR                Base directory of test suites.
      -w, --workdir=DIR                Working directory to run tests.
#@end
      -n, --name=NAME                  Runs tests matching NAME.
                                       (patterns may be used).(patterns may be used).
      -t, --testcase=TESTCASE          Runs tests in TestCases matching TESTCASE.
                                       (patterns may be used).(patterns may be used).
      -v, --verbose=[LEVEL]            Set the output level (default is verbose).
                                       (s[ilent], p[rogress], n[ormal], v[erbose])
          --                           Stop processing options so that the
                                       remaining options will be passed to the
                                       test.
      -h, --help                       Display this help.
#@since 1.8.2
force_standalone に false を与えた時には次のオプションが追加されます。#@else
force_standalone に true を与えた時には次のオプションが追加されます。#@end
      -a, --add=TORUN                  Add TORUN to the list of things to run;
                                       can be a file or a directory.
      -p, --pattern=PATTERN            Match files to collect against PATTERN.
#@since 1.8.2
      -x, --exclude=PATTERN            Ignore files to collect against PATTERN.
#@end

예

      require 'test/unit'require 'test/unit'
      Test::Unit::AutoRunner.run(true, './', ['--runner=tk', '-v',
                                              '--exclude=/test_hoge.*\.rb\Z/i'])

argv にデフォルトのまま ARGV を渡しておけばコマンドラインからオプションを
指定できます。

      require 'test/unit'require 'test/unit'
      Test::Unit::AutoRunner.run(true, './')

と、runner.rb に書いておいて、コマンドラインから以下のように実行。

      $ ruby runner.rb --runner=tk -v --exclude=/test_hoge.\*\\.rb\\Z/i

#@end
