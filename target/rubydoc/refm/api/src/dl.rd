*.dll이나 *.so 등 다이나믹 링크 라이브러리를 다루는 라이브러리입니다.

#@until 1.9.1

#@include(dl/dl1/dl.rd)
#@include(dl/dl1/DL)
#@include(dl/dl1/Handle)
#@include(dl/dl1/PtrData)
#@include(dl/dl1/Symbol)

#@else

#@include(dl/dl2/dl.rd)
#@include(dl/dl2/DL)
#@include(dl/dl2/Handle)
#@include(dl/dl2/CPtr)
#@include(dl/dl2/CFunc)

#@end

