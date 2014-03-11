require rake
require rake/packagetask

Gem Spec 파일로 Gem 패키지를 만드는 태스크를 정의하고있는 라이브러리입니다.

Gem 패키지 뿐만 아니라 zip, tgz, tar.gz, tar.bz2 포맷으르 생성할 수도 있습니다.

아래의 태스크들이 정의되어있습니다.

: PACKAGE_DIR/NAME-VERSION.gem
  Gem 패키지를 생성합니다.

예:
   require 'rubygems'
   
   spec = Gem::Specification.new do |s|
     s.platform = Gem::Platform::RUBY
     s.summary = "Ruby based make-like utility.""
     s.name = 'rake'
     s.version = PKG_VERSION
     s.requirements << 'none'
     s.require_path = 'lib'
     s.autorequire = 'rake'
     s.files = PKG_FILES
     s.description = <<EOF
   Rake is a Make-like program implemented in Ruby. Tasks
   and dependencies are specified in standard Ruby syntax. 
   EOF
   end
   
   Rake::GemPackageTask.new(spec) do |pkg|
     pkg.need_zip = true
     pkg.need_tar = true
   end

= class Rake::GemPackageTask < Rake::PackageTask

Gem Spec 파일로 Gem 패키지를 만드는 태스크를 정의하고있는 클래스입니다.


== Public Instance Methods

--- define
#@# discard

태스크를 정의합니다.

[[m:GemPackageTask.new]] 에 블록이 넘겨받는 경우 자동적으로 호출됩니다.

--- gem_file -> String

Gem 패키지의 이름을 리턴합니다.

--- gem_spec -> Gem::Specification

package ターゲットで使用する gemspec を返します。

gemspec에는 패키지명, 버전, 패키지에 포함되는 파일이 정의되어 있으므로 이러한 것들을 명시적으로 지정할 필요는 없습니다.

--- gem_spec=(gem_spec)

gemspec을 지정합니다.

@param gem_spec [[c:Gem::Specification]] 의 인스턴트를 지정합니다.

--- init(gem_spec)
#@# discard

각 속성의 기본 설정을 지정합니다.

== Singleton Methods

--- new(gem_spec){|t| ... } -> Rake::GemPackageTask

객체를 초기화하고 태스크를 정의힙니다.

블록을 넘겨받으면  self를 블록 인자로 블록을 평가합니다.

@param gem_spec [[c:Gem::Specification]] 의 인스턴트를 지정합니다.
