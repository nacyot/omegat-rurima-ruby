#@since 1.9.1

[[c:Gem::Specification]] のインスタンスから Gem パッケージを作成するためのライブラリです。

= class Gem::Builder < Object
include Gem::UserInteraction

[[c:Gem::Specification]] のインスタンスから Gem パッケージを作成するためのクラスです。

== Singleton Methods

--- new(spec) -> Gem::Builder

주어진 [[c:Gem::Specification]]의 객체에 따라
[[c:Gem::Builder]] 객체를 생성합니다.

@param spec [[c:Gem::Specification]] 객체를 지정합니다.


== Instance Methods

--- build -> String

스펙에 따라 Gem을 생성합니다.

@return 생성된 파일명을 리턴합니다.

--- success -> String

Gem 생성에 성공하면 출력하는 메시지를 리턴합니다.

#@end

