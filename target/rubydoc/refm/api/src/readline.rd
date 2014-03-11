category CUI

GNU Readline을 통해 명령어 입력 인터페이스를 제공하는 라이브러립니다.

= module Readline

GNU Readline을 통해 명령어 입력 인터페이스를 제공하는 모듈입니다.

GNU Readline 호환 라이브러리의 하나인 Edit Line(libedit)도 지원합니다.

  * [[url:http://www.gnu.org/directory/readline.html]]
  * [[url:http://www.thrysoee.dk/editline/]]

Readline.readline을 사용해 사용자의 입력을 읽어들입니다.
이 때 GNU Readline의 방식으로 입력을 자동완성 하거나
Emacs의 단축키를 사용할 수 있습니다.

예: 프롬프트 "> " 를 표시해서 사용자의 입력을 읽어오기.

  while buf = Readline.readline("> ", true)
    print("-> ", buf, "\n")
  end

사용자가 입력한 내용을 기억하는 히스토리 기능을 가지고 있습니다.
상수 [[c:Readline::HISTORY]]를 사용해 히스토리를 사용할 수 있습니다.
예를 들어 [[c:Readline::HISTORY]].to_a를 통해 배열로 변환하면
지금까지 입력한 모든 내용을 문자열 배열로 리턴합니다.

예: 히스토리를 배열로 읽어오기

  while buf = Readline.readline("> ", true)
    p Readline::HISTORY.to_a
    print("-> ", buf, "\n")
  end

== Module Functions

--- readline(prompt = "", add_hist = false) -> String | nil

prompt를 출력하고 사용자가 입력하기를 기다립니다.
엔터키를 눌러 사용자가 문자열의 입력을 끝내면
입력한 문자열을 리턴합니다.
이 때 add_hist가 true이면 입력한 문자열을 히스토리에 추가합니다.
아무 것도 입력하지 않은 상태에서 EOF(UNIX에서는 ^D)를 입력하는 등
입력이 없는 경우는 nil을 리턴합니다.

이 메소느는 쓰레드를 지원합니다.
入力待ち状態のときはスレッドコンテキストの切替えが発生します。

입력 중에는 입력 내용을 편집할 수 있으며 vi 모드와 Emacs 모드를 사용할 수 있습니다.
기본 설정은 Emacs 모드입니다.

@param prompt 커서 앞 부분에 나타낼 문자열을 지정합니다.기본 설정은 ""입니다.
@param add_hist true이면 입력한 문자열을 히스토리에 추가합니다.기본 설정은 false입니다.

@raise SecurityError 세이프 레벨 변수 ($SAFE)가 4이면 발생합니다.

@raise IOError 標準入力が tty でない、かつ、標準入力をクローズしている
               ([[man:isatty(2)]] の errno が EBADF である。) 場合に発生します。

예: 

  require "readline"

  input = Readline.readline
  (プロンプトなどは表示せずに、入力待ちの状態になります。   ここでは「abc」を入力後、エンターキーを押したと想定します。)
  abc

  p input # => "abc"

  input = Readline.readline("> ")
  (">"을 표시하고 입력 대기 상태에 들어갑니다.
   입력 대기 상태에서 사용자가 'ls'를 입력 후 엔터키를 누릅니다.)
  > ls

  p input # => "ls"

  input = Readline.readline("> ", true)
  (">"을 표시하고 입력 대기 상태에 들어갑니다.
   입력 대기 상태에서 사용자가 'cd'를 입력 후 엔터키를 누릅니다.
  > cd

  p input # => "cd"

  input = Readline.readline("> ", true)
  (">"을 표시하고 입력 대기 상태에 들어갑니다.
   이 상태에서 위 쪽 화살표나 ^P를 입력하면
   방금 입력한 cd가 표시됩니다.
   그리고 사용자가 엔터키를 누릅니다.
  > cd

  p input # => "cd"

이 메소드를 사용하는 데 있어 주의해야할 부분이 있습니다.
입력 대기 상태에서 ^C를 입력하면 ruby 인터프리터 자체가 종료되어버립니다.
이 상황을 피하기 위해서 아래 2가지 예를 참조하세요.

예: ^C 입력에 의한 Interrupt 가로채 입력 대기 상태로 돌아가기.

  stty_save = `stty -g`.chomp
  begin
    while buf = Readline.readline
        p buf
        end
      rescue Interrupt
        system("stty", stty_save)
        exit
      end
    end
  end

예: INT 시그널을 가로채 입력 대기 상태로 돌아가기

  stty_save = `stty -g`.chomp
  trap("INT") { system "stty", stty_save; exit }

  while buf = Readline.readline
    p buf
  end

마지막으로 ^C를 무시하는 방법도 있습니다.

  trap("INT", "SIG_IGN")

  while buf = Readline.readline
    p buf
  end

Readline::HISTORY을 사용해서 다음과 같은 일들을 할 수 있습니다.

예: 줄바꿈이나 바로 직전에 입력한 내용을 히스토리에 남기지 않기

  while buf = Readline.readline("> ", true)
    # p Readline::HISTORY.to_a
    Readline::HISTORY.pop if /^\s*$/ =~ buf
 
    begin
      if Readline::HISTORY[Readline::HISTORY.length-2] == buf
        Readline::HISTORY.pop 
      end
    rescue IndexError
    end
 
    # p Readline::HISTORY.to_a
    print "-> ", buf, "\n"
  end

@see [[m:Readline.vi_editing_mode]]、[[m:Readline.emacs_editing_mode]]、
     [[c:Readline::HISTORY]]

== Singleton Methods

#@since 1.9.1
--- input=(input)

readline メソッドで使用する入力用の [[c:File]] オブジェクト input を指定します。
戻り値は指定した [[c:File]] オブジェクト input です。

@param input [[c:File]] オブジェクトを指定します。

--- output=(output)
    
readline メソッドで使用する出力用の [[c:File]] オブジェクト output を指定します。戻り値は指定した [[c:File]] オブジェクト output です。

@param output [[c:File]] オブジェクトを指定します。#@end

--- completion_proc=(proc)

ユーザからの入力を補完する時の候補を取得する [[c:Proc]] オブジェクト
proc を指定します。proc は、次のものを想定しています。  (1) callメソッドを持つ。callメソッドを持たない場合、例外 ArgumentError を発生します。  (2) 引数にユーザからの入力文字列を取る。  (3) 候補の文字列の配列を返す。

#@since 1.8.0
「/var/lib /v」の後で補完を行うと、
デフォルトでは proc の引数に「/v」が渡されます。このように、ユーザが入力した文字列を
[[m:Readline.completer_word_break_characters]] に含まれる文字で区切ったものを単語とすると、
カーソルがある単語の最初の文字から現在のカーソル位置までの文字列が proc の引数に渡されます。#@end

@param proc ユーザからの入力を補完する時の候補を取得する [[c:Proc]] オブジェクトを指定します。

@raise SecurityError 세이프 레벨 변수 ($SAFE)가 4이면 발생합니다.

例: foo、foobar、foobazを補完する。

  require 'readline'

  WORDS = %w(foo foobar foobaz)

  Readline.completion_proc = proc {|word|
      WORDS.grep(/\A#{Regexp.quote word}/)
  }

  while buf = Readline.readline("> ")
    print "-> ", buf, "\n"
  end

@see [[m:Readline.completion_proc=]]

--- completion_proc -> Proc

ユーザからの入力を補完する時の候補を取得する [[c:Proc]] オブジェクト
proc を取得します。

@raise SecurityError 세이프 레벨 변수 ($SAFE)가 4이면 발생합니다.

@see [[m:Readline.completion_proc]]

--- completion_case_fold=(bool)

ユーザの入力を補完する際、大文字と小文字を同一視する／しないを指定します。
bool が真ならば同一視します。bool が偽ならば同一視しません。

@param bool 大文字と小文字を同一視する(true)／しない(false)を指定します。

@raise SecurityError 세이프 레벨 변수 ($SAFE)가 4이면 발생합니다.

@see [[m:Readline.completion_case_fold]]

--- completion_case_fold -> bool

ユーザの入力を補完する際、大文字と小文字を同一視する／しないを取得します。
bool が真ならば同一視します。bool が偽ならば同一視しません。

なお、Readline.completion_case_fold= メソッドで指定したオブジェクトを
そのまま取得するので、次のような動作をします。

  Readline.completion_case_fold = "This is a String."
  p Readline.completion_case_fold # => "This is a String."

@raise SecurityError 세이프 레벨 변수 ($SAFE)가 4이면 발생합니다.

@see [[m:Readline.completion_case_fold=]]

--- vi_editing_mode -> nil

編集モードを vi モードにします。
vi モードの詳細は、GNU Readline のマニュアルを参照してください。

  * [[url:http://www.gnu.org/directory/readline.html]]

@raise NotImplementedError 지원하지 않는 환경에서 발생합니다.

@raise SecurityError 세이프 레벨 변수 ($SAFE)가 4이면 발생합니다.

--- emacs_editing_mode -> nil

編集モードを Emacs モードにします。기본 설정은 Emacs 모드입니다.

Emacs モードの詳細は、 GNU Readline のマニュアルを参照してください。

  * [[url:http://www.gnu.org/directory/readline.html]]

@raise NotImplementedError 지원하지 않는 환경에서 발생합니다.

@raise SecurityError 세이프 레벨 변수 ($SAFE)가 4이면 발생합니다.

--- completion_append_character=(string)

ユーザの入力の補完が完了した場合に、最後に付加する文字 string を指定します。

@param string 1文字を指定します。

@raise NotImplementedError 지원하지 않는 환경에서 발생합니다.

@raise SecurityError 세이프 레벨 변수 ($SAFE)가 4이면 발생합니다.

半角スペース「" "」などの単語を区切る文字を指定すれば、
連続して入力する際に便利です。

  Readline.readline("> ", true)
  Readline.completion_append_character = " "
  > /var/li
  ここで補完(TABキーを押す)を行う。  > /var/lib 
  最後に" "が追加されているため、すぐに「/usr」などを入力できる。  > /var/lib /usr

なお、1文字しか指定することはできないため、
例えば、"string"を指定した場合は最初の文字である"s"だけを使用します。

  Readline.completion_append_character = "string"
  p Readline.completion_append_character # => "s"

@see [[m:Readline.completion_append_character]]

--- completion_append_character -> String

ユーザの入力の補完が完了した場合に、最後に付加する文字を取得します。

@raise NotImplementedError 지원하지 않는 환경에서 발생합니다.

@raise SecurityError 세이프 레벨 변수 ($SAFE)가 4이면 발생합니다.

@see [[m:Readline.completion_append_character=]]

#@since 1.8.0
--- basic_word_break_characters=(string)

ユーザの入力の補完を行う際、
単語の区切りを示す複数の文字で構成される文字列 string を指定します。

GNU Readline のデフォルト値は、Bash の補完処理で使用している文字列
" \t\n\"\\'`@$><=;|&{(" (スペースを含む) になっています。

@param string 문자열을 지정합니다.

@raise NotImplementedError 지원하지 않는 환경에서 발생합니다.

@raise SecurityError 세이프 레벨 변수 ($SAFE)가 4이면 발생합니다.

@see [[m:Readline.basic_word_break_characters]]

--- basic_word_break_characters -> String

ユーザの入力の補完を行う際、
単語の区切りを示す複数の文字で構成される文字列を取得します。

@raise NotImplementedError 지원하지 않는 환경에서 발생합니다.

@raise SecurityError 세이프 레벨 변수 ($SAFE)가 4이면 발생합니다.

@see [[m:Readline.basic_word_break_characters=]]

--- completer_word_break_characters=(string)

ユーザの入力の補完を行う際、
単語の区切りを示す複数の文字で構成される文字列 string を指定します。
[[m:Readline.basic_word_break_characters=]] との違いは、
GNU Readline の rl_complete_internal 関数で使用されることです。

GNU Readline のデフォルトの値は、 
[[m:Readline.basic_word_break_characters]] と同じです。

@param string 문자열을 지정합니다.

@raise NotImplementedError 지원하지 않는 환경에서 발생합니다.

@raise SecurityError 세이프 레벨 변수 ($SAFE)가 4이면 발생합니다.

@see [[m:Readline.completer_word_break_characters]]

--- completer_word_break_characters -> String

ユーザの入力の補完を行う際、
単語の区切りを示す複数の文字で構成された文字列を取得します。
[[m:Readline.basic_word_break_characters]] との違いは、
GNU Readline の rl_complete_internal 関数で使用されることです。

@raise NotImplementedError 지원하지 않는 환경에서 발생합니다.

@raise SecurityError 세이프 레벨 변수 ($SAFE)가 4이면 발생합니다.

@see [[m:Readline.completer_word_break_characters=]]

--- basic_quote_characters=(string)

スペースなどの単語の区切りをクオートするための
複数の文字で構成される文字列 string を指定します。

GNU Readline のデフォルト値は、「"'」です。

@param string 문자열을 지정합니다.

@raise NotImplementedError 지원하지 않는 환경에서 발생합니다.

@raise SecurityError 세이프 레벨 변수 ($SAFE)가 4이면 발생합니다.

@see [[m:Readline.basic_quote_characters]]

--- basic_quote_characters -> String

スペースなどの単語の区切りをクオートするための
複数の文字で構成される文字列を取得します。

@raise NotImplementedError 지원하지 않는 환경에서 발생합니다.

@raise SecurityError 세이프 레벨 변수 ($SAFE)가 4이면 발생합니다.

@see [[m:Readline.basic_quote_characters=]]

--- completer_quote_characters=(string)

ユーザの入力の補完を行う際、スペースなどの単語の区切りを
クオートするための複数の文字で構成される文字列 string を指定します。
指定した文字の間では、[[m:Readline.completer_word_break_characters=]]
で指定した文字列に含まれる文字も、普通の文字列として扱われます。

@param string 문자열을 지정합니다.

@raise NotImplementedError 지원하지 않는 환경에서 발생합니다.

@raise SecurityError 세이프 레벨 변수 ($SAFE)가 4이면 발생합니다.

@see [[m:Readline.completer_quote_characters]]

--- completer_quote_characters -> String

ユーザの入力の補完を行う際、スペースなどの単語の区切りを
クオートするための複数の文字で構成される文字列を取得します。

@raise NotImplementedError 지원하지 않는 환경에서 발생합니다.

@raise SecurityError 세이프 레벨 변수 ($SAFE)가 4이면 발생합니다.

@see [[m:Readline.completer_quote_characters=]]

--- filename_quote_characters=(string)

ユーザの入力時にファイル名の補完を行う際、スペースなどの単語の区切りを
クオートするための複数の文字で構成される文字列 string を指定します。

GNU Readline のデフォルト値は nil(NULL) です。

@param string 문자열을 지정합니다.

@raise NotImplementedError 지원하지 않는 환경에서 발생합니다.

@raise SecurityError 세이프 레벨 변수 ($SAFE)가 4이면 발생합니다.

@see [[m:Readline.filename_quote_characters]]

--- filename_quote_characters -> String

ユーザの入力時にファイル名の補完を行う際、スペースなどの単語の区切りを
クオートするための複数の文字で構成される文字列を取得します。

@raise NotImplementedError 지원하지 않는 환경에서 발생합니다.

@raise SecurityError 세이프 레벨 변수 ($SAFE)가 4이면 발생합니다.

@see [[m:Readline.filename_quote_characters=]]
#@end

#@#== Constants

--- VERSION -> String

Readlineモジュールが使用している GNU Readline や libedit のバージョンを
示す文字列です。

--- FILENAME_COMPLETION_PROC -> Proc

GNU Readline で定義されている関数を使用してファイル名の補完を行うための
[[c:Proc]] オブジェクトです。
[[m:Readline.completion_proc=]] で使用します。

@see [[m:Readline.completion_proc=]]

--- USERNAME_COMPLETION_PROC -> Proc

GNU Readline で定義されている関数を使用してユーザ名の補完を行うための
[[c:Proc]] オブジェクトです。
[[m:Readline.completion_proc=]] で使用します。

@see [[m:Readline.completion_proc=]]

= object Readline::HISTORY

extend Enumerable

Readline::HISTORY を使用してヒストリにアクセスできます。
[[c:Enumerable]] モジュールを extend しており、
[[c:Array]] クラスのように振る舞うことができます。
例えば、HISTORY[4] により 5 番目に入力した内容を取り出すことができます。

--- to_s -> "HISTORY"

문자열 "HISTORY"를 리턴합니다.

예:

  Readline::HISTORY.to_s #=> "HISTORY"

--- [](index) -> String

ヒストリから index で指定したインデックスの内容を取得します。
例えば index に 0 を指定すると最初の入力内容が取得できます。
また、 -1 は最後の入力内容というように、index に負の値を指定することで、
最後から入力内容を取得することもできます。

@param index 取得対象のヒストリのインデックスを整数で指定します。             インデックスは [[c:Array]] ように 0 から指定します。             また、 -1 は最後の入力内容というように、負の数を指定することもできます。

@raise IndexError index で指定したインデックスに該当する入力内容がない場合に発生します。

@raise RangeError index で指定したインデックスが int 型よりも大きな値の場合に発生します。

@raise SecurityError 세이프 레벨 변수 ($SAFE)가 4이면 발생합니다.

예:

  require "readline"

  Readline::HISTORY[0] #=> 가장 먼저 입력한 내용
  Readline::HISTORY[4] #=> 5번째 입력한 내용
  Readline::HISTORY[-1] #=> 마지막에 입력한 내용
  Readline::HISTORY[-5] #=> 뒤에서 5번째 입력한 내용

例: 1000000 番目の入力内容が存在しない場合、例外 IndexError が発生します。

  Readline::HISTORY[1000000] #=> 例外 IndexError が発生します。

例: 32 bit のシステムの場合、例外 RangeError が発生します。

  Readline::HISTORY[2 ** 32 + 1] #=> 例外 RangeError が発生します。

例: 64 bit のシステムの場合、例外 RangeError が発生します。

  Readline::HISTORY[2 ** 64 + 1] #=> 例外 RangeError が発生します。

--- []=(index, string)

ヒストリの index で指定したインデックスの内容を string で指定した文字列で書き換えます。
例えば index に 0 を指定すると最初の入力内容が書き換えます。
また、 -1 は最後の入力内容というように、index に負の値を指定することで、
最後から入力内容を取得することもできます。
指定した string を返します。

@param index 取得対象のヒストリのインデックスを整数で指定します。             インデックスは [[c:Array]] ように 0 から指定します。             また、 -1 は最後の入力内容というように、負の数を指定することもできます。@param string 문자열을 지정합니다.この文字列でヒストリを書き換えます。

@raise IndexError index で指定したインデックスに該当する入力内容がない場合に発生します。

@raise RangeError index で指定したインデックスが int 型よりも大きな値の場合に発生します。

@raise NotImplementedError 지원하지 않는 환경에서 발생합니다.

@raise SecurityError 세이프 레벨 변수 ($SAFE)가 4이면 발생합니다.

--- <<(string) -> self

히스토리 뒤에 string으로 지정된 문자열을 추가합니다.
self를 리턴합니다.

@param string 문자열을 지정합니다.

@raise SecurityError 세이프 레벨 변수 ($SAFE)가 4이면 발생합니다.

예: "foo"를 추가하기.

  require "readline"

  Readline::HISTORY << "foo"
  p Readline::HISTORY[-1] #=> "foo"

예: "foo", "bar"를 추가하기

  require "readline"

  Readline::HISTORY << "foo" << "bar"
  p Readline::HISTORY[-1] #=> "bar"
  p Readline::HISTORY[-2] #=> "foo"

@see [[m:Readline::HISTORY.push]]

--- push(*string) -> self

히스토리 뒤에 string으로 지정된 문자열을 추가합니다.다수의 string을 지정할 수 있습니다.
self를 리턴합니다.

@param string 문자열을 지정합니다.복수 지정도 가능합니다.

@raise SecurityError 세이프 레벨 변수 ($SAFE)가 4이면 발생합니다.

예: "foo"를 추가하기.

  require "readline"

  Readline::HISTORY.push("foo")
  p Readline::HISTORY[-1] #=> "foo"

예: "foo", "bar"를 추가하기

  require "readline"

  Readline::HISTORY.push("foo", "bar")
  p Readline::HISTORY[-1] #=> "bar"
  p Readline::HISTORY[-2] #=> "foo"

@see [[m:Readline::HISTORY.<<]]

--- pop -> String

히스토리 마지막의 내용을 읽어옵니다.
마지막 내용은 히스토리에서 지워집니다.

@raise NotImplementedError 지원하지 않는 환경에서 발생합니다.

@raise SecurityError 세이프 레벨 변수 ($SAFE)가 4이면 발생합니다.

예:

  require "readline"
  
  Readline::HISTORY.push("foo", "bar", "baz")
  p Readline::HISTORY.pop #=> "baz"
  p Readline::HISTORY.pop #=> "bar"
  p Readline::HISTORY.pop #=> "foo"

@see [[m:Readline::HISTORY.push]]、[[m:Readline::HISTORY.shift]]、
     [[m:Readline::HISTORY.delete_at]]

--- shift -> String

히스토리에서 첫번째 내용을 읽어옵니다.
첫번째 내용은 히스토리에서 지워집니다.

@raise NotImplementedError 지원하지 않는 환경에서 발생합니다.

@raise SecurityError 세이프 레벨 변수 ($SAFE)가 4이면 발생합니다.

예:

  require "readline"
  
  Readline::HISTORY.push("foo", "bar", "baz")
  p Readline::HISTORY.shift #=> "foo"
  p Readline::HISTORY.shift #=> "bar"
  p Readline::HISTORY.shift #=> "baz"

@see [[m:Readline::HISTORY.push]]、[[m:Readline::HISTORY.pop]]、
     [[m:Readline::HISTORY.delete_at]]

#@since 1.9.1
--- each -> Enumerator
#@end
--- each {|string| ... }

히스토리에 대해 블록을 평가합니다.
첫번째 기록부터 마지막 기록까지 순서대로 블록에 $$$

@raise SecurityError 세이프 레벨 변수 ($SAFE)가 4이면 발생합니다.

예: 히스토리 내용을 순서대로 출력하기.

  require "readline"
  
  Readline::HISTORY.push("foo", "bar", "baz")
  Readline::HISTORY.each do |s|
    p s #=> "foo", "bar", "baz"
  end

#@since 1.9.1
예: [[c:Enumerator]] 객체를 리턴하는 경우.

  require "readline"
  
  Readline::HISTORY.push("foo", "bar", "baz")
  e = Readline::HISTORY.each
  e.each do |s|
    p s #=> "foo", "bar", "baz"
  end
#@end

--- length -> Integer

히스토리에 저장된 내용의 갯수를 리턴합니다.

@raise SecurityError 세이프 레벨 변수 ($SAFE)가 4이면 발생합니다.

예: 히스토리 내용을 순서대로 출력하기.

  require "readline"
  
  Readline::HISTORY.push("foo", "bar", "baz")
  p Readline::HISTORY.length #=> 3

@see [[m:Readline::HISTORY.empty?]]

--- empty?-> bool

히스토리에 저장된 내용이 없으면 true를 리턴하고, 그렇지 않은 경우에는 false를 리턴합니다.

@raise SecurityError 세이프 레벨 변수 ($SAFE)가 4이면 발생합니다.

예:

  require "readline"
  
  p Readline::HISTORY.empty?#=> true
  Readline::HISTORY.push("foo", "bar", "baz")
  p Readline::HISTORY.empty?#=> false

@see [[m:Readline::HISTORY.length]]

--- delete_at(index) -> String | nil

index で指定したインデックスの内容をヒストリから削除し、その内容を返します。
該当する index の内容がヒストリになければ、 nil を返します。
index に 0 を指定すると [[m:Readline::HISTORY.shift]] 
と同様に最初の入力内容を削除します。
また、 -1 は最後の入力内容というように、index に負の値を指定することで、
最後から入力内容を取得することもできます。
index が -1 の場合は [[m:Readline::HISTORY.pop]] と同様に動作します。

@param index 削除対象のヒストリのインデックスを指定します。

@raise NotImplementedError 지원하지 않는 환경에서 발생합니다.

@raise SecurityError 세이프 레벨 변수 ($SAFE)가 4이면 발생합니다.

예:

  require "readline"
  
  Readline::HISTORY.push("foo", "bar", "baz")
  Readline::HISTORY.delete_at(1)
  p Readline::HISTORY.to_a #=> ["foo", "baz"]
