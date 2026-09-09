if exists("current_compiler")
  finish
endif
let current_compiler = "odin"

let s:cpo_save = &cpo
set cpo&vim

CompilerSet errorformat&
CompilerSet errorformat+=
      \%f(%l:%c)\ %trror:\ %m,
      \%f(%l:%c)\ %m,


let &cpo = s:cpo_save
unlet s:cpo_save
