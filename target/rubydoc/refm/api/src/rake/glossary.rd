
: action / 액션
  タスクを機能させるためのコードです。  Rakefile 内のアクションはコードブロックで指定されます。(たいていは do/end ブロックで区切られます)
: execute / 実行
  あるタスクが実行されると、それに含まれるアクションは定義された順番通りに全て評価されます。  invoke と違うのは execute はアクションを常に実行する点です (事前タスクを呼び出したり実行したりしません)。: file task (FileTask) / ファイルタスク (FileTask)
  ファイルとはファイルを作成するためのものです。(同じ名前のタスクもあります)
  ファイルタスクは呼び出されると以下の条件のいずれかを満たす場合のみタスクを実行します。     (1) 関連するファイルが存在しない場合
     (2) 事前タスクで作成したファイルの方が新しい場合
  普通のタスクを事前タスクに持つファイルタスクが常に実行されるのは、
  普通のタスクが現在時刻をタイムスタンプとしているためです。: invoke / 呼び出し
  あるタスクが呼び出されると、最初にそのタスクが以前呼び出されたことがあるかチェックします。  呼び出されたことがあれば何もしません。そのタスクが初めて呼び出された場合は、そのタスクの
  事前タスクを一つずつ呼び出します。最終的に、このタスクのアクションを実行する必要があるかどうか
  チェックします。このタスクを実行する必要があれば、アクションを実行します。  NOTE: このタスクを実行する必要が無い場合も事前タスクは呼び出されています。この振る舞いは将来変更予定です。: prerequisites / 事前タスク
  全てのタスクはゼロ個以上の事前タスクを持ちます。  タスク T に対する事前タスク P は必ずタスク T よりも前に呼び出されます。: rule / ルール
  タスクが明確に定義されていない場合に、ルールはタスクを合成するレシピになります。  ルールはふつうファイルタスクを合成します。: task (Task) / タスク (Task)
  Rake ファイルにおける基本単位です。  タスクは名前と、事前タスクと、実行するアクションのリストを持ちます。
