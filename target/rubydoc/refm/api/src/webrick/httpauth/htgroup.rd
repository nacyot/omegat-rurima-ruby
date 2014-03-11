Apache で証認に使用するユーザグループの一覧が格納されているテキストファイルを
読み書きする機能を提供するライブラリです。

 * [[url:http://httpd.apache.org/docs/2.2/mod/mod_authz_groupfile.html#authgroupfile]]

= class WEBrick::HTTPAuth::Htgroup < Object

Apache で証認に使用するユーザグループの一覧が格納されているテキストファイルを読み書きするためのクラスです。


== Class Methods

--- new(path) -> WEBrick::HTTPAuth::Htgroup

객체를 초기화합니다.

@param path 파일명을 지정합니다.


== Instance Methods

--- reload
#@# -> discard
파일을 다시 읽습니다.

--- flush(path = nil) -> ()

파일에 기록합니다.

@param path 파일명을 지정합니다.

--- members(group) -> [String]

[[m:WEBrick::HTTPAuth::Htgroup#reload]]을 호출하고 group에 속해있는 구성원의 목록을 리턴합니다.

@param group 그룹을 지정합니다.

--- add(group, members)
#@# -> discard

group에 members를 추가합니다.

@param group 멤버를 추가할 group을 지정합니다.

@param members 추가할 구성원을 배열로 지정합니다.

