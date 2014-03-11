require optparse

[[m:OptionParser#on]]에서 사용할 수 있는 클래스에 [[c:Date]]와 [[c:DateTime]]를
추가합니다.
옵션의 인수는 각각의 클래스 인스턴스로 변환되고
[[m:OptionParser#on]] 블록에 넘겨집니다.

 require 'optparse/date'
 opts = OptionParser.new
 
 opts.on("-d DATE", Date){|d|
   p d.to_s #=> 2000-01-01
 }
 opts.parse! 
 # ruby command -d 2000/1/1
