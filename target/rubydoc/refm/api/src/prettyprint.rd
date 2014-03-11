pretty printing 알고르즘을 담은 라이브러리입니다.

=== 사용법

pretty printing은 보기 좋은 들여쓰기와 줄바꿈을 결정하기 위한 알고르즘을 가지고 있습니다.
들여쓰기와 줄바꿈은 사용자에 의해 주어진 트리 구조에서 결정됩니다.
따라서 사용자는 아래와 같은 출력하고자 하는 내용을 담은 트리를 만들어야만 합니다.

 * [[m:PrettyPrint.new]]으로 버퍼를 생성합니다.이 때 버퍼폭과 줄바꿈문자를 지정합니다.
 * [[m:PrettyPrint#text]] * [[m:PrettyPrint#group]]를 사용해 자식 노드를 만듭니다.이 때 자식 노드의 들여쓰기 간격도 정합니다.
 * [[m:PrettyPrint#breakable]]을 사용해 줄바꿈 해도 좋은 위치를 지정합니다.

同じノード内で呼ばれた breakable は、改行するならば全て同時に改行します。

 p2 = PrettyPrint.new('', 10)
 s = 'hello'
 p2.text(s)
 p2.group(p2.indent + s.size + 1) do
   p2.breakable
   p2.text('a')
   p2.breakable
   p2.text('b')
   p2.breakable
   p2.text('c')
 end
 p2.flush
 puts p2.output
 #=>
 hello
       a
       b
       c

=== References
Christian Lindig, Strictly Pretty, March 2000,
[[url:http://www.st.cs.uni-sb.de/~lindig/papers/pretty/strictly-pretty.html]]

Philip Wadler, A prettier printer, March 1998,
[[url:http://homepages.inf.ed.ac.uk/wadler/topics/language-design.html#prettier]]

= class PrettyPrint < Object

pretty printing 알고르짐을 담은 클래스입니다.
줄바꿈을 할 위치를 찾고 들여쓰기를 집어넣습니다.

이 클래스를 문자열로 다루는 게 기본 설정입니다.
또한 1바이트 문자가 출력 폭에서 1 컬럼을 차지한다고 가정합니다.
하지만 아래의 메소드에 적절한 인수가 주어지면
그렇지 않아도 사용할 수 있습니다.
 * [[m:PrettyPrint.new]]: 출력 버퍼 공백을 생성하는 블록이나 줄바꿈 객체를 지정할 수 있습니다.
 * [[m:PrettyPrint#text]]: 폭을 지정합니다.
 * [[m:PrettyPrint#breakable]] 
ですので、このクラスは以下のようなことにも応用が可能です。 * proportional font を使ったテキストの整形
 * 出力幅とバイト数が異なるような多バイト文字
 * 文字以外の整形

== Class Methods
--- new(output = '', maxwidth = 79, newline = "\n")               -> PrettyPrint
--- new(output = '', maxwidth = 79, newline = "\n"){|width| ...}  -> PrettyPrint

pretty printing를 위한 버퍼를 생성합니다.
output 출력이 되는 곳입니다.output은 << 메소드를 가지고 있어야만 합니다.
<< 메소드는
 * [[m:PrettyPrint#text]]의 첫번째 인수 obj 
 * [[m:PrettyPrint#breakable]]의 첫번째 인수 sep 
 * [[m:PrettyPrint.new]]의 세번째 인수 newline 
 * [[m:PrettyPrint.new]]에 넘겨진 블록을 평가한 결과 중
하나를 인수로서 넘겨받습니다.

블록이 넘겨지면 공백을 생성하기 위해 사용됩니다.블록은 생성하고자 하는 공백의 폭을 나타내는 정수를 인수로서 호출합니다.블록이 넘겨지지 않으면 공백을 생성하기 위해 {|width| ' ' * width}가 사용됩니다. 

@param output 출력되는 곳을 지정합니다.output은 << 메소드를 가지고 있어야만 합니다.

@param maxwidth 한 행의 최대폭을 지정합니다.단 줄바꿈이 불가능한 경우가 발생하면 실제 출력폭은 maxwidth를 넘을 수도 있습니다.

@param newline 줄바꿈에 사용됩니다.


--- format(output = '', maxwidth = 79, newline = "\n", genspace = lambda{|n| ' ' * n}) {|pp| ...}    -> object
PrettyPrint 객체를 생성하고, 극 객체를 인수로 블록을 평가합니다.
주어진 output을 리턴합니다.

아래와 같이 작동하며 간편히 사용할 수 있게 만들어졌습니다.

  begin
    pp = PrettyPrint.new(output, maxwidth, newline, &genspace)
    ...
    pp.flush
    output
  end

@param output 출력되는 곳을 지정합니다.output은 << 메소드를 가지고 있어야만 합니다.

@param maxwidth 한 행의 최대폭을 지정합니다.단 줄바꿈이 불가능한 경우가 발생하면
                실제 출력폭은 maxwidth를 넘을 수도 있습니다.

@param newline 줄바꿈에 사용됩니다.

@param genspace 공백 생성에 사용되는 [[c:Proc]] 객체를 지정합니다.
                생성하려는 공백의 폭을 나타내는 정수를 인수로서 호출합니다.

--- singleline_format(output = '', maxwidth = 79, newline = "\n", genspace = lambda{|n| ' ' * n}) {|pp| ...}    -> object

PrettyPrint 객체를 생성하고, 그 객체를 인수로서 블록을 평가합니다.
[[m:PrettyPrint.format]]와 비슷하지만 줄바꿈이 이루어지지 않습니다.

인수 maxwidth, newline와 genspace는 무시됩니다.ブロック中の breakable の実行は、
改行せずに text の実行であるかのように扱います。

@param output 출력되는 곳을 지정합니다.output은 << 메소드를 가지고 있어야만 합니다.

@param maxwidth 무시됩니다.

@param newline 무시됩니다.

@param genspace 무시됩니다.

== Instance Methods
--- text(obj)           -> ()
--- text(obj, width = obj.length)    -> ()

obj を width カラムのテキストとして自身に追加します。

@param obj 自身に追加するテキストを文字列で指定します。

@param width obj のカラムを指定します。指定されなかった場合、obj.length が利用されます。

--- breakable(sep = ' ')     -> ()
--- breakable(sep, width = sep.length)    -> ()

「必要ならここで改行出来る」ということを自身に通知します。
もしその位置で改行されなければ、width カラムのテキスト sep が出力の際にそこに挿入されます。

@param sep 改行が起きなかった場合に挿入されるテキストを文字列で指定します。

@param width テキスト sep は width カラムであると仮定されます。指定されなければ、
             sep.length が利用されます。例えば sep が多バイト文字の際に指定する必要があるかも知れません。

--- nest(indent) {...}     -> ()

自身の現在のインデントを indent だけ増加させてから、ブロックを実行し、元に戻します。

@param indent インデントの増加分を整数で指定します。

--- group(indent = 0, open_obj = '', close_obj = '', open_width = open_obj.length, close_width = close_obj.length){...}      -> ()

与えられたブロックを実行します。
ブロック内で自身に追加される文字列やオブジェクトは、1行にまとめて表示しても
よい同じグループに属すると仮定されます。

もう少し詳しく説明します。pretty printing アルゴリズムはインデントと改行を、
ツリー構造を作ることによって決定します。そして、group メソッドは子ノードの作成と
子ノードのインデントの深さの決定を担当します。

同じノード内で呼ばれた breakable は、改行するならば全て同時に改行します。

@param indent グループのインデントの深さを指定します。

@param open_obj 指定された場合、self.text(open_obj, open_width) がブロックが
                実行される前に呼ばれます。開き括弧などを出力するのに使用されます。

@param close_obj 指定された場合、self.text(close_obj, close_width) がブロックが
                 実行された後に呼ばれます。閉じ括弧などを出力するのに使用されます。

@param open_width open_obj のカラムを指定します。

@param close_width close_obj のカラムを指定します。

--- flush     -> ()

버퍼에 저장된 데이터를 출력합니다.

--- first?-> bool

#@since 1.8.2
이 메소드는 더 이상 사용되지 않습니다.
#@end

現在のグループで first? に対する最初の呼び出しかどうかを判定する
述語です。これはカンマで区切られた値を整形するのに有用です。

  pp.group(1, '[', ']') {
    yyy.each {|yyy|
      unless pp.first?        pp.text ','
        pp.breakable
      end
      ... pretty printing yyy ...
    }
  }

--- output    -> object

self의 output을 리턴합니다.

--- maxwidth    -> Integer

self의 폭을 리턴합니다.

--- newline    -> String

self의 줄바꿈문자를 리턴합니다.

--- genspace    -> Proc

공백을 생성하는 Proc를 리턴합니다.

--- indent    -> Integer

현재 들여쓰기의 정도를 리턴합니다.
