" sB&R - Simple Build&Run
" Maintainer:  Jorengarenar <https://joren.ga>

if exists('g:loaded_sBnR') | finish | endif
let s:cpo_save = &cpo | set cpo&vim

if !exists("$TMPDIR")
  let $TMPDIR = "/tmp"
endif

if !exists("$BROWSER")
  let $BROWSER = "xdg-open"
endif

if !exists("g:sBnR_compilers")
  let g:sBnR_compilers = {
        \ "ada"      : "gnat",
        \ "c,cpp"    : "gcc",
        \ "go"       : "go",
        \ "haskell"  : "ghc",
        \ "html"     : "tidy",
        \ "java"     : "javac",
        \ "perl"     : "perl",
        \ "php"      : "php",
        \ "plaintex" : "tex",
        \ "python"   : "pyunit",
        \ "rust"     : "rustc",
        \ "tex"      : "tex",
        \}
endif

if !exists("g:sBnR_makeprgs")
  let g:sBnR_makeprgs = {
        \ "ada"      : [ 0, "gnatmake % && gnatclean -c %" ],
        \ "asm"      : [ 0, "as -o %:t:r.o % && ld -s -o %:t:r %:t:r.o && rm %:t:r.o" ],
        \ "basic"    : [ 1, "vintbas %" ],
        \ "c"        : [ 0, "gcc -std=gnu99 -g % -o %:t:r" ],
        \ "cpp"      : [ 0, "g++ -std=gnu++14 -g % -o %:t:r" ],
        \ "go"       : [ 0, "go build" ],
        \ "haskell"  : [ 0, "ghc -o %:t:r %; rm %:t:r.hi %:t:r.o" ],
        \ "html"     : [ 0, "tidy -quiet -errors --gnu-emacs yes %" ],
        \ "java"     : [ 0, "javac -d $TMPDIR/java %:p && jar cvfe %:t:r.jar %:t:r -C $TMPDIR/java ." ],
        \ "lisp"     : [ 1, "clisp %" ],
        \ "lua"      : [ 1, "lua %" ],
        \ "nasm"     : [ 0, "nasm -f elf64 -g % && ld -g -o %:t:r %:t:r.o && rm %:t:r.o" ],
        \ "perl"     : [ 1, "perl %" ],
        \ "plaintex" : [ 0, "xetex -output-directory=$TMPDIR/TeX -interaction=nonstopmode % 1>&2 && mv $TMPDIR/TeX/%:t:r.pdf ./" ],
        \ "python"   : [ 1, "python %" ],
        \ "rust"     : [ 1, "rustc %" ],
        \ "sh"       : [ 1, "chmod +x %:p && %:p" ],
        \ "tex"      : [ 0, "xelatex -output-directory=$TMPDIR/TeX -interaction=nonstopmode % 1>&2 && mv $TMPDIR/TeX/%:t:r.pdf ./" ],
        \ "xhtml"    : [ 0, "tidy -asxhtml -quiet -errors --gnu-emacs yes %" ],
        \}
endif

if !exists("g:sBnR_runCmds")
  let g:sBnR_runCmds = {
        \ "html"     : [ 1, "$BROWSER %:p" ],
        \ "java"     : [ 0, "java -jar %:t:r.jar" ],
        \ "markdown" : [ 0, "grip --quiet -b %" ],
        \ "plaintex" : [ 2, "zathura %:p:h/%:t:r.pdf" ],
        \ "tex"      : [ 2, "zathura %:p:h/%:t:r.pdf" ],
        \ "xhtml"    : [ 1, "$BROWSER %:p" ],
        \}
endif

command! -nargs=* RunProg     call sBnR#run(expand('%:t:r'), "<args>")
command! -nargs=* Build       call sBnR#build("<args>")
command! -nargs=* BuildAndRun call sBnR#buildAndRun()

command! -nargs=+       AddCompiler call sBnR#addCompiler(<f-args>)
command! -nargs=+ -bang AddMakeprg  call sBnR#addMakeprg(<bang>0, <f-args>)
command! -nargs=+ -bang AddRunCmd   call sBnR#addRunCmd(<bang>0, <f-args>)

if get(g:, "sBnR_mappings", 1)
  nnoremap <F7>  :Build<CR>
  nnoremap <F8>  :RunProg<CR>
  nnoremap <F9>  :BuildAndRun<CR>
  nnoremap <F10> :w <bar> make<CR>
endif

let g:loaded_sBnR = 1
let &cpo = s:cpo_save | unlet s:cpo_save
