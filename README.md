# sR&B - Simple Build&Run for Vim

Using `compiler`, `makeprg` and `term`, builds and runs your source code.

Suitable for small, simple, one file programs, which you want to test
immediately without the need of Makefile or typing bang command over and over again.

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
* [minPlug](https://github.com/Jorengarenar/minPlug)
```none
MinPlug Jorengarenar/vim-sRnB
```
* vim-plug
```vim
Plug 'Jorengarenar/vim-sRnB'
```

## Commands
* `RunProg`
* `Build`
* `BuildAndRun`
* `AddCompiler {filetype} {compiler}`
* `AddMakeprg[!] {filetype} {makeprg}`
* `AddRunCmd[!] [mode] {filetype} {cmd}`

## Mappings
* <kbd>F7</kbd>  `:Build`
* <kbd>F8</kbd>  `:RunProg`
* <kbd>F9</kbd>  `:BuildAndRun`
* <kbd>F10</kbd> `:w <bar> make<CR>`

## Configuration
* `g:sBnR_compilers` - dictionary with compilers
* `g:sBnR_makeprgs` - dictionary with makeprgs
* `g:sBnR_runCmds` - dictionary with commands to run with `:Run`
* `g:sBnr_mappings` - if set to 0, don't use default mappings
* `TMPDIR` - directory for temporary files, default `/tmp`
* `BROWSER` - web browser, default `xdg-open`

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

---

**TODO:** docs
