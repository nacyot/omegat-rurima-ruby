require rubygems/command
require rubygems/user_interaction
#@# --
require rubygems/commands/build_command
require rubygems/commands/cert_command
require rubygems/commands/check_command
require rubygems/commands/cleanup_command
require rubygems/commands/contents_command
require rubygems/commands/dependency_command
require rubygems/commands/environment_command
require rubygems/commands/fetch_command
require rubygems/commands/generate_index_command
require rubygems/commands/help_command
require rubygems/commands/install_command
require rubygems/commands/list_command
require rubygems/commands/lock_command
require rubygems/commands/mirror_command
require rubygems/commands/outdated_command
require rubygems/commands/pristine_command
require rubygems/commands/query_command
require rubygems/commands/rdoc_command
require rubygems/commands/search_command
require rubygems/commands/server_command
require rubygems/commands/sources_command
require rubygems/commands/specification_command
require rubygems/commands/stale_command
require rubygems/commands/uninstall_command
require rubygems/commands/unpack_command
require rubygems/commands/update_command
require rubygems/commands/which_commandrequire rubygems/command
require rubygems/user_interaction
#@# --
require rubygems/commands/build_command
require rubygems/commands/cert_command
require rubygems/commands/check_command
require rubygems/commands/cleanup_command
require rubygems/commands/contents_command
require rubygems/commands/dependency_command
require rubygems/commands/environment_command
require rubygems/commands/fetch_command
require rubygems/commands/generate_index_command
require rubygems/commands/help_command
require rubygems/commands/install_command
require rubygems/commands/list_command
require rubygems/commands/lock_command
require rubygems/commands/mirror_command
require rubygems/commands/outdated_command
require rubygems/commands/pristine_command
require rubygems/commands/query_command
require rubygems/commands/rdoc_command
require rubygems/commands/search_command
require rubygems/commands/server_command
require rubygems/commands/sources_command
require rubygems/commands/specification_command
require rubygems/commands/stale_command
require rubygems/commands/uninstall_command
require rubygems/commands/unpack_command
require rubygems/commands/update_command
require rubygems/commands/which_commandrequire rubygems/command
require rubygems/user_interaction
#@# --
require rubygems/commands/build_command
require rubygems/commands/cert_command
require rubygems/commands/check_command
require rubygems/commands/cleanup_command
require rubygems/commands/contents_command
require rubygems/commands/dependency_command
require rubygems/commands/environment_command
require rubygems/commands/fetch_command
require rubygems/commands/generate_index_command
require rubygems/commands/help_command
require rubygems/commands/install_command
require rubygems/commands/list_command
require rubygems/commands/lock_command
require rubygems/commands/mirror_command
require rubygems/commands/outdated_command
require rubygems/commands/pristine_command
require rubygems/commands/query_command
require rubygems/commands/rdoc_command
require rubygems/commands/search_command
require rubygems/commands/server_command
require rubygems/commands/sources_command
require rubygems/commands/specification_command
require rubygems/commands/stale_command
require rubygems/commands/uninstall_command
require rubygems/commands/unpack_command
require rubygems/commands/update_command
require rubygems/commands/which_command


gem 명령어에 의해 지원되는 서브 명령어를 관리하는 라이브러리입니다.

Extra commands can be provided by writing a rubygems_plugin.rb
file in an installed gem.  You should register your command against the
Gem::CommandManager instance, like this:

  # file rubygems_plugin.rb
  require 'rubygems/command_manager'

  class Gem::Commands::EditCommand < Gem::Command:Command
    # ...
  end

  Gem::CommandManager.instance.register_command :edit

See Gem::Command for instructions on writing gem commands.

= class Gem::CommandManager
include Gem::UserInteraction

gem コマンドによってサポートされているサブコマンドを管理するクラスです。

== Singleton Methods

--- instance -> Gem::CommandManager

self를 인스턴스화로 만듭니다.


== Public Instance Methods

--- [](command_name) -> Gem::Command | nil

인수로 지정된 명령어에 해당하는 클래스의 객체를 리턴합니다.

@param command_name 명령어를 문자열로 지정합니다.

--- command_names -> Array

등록되어있는 명령어를 배열로 리턴합니다.

--- find_command(command_name) -> Gem::Command | nil

등록된 명령어들 중에서 command_name 명령어가 있는 검색합니다.

@param command_name 명령어를 문자열로 지정합니다.

@return [[c:Gem::Command]] 서브클래스 객체를 리턴합니다.

@raise RuntimeError 검색결과가 여러개일 때 발생합니다.
                    검색결과가 없을 때도 발생합니다.

--- find_command_possibilities(command_name) -> Array

등록된 명령어 중에서 command_name과 비슷한 명령어를 리턴합니다.

@param command_name 명령어를 문자열로 지정합니다.

--- process_args(args) -> ()

引数 args を処理して gem コマンドを実行するために必要な処理を行います。

@param args 명령행에서 넘겨받은 인수를 지정합니다.

--- register_command(command_name) -> false

self에 명령어를 등록합니다.

@param command_name 명령어를 심볼로 지정합니다.

--- run(args) -> ()

引数 args を処理して gem コマンドを実行中のエラーを捕捉します。

@param args 명령행에서 넘겨받은 인수를 지정합니다.

