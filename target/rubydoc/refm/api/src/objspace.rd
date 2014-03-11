このライブラリは [[c:ObjectSpace]] を拡張してオブジェクトやメモリ管理についての
統計情報を取得するメソッドをいくつか追加します。

MRI の実装について詳しくない一般のユーザはこのライブラリを使ってはいけません。
このライブラリは、メモリプロファイラの開発者や MRI がどのようにメモリを使用するか
知りたい MRI 開発者が使用します。

= reopen ObjectSpace

== Module Functions

--- count_objects_size(result_hash = nil) -> Hash

型ごとのオブジェクトサイズをバイト単位で格納したハッシュを返します。

@param result_hash 리턴값을 받기 위한 해쉬를 지정합니다.생략하면
                   새로운 해쉬를 생성합니다.result_hash의 내용은 
                   덮어쓰기 됩니다.プローブ効果を避けるために使用します。

戻り値の内容は完全ではない事に注意してください。この内容はあくまでもヒ
ントとして扱う必要があります。特に T_DATA の合計値は正しくないでしょう。

예:

  ObjectSpace.count_objects_size
  # => {:TOTAL=>1461154, :T_CLASS=>158280, :T_MODULE=>20672, :T_STRING=>527249, ...}

@raise TypeError result_hash にハッシュ以外を指定した時に発生します。

리턴값은 루비 인터프리터에 따라 다릅니다.이후 버전에서 변경될 가능성이 있습니다.

이 메소드는 C Ruby에서만 사용할 수 있습니다.

--- memsize_of(obj) -> Integer

obj が消費するメモリ使用量をバイト単位で返します。

@param obj 임의의 객체를 지정합니다.

戻り値の内容は完全ではない事に注意してください。この内容はあくまでもヒ
ントとして扱う必要があります。特に T_DATA の値は正しくないでしょう。

이 메소드는 C Ruby에서만 사용할 수 있습니다.

#@since 1.9.3
--- memsize_of_all(klass = nil) -> Integer

すべての生存しているオブジェクトが消費しているメモリ使用量をバイト単位
で返します。

@param klass 指定したクラスのインスタンスのメモリ使用量を返します。省略
             した場合はすべてのクラスのインスタンスのメモリ使用量を返し
             합니다.

本メソッドは以下のような Ruby のコードで定義できます。

  def memsize_of_all klass = false
    total = 0
    ObjectSpace.each_object{|e|
      total += ObjectSpace.memsize_of(e) if klass == false || e.kind_of?(klass)
    }
    total
  end

戻り値の内容は完全ではない事に注意してください。この内容はあくまでもヒ
ントとして扱う必要があります。特に T_DATA の値は正しくないでしょう。

また、同様に戻り値の内容は malloc されたメモリの合計でもない事に注意し
てください。

이 메소드는 C Ruby에서만 사용할 수 있습니다.
#@end

--- count_nodes(result_hash = nil) -> Hash

ノードの種類ごとの数を格納したハッシュを返します。

@param result_hash 리턴값을 받기 위한 해쉬를 지정합니다.생략하면
                   새로운 해쉬를 생성합니다.result_hash의 내용은 
                   덮어쓰기 됩니다.プローブ効果を避けるために使用します。

@raise TypeError result_hash にハッシュ以外を指定した時に発生します。

本メソッドは普通の Ruby プログラマ向けのメソッドではありません。パフォー
マンスやメモリ管理に興味のある C Ruby の開発者向けのものです。

예:

  ObjectSpace.count_nodes
  # => {:NODE_METHOD=>2027, :NODE_FBODY=>1927, :NODE_CFUNC=>1798, ...}

리턴값은 루비 인터프리터에 따라 다릅니다.이후 버전에서 변경될 가능성이 있습니다.

이 메소드는 C Ruby에서만 사용할 수 있습니다.

--- count_tdata_objects(result_hash = nil) -> Hash

T_DATA の種類ごとにオブジェクトの数を格納したハッシュを返します。

@param result_hash 리턴값을 받기 위한 해쉬를 지정합니다.생략하면
                   새로운 해쉬를 생성합니다.result_hash의 내용은 
                   덮어쓰기 됩니다.プローブ効果を避けるために使用します。

@raise TypeError result_hash にハッシュ以外を指定した時に発生します。

本メソッドは普通の Ruby プログラマ向けのメソッドではありません。パフォー
マンスに興味のある C Ruby の開発者向けのものです。

예:

  ObjectSpace.count_tdata_objects
  # => {RubyVM::InstructionSequence=>504, :parser=>5, :barrier=>6,
        :mutex=>6, Proc=>60, RubyVM::Env=>57, Mutex=>1, Encoding=>99,
        ThreadGroup=>1, Binding=>1, Thread=>1, RubyVM=>1, :iseq=>1,
        Random=>1, ARGF.class=>1, Data=>1, :autoload=>3, Time=>2}

現在のバージョンでは、戻り値のキーはクラスオブジェクトかシンボルのオブ
ジェクトです。

普通の参照可能なオブジェクトの場合、キーはクラスオブジェクトです。それ
以外の内部的なオブジェクトの場合、キーはシンボルです。シンボルの値は
rb_data_type_struct に格納された名前が使用されます。

리턴값은 루비 인터프리터에 따라 다릅니다.이후 버전에서 변경될 가능성이 있습니다.

이 메소드는 C Ruby에서만 사용할 수 있습니다.

#@since 2.0.0
--- reachable_objects_from(obj) -> Array | nil

obj から到達可能なすべてのオブジェクトを返します。マーク不能なオブジェ
クトを指定した場合は nil を返します。本メソッドを使う事でメモリリークの
調査が行えます。

  # 配列クラス(Array)と 'a'、'b'、'c' に到達可能。  ObjectSpace.reachable_objects_from(['a', 'b', 'c'])
  # => [Array, 'a', 'b', 'c']

obj が 2 つ以上の同じオブジェクト x への参照を持つ場合、戻り値に含まれ
るオブジェクト x は 1 つだけです。

  # 配列クラス(Array)と v に到達可能。  ObjectSpace.reachable_objects_from([v = 'a', v, v])
  # => [Array, 'a']

  # 配列クラス(Array)と 3 つの異なる 'a' オブジェクトに到達可能。  ObjectSpace.reachable_objects_from(['a', 'a', 'a'])
  # => [Array, 'a', 'a', 'a']

obj にマーク不能なオブジェクト(true、false、nil、[[c:Symbol]]、
[[c:Fixnum]]、Flonum(即値の [[c:Float]] オブジェクト))を指定した場合は
nil を返します。

  # 1 はマーク不能
  ObjectSpace.reachable_objects_from(1)
  # => nil

obj が内部でオブジェクトへの参照を持つ場合、
ObjectSpace::InternalObjectWrapper オブジェクトが戻り値に含まれます。こ
のオブジェクトは obj が内部で持っているオブジェクトを持ちます。内部のオ
ブジェクトの型を確認する場合は ObjectSpace::InternalObjectWrapper#type
を参照してください。:T_CLASS のような [[c:Symbol]] を返します。

obj が ObjectSpace::InternalObjectWrapper オブジェクトであった場合、そ
のオブジェクトから参照される全てのオブジェクトを返します。

이 메소드는 C Ruby에서만 사용할 수 있습니다.

@see [[url:http://www.atdot.net/~ko1/diary/201212.html#d8]],
     [[url:http://www.atdot.net/~ko1/diary/201212.html#d9]]
#@end
