#@since 1.9.1
require rdoc
require rdoc/parser/simple
require rdoc/parser/ruby
require rdoc/parser/c
#@until 1.9.2
require rdoc/parser/f95
#@end
#@since 1.9.2
#@until 1.9.3
require rdoc/parser/perl
#@end
#@end
require rdoc/stats
require fileutils
#@else
require rdoc/parsers/parse_simple
require rdoc/parsers/parse_rb
require rdoc/parsers/parse_c
require rdoc/parsers/parse_f95
require ftools
#@end
require rdoc/options
#@until 1.9.2
require rdoc/diagram
#@end
require find
require time

#@since 1.9.1
rdoc 명령어를 위한 서브라이브러리입니다.
#@else
rdoc 명령어를 위한 라이브러리입니다.
#@end

#@include(RDoc__RDoc)
#@until 1.9.1
#@include(RDoc__Stats)
#@include(RDoc)
#@end
