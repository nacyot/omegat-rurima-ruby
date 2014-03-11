require rake
require rake/tasklib

문서를 생성하기 위한 태스크를 정의합니다.

아래의 태스크들이 정의되어있습니다.

: rdoc
  RDoc를 생성합니다.
: clobber_rdoc
  생성한 RDoc 파일을 삭제합니다.
  이 태스크는 clobber 태스크에도 추가됩니다.
: rerdoc
  RDoc 파일에 변경사항이 없어도 RDoc 파일을 새로 만듭니다.


예:
   Rake::RDocTask.new do |rd|
     rd.main = "README.rdoc"
     rd.rdoc_files.include("README.rdoc", "lib/**/*.rb")
   end

예:
   # RDoc タスクに別の名前を付ける例
   Rake::RDocTask.new(:rdoc_dev) do |rd|
     rd.main = "README.doc"
     rd.rdoc_files.include("README.rdoc", "lib/**/*.rb")
     rd.options << "--all"
   end

= class Rake::RDocTask < Rake::TaskLib

== Public Instance Methods

--- define -> self

태스크를 정의합니다.

--- external -> bool

이 값이 true이면 외부 쉘을 통해서 rdoc 명령어를 실행합니다.
기본 설정은 false입니다.

--- external=(flag)

외부 쉘을 통해서 rdoc 명령어를 실행할지 지정합니다.

@param flag boolean 값을 지정합니다.

--- main -> String

메인으로 사용되는 파일명을 리턴합니다.

--- main=(filename)

메일으로 사용되는 파일명을 지정합니다.

--- name -> String

태스크 이름을 리턴합니다.기본설정값은 rdoc입니다.

--- name=(name)

태스크 이름을 지정합니다.

@param name 태스크 이름을 지정합니다.

--- option_list -> Array

rdoc 명령어가 넘겨받은 옵션 목록을 리턴합니다.

--- option_string -> String

rdoc 명렁어가 넘겨받은 옵션을 문자열로 리턴합니다.

--- options -> Array

rdoc 명령어가 넘겨받은 옵션 목록을 리턴합니다.

지정할 수 있는 옵션은 -o, --main, --title, -T 같은 것들이 있습니다.

--- options=(options)

rdoc 명령어에 넘겨지는 옵션을 리스트로 지정합니다.

@param options rdoc 명령어에 넘겨지는 옵션을 지정합니다.

--- quote(str) -> String

[[m:Rake::RDocTask#external]] が真の場合は与えられた文字列をクオートします。

@param str クオートする文字列を指定します。

--- rdoc_dir -> String

作成した HTML ファイルを保存するディレクトリ名を返します。
デフォルトは html です。

--- rdoc_dir=(dir)

作成した HTML ファイルを保存するディレクトリ名をセットします。

--- rdoc_files -> Rake::FileList

RDoc の生成に使用するファイルリストを返します。
デフォルトは空です。

--- rdoc_files=(filelist)

RDoc の生成に使用するファイルリストをセットします。

@param filelist ファイルリストを指定します。

--- template -> String

使用するテンプレートを返します。
デフォルトは RDoc のデフォルトです。

--- template=(template)

使用するテンプレートをセットします。

@param template 使用するテンプレートを指定します。

--- title -> String

RDoc のタイトルを返します。
デフォルト値はありません。

--- title=(title)

RDoc のタイトルをセットします。

@param title タイトルを指定します。

== Singleton Methods

--- new(name = :rdoc){|pkg| ... } -> Rake::RDocTask

自身を初期化して RDoc タスクを定義します。

블록을 넘겨받으면  self를 블록 인자로 블록을 평가합니다.

@param name 태스크 이름을 지정합니다.
