#@until  1.9.1
each 以外のメソッドも enumerate できるようにするライブラリです。

#@since 1.8.7
このライブラリは後方互換性のためにのみ提供されています。

ruby-1.8.7 より [[c:Enumerable::Enumerator]] は組み込みクラスになりました。
require 'enumerator' を実行しても false を返すだけで何もしません。

#@else
#@include(_builtin/Enumerable__Enumerator)

#@since 1.8.4
= reopen Enumerable


== Instance Methods

--- each_slice(n) {|list| ... } -> nil

n 요소씩 블록에 인자로 넘겨 블록을 평가합니다. (예: 배열이 [1,2,3,4], n=2 이면 [1,2], [3,4])要素数が n で割り切れないときは、
最後の回だけ要素数が減ります。

nil을 반환힙니다.

@paran n 한 번에 블록에 넘길 개수를 지정합니다.

예:

  (1..10).each_slice(3) {|a| p a}
      # => [1, 2, 3]
      #    [4, 5, 6]
      #    [7, 8, 9]
      #    [10]

@see [[m:Enumerable#each_cons]]

--- each_cons(n) {|list| ... } -> nil

요소가 중복되도록 n개씩 
블록에 넘겨 평가하니다. (예 : [1,2,3,4] 배열, n=2이면 [1,2],[2,3],[3,4])

nil을 반환힙니다.

@paran n 한 번에 블록에 넘길 개수를 지정합니다.

예:

  [1, 2, 3, 4, 5].each_cons(3) {|a| p a }
      # => [1, 2, 3]
      #    [2, 3, 4]
      #    [3, 4, 5]

@see [[m:Enumerable#each_slice]]

--- enum_slice(n) -> Enumerable::Enumerator

n 要素ずつ繰り返す Enumerator を返します。
Enumerable::Enumerator.new(self, :each_slice, n) と同じです。

@paran n 한 번에 블록에 넘길 개수를 지정합니다.
@see [[m:Enumerable#each_cons]]

--- enum_cons(n) -> Enumerable::Enumerator

要素を重複ありで n 要素ずつに区切って繰り返す Enumerator を返します。

Enumerable::Enumerator.new(self, :each_cons, n) を返します。

@paran n 한 번에 블록에 넘길 개수를 지정합니다.
@see [[m:Enumerable#each_slice]]

--- enum_with_index -> Enumerable::Enumerator

要素とそのインデックスに対して繰り返す Enumerator を返します。
Enumerable::Enumerator.new(self, :each_with_index) と同じです。

@see [[m:Enumerable#each_with_index]]

#@end
#@end
#@end
