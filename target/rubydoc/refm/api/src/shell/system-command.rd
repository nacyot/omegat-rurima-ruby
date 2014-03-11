
= class Shell::SystemCommand < Shell::Filter

== Singleton Methods

--- new(sh, command, *opts)
#@todo

@param sh

@param command

@param opts


== Instance Methods

--- active?-> bool
#@todo

--- command -> String
--- name    -> String
#@todo

コマンド名を返します。

--- each(rs = nil){|line| ... }
#@todo

@param rs

--- flush -> ()
#@todo

--- input=(inp)
#@todo

--- kill(signal) -> Integer

自身のプロセスにシグナルを送ります。

@param signal 시그널을 정수나 시그널 이름을 담은 문자열로 지정합니다.
              負の値を持つシグナル(あるいはシグナル名の前に-)を指定すると、
              プロセスではなくプロセスグループにシグナルを送ります。 

@see [[m:Process.#kill]]

--- notify(*opts) -> String
--- notify(*opts){|message| ... } -> String
#@todo

@param opts

@see [[m:Shell#notify]]

--- start -> ()
#@todo

--- start_export
#@todo

--- start_import -> ()
#@todo

--- super_each -> ()
#@todo

[[m:Shell::Filter#each]] です。

--- terminate -> ()
#@todo

--- wait?-> bool
#@todo

