=  과거의 유산

아래에서 언급한 변수명, 메소드명, 객체명은 오래된 이름입니다.
사용하면 경고가 나오거나 어느 날 갑자기 사라질지도 모릅니다.

== 과거의 메소드

: String#~
: String#=~

  ~str은 1.8 이후 삭제되었습니다.또한 str =~ str 은 예외를 발생시킵니다.
   

: Object#id

  1.8에선 경고를 출력합니다.대신 Object#object_id를 사용하세요.

    $ ruby-1.8.0 -we 'p Object.new.id'
    -e:1: warning: Object#id will be deprecated; use Object#object_id
    537752050

: Object#type

  1.8에선 경고를 출력합니다.대신 Object#class를 사용하세요.

    $ ruby-1.8.0 -we 'p Object.new.type'
    -e:1: warning: Object#id will be deprecated; use Object#object_id
    Object

: Object#to_a

  Object#to_a는 없어질 예정입니다.Kernel#Array를 사용해주세요.

    $ ruby-1.8.0 -e 'p Object.new.to_a'
    -e:1: warning: default `to_a' will be obsolete
    [#<Object:0x401ae3e4>]

    $ ruby-1.8.0 -we 'p Array(Object.new)'
    [#<Object:0x401ae3d0>]

: FileTest.exists?

  삼인칭 단수 현재시제에 s를 붙이지 않는 명명규칙에 반하므로 사용하지 않는 걸 권장합니다.
  ((<FileTest/FileTest.exist?>)) 을 사용해주세요.
  → ((<rubyist:1194>))

: indexes, indicies (((<Array>)), ((<Hash>)), ((<ENV>)))
  ((<version 1.7|ruby 1.7 feature>)) 에서, 사용하면

    warning: Array#indexes is deprecated; use Array#select

  라는 경고를 출력합니다.

  * indexの複数形はindexesとindicesの両方があるのが混乱のも
    と(両方提供してるけど)

  * index(値を指定してそのインデックスを得る)メソッド
    とindexes(インデックスを複数指定して対応する値の配列を得
    る)は同じ単語なのに意味が逆というのは致命的

  ということからだそうです((<ruby-dev:16084>))。

  ((<ruby-talk:10830>)), ((<ruby-talk:11066>)), ((<ruby-dev:16082>)) 
  などで議論が起こっていました。

  警告メッセージにあるように select がその候補になっています。

  ((<ruby 1.8 feature>)): その後、((<Array/values_at>)) が採用されまし
  た((<ruby-dev:20153>))。

: Array#filter
  Array#collect!に置き換えられました。

  このメソッドを使用すると警告メッセージが出ます。  (1.8 ではこのメソッドはなくなりました。)

: Time.times
  ((<Process.times|Process>)) に移動しました。  1.8 で (({Time.times})) を使うと警告されます。

    $ ruby-1.8.0 -e 'p Time.times'
    -e:1: warning: obsolete method Time::times; use Process::times
    #<struct Struct::Tms utime=0.0, stime=0.0, cutime=0.0, cstime=0.0>

: iterator?  メソッドに付いたブロックは必ずしも繰り返さないので、
  ブロック付きメソッドをイテレータと呼ぶのは不適切です。  今後は block_given?を使ってください。

  が、イテレータという用語自体は依然使われ続けていますし、
  この関数を使っても警告はされません。

: ((<ObjectSpace>)).add_finalizer
: ((<ObjectSpace>)).remove_finalizer
: ((<ObjectSpace>)).call_finalizer
: ((<ObjectSpace>)).finalizers

  Ruby 1.8 ではこれらのメソッドを使うと警告されます。  これらのメソッドは以前 final ライブラリで提供されていたメソッド

    * ObjectSpace.define_finalizer
    * ObjectSpace.undefine_finalizer

  が組み込みになったので不要です。  従って、今後は final ライブラリも obsolete です。

== 過去のクラス

: NotImplementError
  ((<NotImplementedError>))の旧称。  ((<version 1.8|ruby 1.8 feature>)) では既に削除されています。

: MatchingData
  ((<MatchData>))の旧称

== 過去の組み込み変数、定数

: (({$~})), (({$!})) 等、全般
  なくなることはないと思いますが、基本的に使わないのが
  最近のスタイルです。少なくとも今後増えることはありません。  無理に使うのをやめる必要はありませんが、代替になる記法が
  ある場合はそちらを使うほうがきれいになることが多々あります。  例えば (((<Regexp>)).last_match や ((<Process>)).waitpid2、
  rescue => var などです。

  ただし (({$=})) (文字列の比較で大文字小文字を無視するか決める)
  だけは obsolete であると明言されました (((<ruby-dev:12978>)))。  Ruby 1.8 では警告が出ます。

    $ ruby-1.8.0 -e '$= = false'
    -e:1: warning: modifying $= is deperecated

  Ruby 1.8 では既に文字列のハッシュ値が $= の値に依存しなく
  なっています。((<ruby-bugs-ja:PR#61>))

    p "foobar".hash
    $= = true
    p "foobar".hash

    # Ruby 1.6.8 の結果
    594908901
    -24977883

    # Ruby 1.8.0 の結果
    594908901
    594908901

: $defout, $deferr

  version 1.8 以降、$stdout, $stderr が代わりに利用されるようになりま
  した。version 1.8 では、$stdout, $stderr, $stdin にリダイレクトの効
  果はなくなっています。($deferr は version 1.8.0 preview で定義された
  変数です)。

  $defout, $deferr にオブジェクトを代入すると警告が出力されます。

: TRUE, FALSE, NIL

  はるか昔のバージョンの Ruby では true false nil がなかったので
  代わりに定数が使われていたのですが、今となっては不要です。  速やかに移行してください。

: VERSION, RELEASE_DATE, PLATFORM

  Ruby 1.9 では廃止されました。それぞれ「RUBY_」を前置した
  RUBY_VERSION, RUBY_RELEASE_DATE, RUBY_PLATFORM を使ってください。

== その他過去のもの

: 正規表現の //p オプション

  1.6 では警告されます。  1.8 では廃止されました。

  入れ代わりに m オプションが導入されましたが
  これは p オプションとは意味がまったく違います。  p はメタ文字「.」「^」「$」の意味を変えるオプションでした。  m は「.」を改行にマッチするように変えるだけです。

  p オプションが廃止されたのは以下の理由からです。

    * 定義が複雑である
    * //m と 正規表現 \A \Z を使って表現可能である
    * p と m を両方提供するにはフラグのビット数が足りない

  詳細は ((<ruby-list:22483>)) を参照してください。
