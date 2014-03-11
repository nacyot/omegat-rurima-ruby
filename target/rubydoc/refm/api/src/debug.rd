category Development

Ruby デバッガです。Ruby スクリプトのソースコードデバッグに使用します。

また、Emacs を使用したインタフェース rubydb3x.el が
Ruby のアーカイブの misc/ にあるので、活用してください。

=== 사용법

  $ ruby -rdebug foo.rb

または、Emacs から

    M-x load-library rubydb3x.el
    M-x rubydb

=== デバッグコマンド

以下は、デバッガで使用できるコマンド名とその用法の一覧です。
各コマンド名には省略形があります。

ここに挙げたもの以外を入力した場合、その入力を ruby の式として評価します。

: break
: break [<file>:]<position>|<class>:<method>
    ブレークポイントを設定します。引数を省略した場合設定したブレークポ
    イントを表示します。

    設定するブレークポイントの書式は プログラムファイル名:位置 か
    クラス名:メソッド名 です。    位置 はファイル中の行番号もしくはメソッド名で指定します。    ファイル名: を省略した場合は現在実行中のファイルを指定した
    ものと見倣されます。

    このコマンドの省略形は b です。

: catch <an Exception>
    例外が発生した時にデバッガを停止させるキャッチポイントを設定します。    引数を省略した場合設定したキャッチポイントを表示します。

    発生した例外が <an Exception> のサブクラスであれば
    デバッガが停止します。デフォルトのキャッチポイントは
    StandardErrorに設定されています。

    <an Exception>として off を指定すると
    例外発生時に停止しなくなります。

    このコマンドの省略形は cat です。

: watch <expression>
    式 <expression> の値が変化したときに停止するウォッ
    チポイントを設定します。

    このコマンドの省略形は wat です。

: delete [nnn]
    指定したブレークポイントを取り除きます。引数を省略した場合すべての
    ブレークポイントを取り除きます。

    このコマンドの省略形は del です。

: display <expression>
    処理が停止するごとに <expression> を評価するディス
    プレイ式を設定します。    引数を省略した場合すべてのディスプレイ式を表示します。

    このコマンドの省略形は disp です。

: undisplay <nnn>
    指定したディスプレイ式を取り除きます。引数を省略した場合すべての
    ディスプレイ式を取り除きます。

    このコマンドの省略形は undisp です。

: cont
    スクリプトが終了するまで、もしくは次のブレークポイントに到達するま
    で処理を続行します。

    このコマンドの省略形は c です。

: step [nnn]
    一行ずつ処理を実行します。引数を指定した場合、指定した行数分、処理を
    続行します。メソッドの中に入ります。

    このコマンドの省略形は s です。

: next [nnn]
    一行ずつ処理を実行します。引数を指定した場合、指定した行数分、処理を
    続行します。step [nnn]との違いは、メソッド呼び出しのところでそのメ
    ソッドの中に入らないことです。

    このコマンドの省略形は n です。

: where
: frame
    フレームのスタックと、現在のフレーム位置を表示します。

    このコマンドの省略形は w または f です。

: list [(-|nn-mm)]
    スクリプトを表示します。引数が `-' ならば前の行を表示します。    nn-mm の形式では指定した範囲の行のスクリプトを表示します。

    このコマンドの省略形は l です。

: up [nn]
    上位のフレームに上がります。

: down [nn]
    下位のフレームに下がります。

: finish
    外側のフレームに上がるまで処理を続行します。

    このコマンドの省略形は fin です。

: trace [(on|off)] [all]
    トレースモードの設定を変更します。トレースモードをonにすると、以後
    の実行においてメソッドの呼び出し関係が表示されます。引数を省略した
    場合現在のモードを表示します。all を指定した場合、全てのスレッドに
    対してモードの設定を変更します。

    このコマンドの省略形は tr です。

: quit
    スクリプトを中断し、デバッガを終了します。

    このコマンドの省略形は q です。

: var g[lobal]
: var l[ocal]
: var i[nstance] <object>
: var c[onst] <object>
    それぞれ、グローバル変数、ローカル変数、オブジェクト<object>の
    インスタンス変数、<object>の定数を表示します。

    このコマンドの省略形は v です。

: method i[nstance] <object>
: method <class|module>
    それぞれ、オブジェクト<object>のインスタンスメソッド
    クラスメソッド または モジュールメソッドを表示します。

    このコマンドの省略形は m です。

: thread l[ist]
    スレッドの一覧を表示します。

    このコマンドの省略形は th です。

: thread c[ur[rent]]
    現在のスレッドを表示します。

: thread <nnn>
: thread sw[itch] <nnn>
    実行するスレッドを <nnn> に切替えます。

: thread stop <nnn>
    スレッド <nnn> を停止します。

: thread resume <nnn>
    スレッド <nnn> を再開します。

: pp <expression>
    ruby の式 <expression> の結果を見やすく表示します。

: p <expression>
    ruby の式 <expression> の結果を表示します。

: restart
    プログラムを最初からやり直します。

    このコマンドの省略形は r です。

: help
    デバッグコマンドの一覧を表示します。

    このコマンドの省略形は h です。

=== 주의

このライブラリは [[m:$SAFE]] が 0 より大きい場合には使用できません。

= reopen Tracer

== class Methods

--- trace_func(*vars) -> object | nil

[[lib:debug]] ライブラリの内部で使用します。

= class DEBUGGER__

라이브러리 내부에서 사용합니다.
