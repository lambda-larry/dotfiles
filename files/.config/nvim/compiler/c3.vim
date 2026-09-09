if exists("current_compiler")
  finish
endif
let current_compiler = "c3"

let s:cpo_save = &cpo
set cpo&vim

setlocal errorformat=(%f:%l:%c)\ %trror:\ %m
setlocal errorformat+=(%f:%l:%c)\ %tarning:\ %m
setlocal errorformat+=(%f:%l:%c)\ %tote:\ %m

let &cpo = s:cpo_save
unlet s:cpo_save
