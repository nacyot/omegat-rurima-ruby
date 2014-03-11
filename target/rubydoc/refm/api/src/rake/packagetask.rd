require rake
require rake/tasklib

zip, tar등 배포용 패키지를 만드는 태스크를 정의합니다.

이 라이브러리를 읽어오면 다음과 같은 태스크를 사용할 수 있습니다.

: package
  패키지를 만듭니다.
: clobber_package
  만든 패키지를 삭제합니다.이 태스크는 clobber 태스크에도 추가됩니다.
: repackage
  패키지에 변경사항이 없더라도 패키지를 새로 만듭니다.
: PACKAGE_DIR/NAME-VERSION.tgz
  [[m:Rake::PackageTask#need_tar]] 가 true이면 gzip으로 압축된 tar 패키지를 생성합니다.
: PACKAGE_DIR/NAME-VERSION.tar.gz
  [[m:Rake::PackageTask#need_tar_gz]] 가 true이면 gzip으로 압축된 tar 패키지를 생성합니다.
: PACKAGE_DIR/NAME-VERSION.tar.bz2
  [[m:Rake::PackageTask#need_tar_bz2]] 가 true이면 bzip2으로 압축된 tar 패키지를 생성합니다.
: PACKAGE_DIR/NAME-VERSION.zip
  [[m:Rake::PackageTask#need_zip]] 가 true이면 zip으로 압축된 패키지를 생성합니다.

예:
   Rake::PackageTask.new("rake", "1.2.3") do |t|
     t.need_tar = true
     t.package_files.include("lib/**/*.rb")
   end

= class Rake::PackageTask < Rake::TaskLib

zip, tar등 배포용 패키지를 만드는 태스크를 정의하는 클래스입니다.

== Public Instance Methods

--- define -> self

태스크를 정의합니다.

@raise RuntimeError 버전 정보가 설정되어있지 않으면 발생합니다.
                    초기화할 때 :noversion을 지정하면 발생하지 않습니다.

--- init(name, version)
#@# discard

각 속성에 기본 설정 값을 지정합니다.

@param name 패키지 이름을 지정합니다.

@param version 패키지 버전을 지정합니다.

--- name -> String

버전 정보를 포함하지 않는 패키지의 이름을 리턴합니다.

--- name=(name)

버전 정보를 포함하지 않는 패키지의 이름을 지정합니다.

@param name 패키지 이름을 지정합니다.

--- need_tar -> bool

이 값이 true이면 gzip으로 압축된 tar 파일(tgz)를 생성합니다.
기본 설정은 false입니다.

--- need_tar=(flag)

패키지를 gzip으로 압축한 tar 파일(tgz)로 생성할지 설정합니다.

@param flag boolean 값을 지정합니다.

--- need_tar_bz2 -> bool

이 값이 true이면 bzip2로 압축된 tar 파일(tar.bz2)를 생성합니다.
기본 설정은 false입니다.

--- need_tar_bz2=(flag)

패키지를 bzip2으로 압축한 tar 파일(tar.bz2)로 생성할지 설정합니다.

@param flag boolean 값을 지정합니다.

--- need_tar_gz -> bool

이 값이 true이면 gzip으로 압축된 tar 파일(tar.gz)를 생성합니다.
기본 설정은 false입니다.

--- need_tar_gz=(flag)

패키지를 gzip으로 압축한 tar 파일(tar.gz)로 생성할지 설정합니다.

@param flag boolean 값을 지정합니다.

--- need_zip -> bool

이 값이 true이면 패키지를 zip 파일로 생성합니다.
기본 설정은 false입니다.

--- need_zip=(flag)

패키지를 zip 파일 (tgz)로 생성할지 설정합니다.

@param flag boolean 값을 지정합니다.

--- package_dir -> String

패키지에 넣을 파일들이 저장된 디렉토리명을 리턴합니다.

--- package_dir=(dirname)

패키지에 넣을 파일들이 저장된 디렉토리명을 지정합니다.

@param dirname 패키지에 넣을 파일들이 저장된 디렉토리를 지정합니다.

--- package_dir_path -> String

パッケージに含むファイルを配置するディレクトリを返します。

--- package_files -> Rake::FileList

パッケージに含むファイルリストを返します。

--- package_files=(file_list)

パッケージに含むファイルリストを設定します。

@param file_list ファイルリストを指定します。

--- package_name -> String

バージョン情報を含むパッケージ名を返します。

--- tar_bz2_file -> String

tar.bz2 用のファイル名を返します。

--- tar_command -> String

tar コマンドとして使用するコマンドを返します。

デフォルトは 'tar' です。

--- tar_command=(command)

tar コマンドとして使用するコマンドを設定します。

@param command 명령어를 문자열로 지정합니다.

--- tar_gz_file -> String

tar.gz 用のファイル名を返します。

--- tgz_file -> String

tgz 用のファイル名を返します。

--- version -> String--- version -> String

作成するパッケージのバージョンを表す文字列を返します。

--- version=(str)

作成するパッケージのバージョンをセットします。

@param str バージョンを表す文字列を指定します。

--- zip_command -> String

zip コマンドとして使用するコマンドを返します。

デフォルトは 'zip' です。

--- zip_command=(command)

zip コマンドとして使用するコマンドを設定します。

@param command 명령어를 문자열로 지정합니다.

--- zip_file -> String

zip ファイル用のファイル名を返します。


== Singleton Methods

--- new(name = nil, version = nil){|t| ... } -> Rake::PackageTask

객체를 초기화하고 태스크를 정의힙니다.

블록을 넘겨받으면  self를 블록 인자로 블록을 평가합니다.

@param name パッケージ名を指定します。

@param version 패키지 버전을 지정합니다.
               ':noversion' というシンボルを指定するとバージョン情報をセットしません。
