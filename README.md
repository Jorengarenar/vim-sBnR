# sB&R - Simple Build&Run for Vim

Using [`compiler`](https://vimhelp.org/quickfix.txt.html#:compiler),
[`makeprg`](https://vimhelp.org/options.txt.html#%27makeprg%27)
and [`term`](https://vimhelp.org/term.txt.html), builds and runs your code.

Suitable for small and simple, programs, which you want to test immediately
without the need of Makefile or typing bang command over and over again.

## Why?

Let's assume you are writing some C code. Instead of typing:
```vim
:!gcc % -o %< && ./%<
```
every time or creating an awkward mapping, you can add:
```vim
AddMakeprg c gcc % -o %<
```
to your _vimrc_ and press <kbd>F9</kbd> to compile, run and list eventual
compilation errors in QuickFix window!

## Installation

#### [minPlug](https://github.com/Jorengarenar/minPlug):
```vim
MinPlug Jorengarenar/vim-sBnR
```

#### [vim-plug](https://github.com/junegunn/vim-plug):
```vim
Plug 'Jorengarenar/vim-sBnR'
```

#### Vim's packages
```bash
cd ~/.vim/pack/plugins/start
git clone git://github.com/Jorengarenar/vim-sBnR.git
```

## Commands
* `Build {args}` - builds program based on source file, if there is no `g:sBnR_makeprgs[&ft]`, then uses `make %:t:r`
* `RunProg {args}` - runs code in `:term` (checks: `g:sBnR_runCmds`, `%:t:r` executable, `g:sBnR_makeprgs[&ft]` is interpreter)
* `BuildAndRun {args}` - first builds, then if no errors runs your code (interpreters are executed only once)
* `AddCompiler {filetype} {compiler}`
* `AddMakeprg[!] {filetype} {makeprg}` - if `!` is passed, `makeprg` is marked as interpreter
* `AddRunCmd[!] [mode] {filetype} {cmd}` - if `!` is passed, `[mode]` is read. Possible values: "detach", "close"

## Mappings
* <kbd>F7</kbd>  `:Build`
* <kbd>F8</kbd>  `:RunProg`
* <kbd>F9</kbd>  `:BuildAndRun`
* <kbd>F10</kbd> `:w <bar> make<CR>`

## Configuration
* `g:sBnR_compilers` - dictionary with compilers ([`:h compiler`](https://vimhelp.org/quickfix.txt.html#:compiler)), example:

```vim
let g:sBnR_compilers = {
  \ "c,cpp"  : "gcc",
  \ "python" : "pyunit",
  \}
```

* `g:sBnR_makeprgs` - dictionary with makeprgs. Structure:`filetype: [ isInterpreter, "command" ]`. Example:

```vim
let g:sBnR_makeprgs = {
      \ "cpp"    : [ 0, "g++ -std=gnu++14 -g % -o %:t:r" ],
      \ "python" : [ 1, "python %" ],
      \}
```
* `g:sBnR_runCmds` - dictionary with commands to run with `:Run`, example:
```vim
let g:sBnR_runCmds = {
      \ "html" : [ 1, "$BROWSER %:p" ],
      \ "java" : [ 0, "java -jar %:t:r.jar" ],
      \}
```

* `g:sBnr_mappings` - if set to 0, don't use default mappings
* `TMPDIR` - environment variable, directory for temporary files, default `/tmp`
* `BROWSER` - environment variable, web browser, default `xdg-open`

## Defaults

#### `makeprg`

FileType | Command
---------|--------
Ada      | `gnatmake % && gnatclean -c %`
ASM      | `as -o %:t:r.o % && ld -s -o %:t:r %:t:r.o && rm %:t:r.o`
BASIC    | `vintbas %`
C        | `gcc -std=gnu99 -g % -o %:t:r`
C++      | `g++ -std=gnu++14 -g % -o %:t:r`
Go       | `go build`
Haskell  | `ghc -o %:t:r %; rm %:t:r.hi %:t:r.o`
HTML     | `tidy -quiet -errors --gnu-emacs yes %`
Java     | `javac -d $TMPDIR/java %:p && jar cvfe %:t:r.jar %:t:r -C $TMPDIR/java .`
Lisp     | `clisp %`
Lua      | `lua %`
NASM     | `nasm -f elf64 -g % && ld -g -o %:t:r %:t:r.o && rm %:t:r.o`
Perl     | `perl %`
TeX      | `xetex -output-directory=$TMPDIR/TeX -interaction=nonstopmode % 1>&2 && mv $TMPDIR/TeX/%:t:r.pdf ./`
Python   | `python %`
Rust     | `rustc %`
Shell    | `chmod +x %:p && %:p`
LaTeX    | `xelatex -output-directory=$TMPDIR/TeX -interaction=nonstopmode % 1>&2 && mv $TMPDIR/TeX/%:t:r.pdf ./`
xHTML    | `tidy -asxhtml -quiet -errors --gnu-emacs yes %`


#### `runCmd`

FileType | Command
---------|--------
HTML     | `$BROWSER %:p`
Java     | `java -jar %:t:r.jar`
Markdown | `grip --quiet -b %`
TeX      | `zathura %:p:h/%:t:r.pdf`
LaTeX    | `zathura %:p:h/%:t:r.pdf`
xHTML    | `$BROWSER %:p`


#### `compiler`

FileType | Value
---------|--------
Ada      | `gnat`
C,C++    | `gcc`
Go       | `go`
Haskell  | `ghc`
HTML     | `tidy`
Java     | `javac`
Perl     | `perl`
PHP      | `php`
TeX      | `tex`
Python   | `pyunit`
Rust     | `rustc`
TeX      | `tex`
