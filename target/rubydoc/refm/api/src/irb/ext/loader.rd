load または require 時の irb のファイル読み込み機能(irb_load、
irb_require)を定義するサブライブラリです。

이 라이브러리에 정의된 메소드는 직접 사용할 수 없습니다.[[lib:irb/cmd/load]] や [[lib:irb/ext/use-loader]] から呼び出
されます。

= class IRB::LoadAbort < Exception

irb 中で require などを中断した場合に発生する例外です。

= module IRB::IrbLoader

load または require 時の irb のファイル読み込み機能(irb_load、
irb_require)を定義するモジュールです。

사용자가 직접 사용해선 안 됩니다.
