require rubygems

[[c:Gem::Command]] で使用する --local, --remote オプションのためのモジュールを
定義したライブラリです。

= module Gem::LocalRemoteOptions

[[c:Gem::Command]] で使用する --local, --remote オプションのためのモジュールです。

== Public Instance Methods

--- accept_uri_http
#@# -> discard
HTTP の URI を扱えるようにするためのメソッドです。

--- add_bulk_threshold_option
#@# -> discard
オプション --bulk-threshold を追加します。

--- add_local_remote_options
#@# -> discard
オプション --local, --remote, --both を追加します。

--- add_proxy_option
#@# -> discard
オプション --http-proxy を追加します。

--- add_source_option
#@# -> discard
オプション --source を追加します。

--- add_update_sources_option
#@# -> discard
オプション --update-source を追加します。

--- both?-> bool

ローカルとリモートの情報を両方とも取得する場合は真を返します。그렇지 않으면 false를 리턴합니다.

--- local?-> bool

ローカルの情報を取得する場合は真を返します。그렇지 않으면 false를 리턴합니다.

--- remote?-> bool

リモートの情報を取得する場合は真を返します。그렇지 않으면 false를 리턴합니다.

