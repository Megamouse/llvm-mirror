; RUN: llvm-as < %s | opt -globalsmodref-aa -markmodref | llvm-dis | grep readnone | count 2

define i32 @f() {
entry:
	%tmp = call i32 @e( )		; <i32> [#uses=1]
	ret i32 %tmp
}

declare i32 @e() readnone
