execute pathogen#infect()

set foldmethod=expr
set foldexpr=GetPotionFold(v:lnum)
set foldminlines=0
set foldopen=mark 

function! s:NextNonBlankLine(lnum)
    let numlines = line('$')
    let current = a:lnum + 1
    while current <= numlines
        if getline(current) =~? '\v\S'
            return current
        endif
        let current += 1
    endwhile
    return -2
endfunction

function! s:IndentLevel(lnum)
    if &ft == 'chaos'
        if (a:lnum == 1)
            return 0
        else
            return (getline(a:lnum)=~?'\v^::' ? 0 : indent(a:lnum) / &shiftwidth + 1)
        endif
    else
        return indent(a:lnum) / &shiftwidth + (getline(a:lnum)=~?'^\s*}' ? 1 : 0)
    endif
endfunction

function! GetPotionFold(lnum)
    if getline(a:lnum) =~? '\v^\s*$'
        return '-1'
    endif
    let this_indent = <SID>IndentLevel(a:lnum)
    let next_indent = <SID>IndentLevel(<SID>NextNonBlankLine(a:lnum))
    let prev_indent = <SID>IndentLevel(<SID>PrevNonBlankLine(a:lnum))
    if next_indent == this_indent
        return this_indent
    elseif next_indent < this_indent
        return this_indent
    elseif next_indent > this_indent
        return '>' . next_indent
    endif
endfunction

function! NeatFoldText()
    let line = getline(v:foldstart)
    let lines_count = v:foldend - v:foldstart + 1
    let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
    let foldchar = ' '
    let foldtextstart = strpart(line, 0, (winwidth(0)*2)/3)
    let foldtextend = lines_count_text . repeat(foldchar, 6)
    let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
    return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
    
endfunction
set foldtext=NeatFoldText()

hi Folded ctermbg=231 ctermfg=2
hi FoldColumn ctermbg=white ctermfg=darkred

set ruler

set ttyfast
set ttyscroll=3
set lazyredraw
set hidden
set wrap nolist linebreak


set nolisp                               
set tabstop=2                            
set expandtab                            
set backspace=indent,eol,start           
set autoindent                           
set number                               
set shiftwidth=2                         
set shiftround                           
set showmatch                            
set ignorecase                           
set smartcase                            
set smarttab                             
set hlsearch                             
set incsearch                            
set history=1000                         
set undolevels=1000                      
set title                                
set novisualbell                         
set noerrorbells                         
set nobackup
set noswapfile
set nocompatible

set shortmess=atql 
set nolist  
set textwidth=40
set wrapmargin=0
set cryptmethod=blowfish2


let g:ctrlp_by_filename = 0
:map <expr> <space> ":CtrlP ".getcwd()."<cr>"


:noremap j gj
:noremap k gk

:nnoremap <expr> r ':!time kind %<cr>'

:nnoremap <expr> r ':!clear<cr>:w!<cr>'.(
    \ expand('%:p')=='/Users/v/mist/main.js' ? ':!electron . --rpc ~/Library/Ethereum/testnet/geth.ipc<cr>' :
    \ expand('%:t')=='test.js' ? ':!mocha<cr>' :
    \ &ft=='caramel'    ? ':!time mel main<cr>' :
    \ &ft=='ocaml'      ? ':!ocamlc -o %:r %<cr>:!./%:r<cr>' :
    \ &ft=='factor'     ? ':!~/factor/factor %<cr>' :
    \ &ft=='python'     ? ':!time python3 %<cr>' :
    \ &ft=='coc'        ? ':!time (coc type %:r; coc norm %:r)<cr>' :
    \ &ft=='scheme'     ? ':!time scheme --script %<cr>' :
    \ &ft=='elm'        ? '<esc>:!clear<cr>:w!<cr>:!elm % -r elm-runtime.js<cr>:!osascript ~/.vim/refresh.applescript &<cr>' :
    \ &ft=='racket'     ? ':!racket %<cr>' :
    \ &ft=='haskell'    ? ':!time runghc --ghc-arg=-freverse-errors %<cr>' :
    \ &ft=='rust'       ? ':!time cargo run<cr>' :
    \ &ft=='go'         ? ':!time go run %<cr>' :
    \ &ft=='purescript' ? ':!pulp run <cr>' :
    \ &ft=='dvl'        ? ':!dvl run %<cr>' :
    \ &ft=='ultimate'   ? ':!time ult %<cr>' :
    \ &ft=='lambda'     ? ':!time absal %<cr>' :
    \ &ft=='javascript' ? ':!time node %<cr>' :
    \ &ft=='typescript' ? ':!time deno --unstable run --allow-all %<cr>' :
    \ &ft=='moon'       ? ':!time moon run %:r<cr>' :
    \ &ft=='escoc'      ? ':!time escoc %:r<cr>' :
    \ &ft=='eatt'       ? ':!time eatt -itneTNRx %:r<cr>' :
    \ &ft=='eac'        ? ':!time eac %:r<cr>' :
    \ &ft=='fmfm'       ? ':!time fmjs %<cr>' :
    \ &ft=='formality'  ? ':!time fmjs %<cr>' :
    \ &ft=='formcore'   ? ':!time fmc %<cr>' :
    \ &ft=='kind'       ? ':!time kind %<cr>' :
    \ &ft=='kindelia'   ? ':!time kindelia %<cr>' :
    \ &ft=='lambolt'    ? ':!time hovm % ts<cr>' :
    \ &ft=='sic'        ? ':!time sic -s %<cr>' :
    \ &ft=='morte'      ? ':!time echo $(cat %) \| morte<cr>' :
    \ &ft=='swift'      ? ':!time swift %<cr>' :
    \ &ft=='solidity'   ? ':!truffle deploy<cr>' :
    \ &ft=='idris'      ? ':!idris % -o %:r<cr>:!time ./%:r<cr>' :
    \ &ft=='c'          ? ':!clang % -o %:r<cr>:!time ./%:r<cr>' :
    \ &ft=='cuda'       ? ':!scp % victu:~/cuda<CR>:!ssh victu /usr/local/cuda/bin/nvcc -O3 /home/v/cuda/% -o /home/v/cuda/%:r<CR>:!ssh victu time /home/v/cuda/%:r<cr>' :
    \ &ft=='cpp'        ? ':!clang++ -std=c++11 -O3 % -o %:r<cr>:!time ./%:r<cr>' :
    \ &ft=='agda'       ? ':!agda -i src %<cr>' :
    \ &ft=='ls'         ? ':!lsc -c %<cr>:!node %:r.js<cr>' :
    \ &ft=='lispell'    ? ':!node ~/Viclib/lispedia/bin/lis.js reduce %:r<cr>' :
    \ ':!time cc %<cr>')

:nnoremap <expr> R ':!clear<cr>:w!<cr>'.(
    \ expand('%:p')=='/Users/v/mist/main.js' ? ':!electron . --rpc ~/Library/Ethereum/testnet/geth.ipc<cr>' :
    \ expand('%:t')=='test.js' ? ':!mocha<cr>' :
    \ &ft=='caramel'    ? ':!time mel main<cr>' :
    \ &ft=='ocaml'      ? ':!ocamlc -o %:r %<cr>:!./%:r<cr>' :
    \ &ft=='factor'     ? ':!~/factor/factor %<cr>' :
    \ &ft=='python'     ? ':!time python %<cr>' :
    \ &ft=='coc'        ? ':!time (coc type %:r; coc norm %:r)<cr>' :
    \ &ft=='scheme'     ? ':!csc %<cr>:!time ./%:r<cr>' :
    \ &ft=='elm'        ? '<esc>:!clear<cr>:w!<cr>:!elm % -r elm-runtime.js<cr>:!osascript ~/.vim/refresh.applescript &<cr>' :
    \ &ft=='racket'     ? ':!racket %<cr>' :
    \ &ft=='haskell'    ? ':!time ghc -O2 % -o .tmp; time ./.tmp<cr>' :
    \ &ft=='rust'       ? ':!time cargo run --release<cr>' :
    \ &ft=='go'         ? ':!time go run %<cr>' :
    \ &ft=='purescript' ? ':!pulp run <cr>' :
    \ &ft=='dvl'        ? ':!dvl run %<cr>' :
    \ &ft=='lambda'     ? ':!time absal -s %<cr>' :
    \ &ft=='javascript' ? ':!npm run build<cr>' :
    \ &ft=='typescript' ? ':!time deno --unstable run --reload --allow-all %<cr>' :
    \ &ft=='html'       ? ':!npm run build<cr>' :
    \ &ft=='eatt'       ? ':!time eatt %:r<cr>' :
    \ &ft=='fmfm'       ? ':!time fmjs %:r --run<cr>' :
    \ &ft=='formality'  ? ':!time fmjs %:r --run<cr>' :
    \ &ft=='kind'       ? ':!time kind ' . substitute(expand("%:r"),"/",".","g") . ' --run<cr>' :
    \ &ft=='lambolt'    ? ':!time lam % c<cr>' :
    \ &ft=='eac'        ? ':!time eac %:r<cr>' :
    \ &ft=='formcore'   ? ':!time fmio %:r<cr>' :
    \ &ft=='moon'       ? ':!time moon run %:r<cr>' :
    \ &ft=='sic'        ? ':!time sic -s -B %<cr>' :
    \ &ft=='morte'      ? ':!time echo $(cat %) \| morte<cr>' :
    \ &ft=='swift'      ? ':!time swift %<cr>' :
    \ &ft=='solidity'   ? ':!truffle deploy<cr>' :
    \ &ft=='idris'      ? ':!idris % -o %:r<cr>:!time ./%:r<cr>' :
    \ &ft=='c'          ? ':!clang -O3 % -o %:r<cr>:!time ./%:r<cr>' :
    \ &ft=='cuda'       ? ':!rm %:r; nvcc -O3 % -o %:r<cr>:!time ./%:r<cr>' :
    \ &ft=='cpp'        ? ':!clang++ -O3 % -o %:r<cr>:!time ./%:r<cr>' :
    \ &ft=='agda'       ? ':!agda -i src %<cr>' :
    \ &ft=='ls'         ? ':!lsc -c %<cr>:!node %:r.js<cr>' :
    \ &ft=='lispell'    ? ':!node ~/Viclib/lispedia/bin/lis.js reduce %:r<cr>' :
    \ ':!time cc %<cr>')

:nnoremap <expr> <leader>r ':!clear<cr>:w!<cr>'.(
    \ expand('%:p')=='/Users/v/mist/main.js' ? ':!electron . --rpc ~/Library/Ethereum/testnet/geth.ipc<cr>' :
    \ expand('%:t')=='test.js' ? ':!mocha<cr>' :
    \ &ft=='caramel'    ? ':!time mel main<cr>' :
    \ &ft=='ocaml'      ? ':!ocamlc -o %:r %<cr>:!./%:r<cr>' :
    \ &ft=='factor'     ? ':!~/factor/factor %<cr>' :
    \ &ft=='python'     ? ':!time python %<cr>' :
    \ &ft=='coc'        ? ':!time (coc type %:r; coc norm %:r)<cr>' :
    \ &ft=='scheme'     ? ':!csc %<cr>:!time ./%:r<cr>' :
    \ &ft=='elm'        ? '<esc>:!clear<cr>:w!<cr>:!elm % -r elm-runtime.js<cr>:!osascript ~/.vim/refresh.applescript &<cr>' :
    \ &ft=='racket'     ? ':!racket %<cr>' :
    \ &ft=='haskell'    ? ':!stack run<cr>' :
    \ &ft=='rust'       ? ':!time cargo +nightly run --release<cr>' :
    \ &ft=='go'         ? ':!time go run %<cr>' :
    \ &ft=='purescript' ? ':!pulp run <cr>' :
    \ &ft=='dvl'        ? ':!dvl run %<cr>' :
    \ &ft=='lambda'     ? ':!time absal -s %<cr>' :
    \ &ft=='javascript' ? ':!npm run build<cr>' :
    \ &ft=='typescript' ? ':!npm run build<cr>' :
    \ &ft=='html'       ? ':!npm run build<cr>' :
    \ &ft=='eatt'       ? ':!time eatt %:r<cr>' :
    \ &ft=='formality'  ? ':!time fm %<cr>' :
    \ &ft=='formcore'   ? ':!time fmcjs %:r<cr>' :
    \ &ft=='kind'       ? ':!node /Users/v/vic/dev/Kind/web/build.js %:r<cr>' :
    \ &ft=='eac'        ? ':!time eac %:r<cr>' :
    \ &ft=='moon'       ? ':!time moon run %:r<cr>' :
    \ &ft=='sic'        ? ':!time sic -s -B %<cr>' :
    \ &ft=='morte'      ? ':!time echo $(cat %) \| morte<cr>' :
    \ &ft=='swift'      ? ':!time swift %<cr>' :
    \ &ft=='solidity'   ? ':!truffle deploy<cr>' :
    \ &ft=='idris'      ? ':!idris % -o %:r<cr>:!time ./%:r<cr>' :
    \ &ft=='c'          ? ':!clang -O3 -Wall % -o %:r<cr>:!time ./%:r<cr>' :
    \ &ft=='cuda'       ? ':!rm %:r; nvcc -O3 % -o %:r<cr>:!time ./%:r<cr>' :
    \ &ft=='cpp'        ? ':!clang++ -O3 % -o %:r<cr>:!time ./%:r<cr>' :
    \ &ft=='agda'       ? ':!agda -i src %<cr>' :
    \ &ft=='ls'         ? ':!lsc -c %<cr>:!node %:r.js<cr>' :
    \ &ft=='lispell'    ? ':!node ~/Viclib/lispedia/bin/lis.js reduce %:r<cr>' :
    \ ':!time cc %<cr>')

:nnoremap <expr> <leader>R ':!clear<cr>:w!<cr>'.(
    \ expand('%:p')=='/Users/v/mist/main.js' ? ':!electron . --rpc ~/Library/Ethereum/testnet/geth.ipc<cr>' :
    \ expand('%:t')=='test.js' ? ':!mocha<cr>' :
    \ &ft=='caramel'    ? ':!time mel main<cr>' :
    \ &ft=='ocaml'      ? ':!ocamlc -o %:r %<cr>:!./%:r<cr>' :
    \ &ft=='factor'     ? ':!~/factor/factor %<cr>' :
    \ &ft=='python'     ? ':!time python %<cr>' :
    \ &ft=='coc'        ? ':!time (coc type %:r; coc norm %:r)<cr>' :
    \ &ft=='scheme'     ? ':!csc %<cr>:!time ./%:r<cr>' :
    \ &ft=='elm'        ? '<esc>:!clear<cr>:w!<cr>:!elm % -r elm-runtime.js<cr>:!osascript ~/.vim/refresh.applescript &<cr>' :
    \ &ft=='racket'     ? ':!racket %<cr>' :
    \ &ft=='haskell'    ? ':!stack run<cr>' :
    \ &ft=='rust'       ? ':!time cargo +nightly run --release<cr>' :
    \ &ft=='go'         ? ':!time go run %<cr>' :
    \ &ft=='purescript' ? ':!pulp run <cr>' :
    \ &ft=='dvl'        ? ':!dvl run %<cr>' :
    \ &ft=='lambda'     ? ':!time absal -s %<cr>' :
    \ &ft=='javascript' ? ':!npm run build<cr>' :
    \ &ft=='typescript' ? ':!npm run build<cr>' :
    \ &ft=='html'       ? ':!npm run build<cr>' :
    \ &ft=='eatt'       ? ':!time eatt %:r<cr>' :
    \ &ft=='formality'  ? ':!time fmio %:r<cr>' :
    \ &ft=='formcore'   ? ':!time fmcrun main<cr>' :
    \ &ft=='kind'       ? ':!node /Users/v/vic/dev/Kind/web/build.js %:r<cr>' :
    \ &ft=='eac'        ? ':!time eac %:r<cr>' :
    \ &ft=='moon'       ? ':!time moon run %:r<cr>' :
    \ &ft=='sic'        ? ':!time sic -s -B %<cr>' :
    \ &ft=='morte'      ? ':!time echo $(cat %) \| morte<cr>' :
    \ &ft=='swift'      ? ':!time swift %<cr>' :
    \ &ft=='solidity'   ? ':!truffle deploy<cr>' :
    \ &ft=='idris'      ? ':!idris % -o %:r<cr>:!time ./%:r<cr>' :
    \ &ft=='c'          ? ':!clang -O3 % -o %:r<cr>:!time ./%:r<cr>' :
    \ &ft=='cuda'       ? ':!rm %:r; nvcc -O3 % -o %:r<cr>:!time ./%:r<cr>' :
    \ &ft=='cpp'        ? ':!clang++ -O3 % -o %:r<cr>:!time ./%:r<cr>' :
    \ &ft=='agda'       ? ':!agda -i src %<cr>' :
    \ &ft=='ls'         ? ':!lsc -c %<cr>:!node %:r.js<cr>' :
    \ &ft=='lispell'    ? ':!node ~/Viclib/lispedia/bin/lis.js reduce %:r<cr>' :
    \ ':!time cc %<cr>')

:nnoremap <expr> <leader>m ':q!<cr>'

:nnoremap <expr> <leader>w ':w!<cr>:!clear; node /Users/v/vic/dev/Kind/web/build.js<cr>:!osascript ~/vic/dev/refresh_chrome.applescript &<cr>'
:nnoremap <expr> <leader>x ':x!<cr>'
:nnoremap <expr> <leader>q ':q!<cr>'



:nmap <leader>g :<C-U>exe "CreateCompletion ".v:count1<CR>


:let NERDTreeIgnore = ['\.idr\~$','\.git', '\.cache','\.ibc$','\.min.js$','\.agdai','\.pyc$','\.hi$','\.o$','\.js_o$','\.js_hi$','\.dyn_o$','\.dyn_hi$','\.jsexe','.*dist\/.*','.*bin\/.*']
:let NERDTreeChDirMode = 2
:let NERDTreeWinSize = 24
:let NERDTreeShowHidden=1
:nmap <expr> <enter> v:count1 <= 1 ? "<C-h>C<C-w>p" : "@_<C-W>99h". v:count1 ."Go<C-w>l"

:nmap <leader>n :NERDTree<CR>

:nmap <expr> <leader>t ":ClearCtrlPCache<cr>:NERDTree<cr>:set nu<cr><C-w>l"


:inoremap ☮ <esc>
:vnoremap ☮ <esc>
:cnoremap ☮ <esc>

:set clipboard=unnamed,unnamedplus,autoselect


:map <left> 1<C-w><
:map <right> 1<C-w>>
:map <up> 1<C-w>-
:map <down> 1<C-w>+
:noremap <C-j> <esc><C-w>j

:map <C-h> <C-w>h
:map <C-l> <C-w>l
:map <C-j> <C-w>j
:map <C-k> <C-w>k
" :map! <C-h> <esc><C-w>h
" :map! <C-l> <esc><C-w>l
nnoremap <C-a> :NERDTreeToggle<CR>

" call pathogen#runtime_append_all_bundles()


hi link lsSpaceError NONE
hi link lsReservedError NONE


:syntax on


:set scrolloff=99999 " vertically keep cursor on the middle of the screen
:set sidescrolloff=0 " only scroll horizontally when out of bounds

:map , <leader>


:nnoremap <leader>j J


hi StatusLine ctermfg=darkgrey ctermbg=black
hi StatusLineNC ctermfg=lightgray ctermbg=black
hi VertSplit ctermfg=lightgray ctermbg=black


:map ! <leader>c<space>


:nnoremap d/ :nohl<cr>


:nnoremap q qa<esc>
:nnoremap Q @a

:nnoremap <C-u> <C-o>


:nnoremap <S-j> 6gj
:nnoremap <S-k> 6gk
:vnoremap <S-j> 6gj
:vnoremap <S-k> 6gk


:nnoremap <leader>j J


:nmap <D-h>    <C-o>


:nmap ( <<
:nmap ) >>

:map U <C-r>
:nmap <C-j> <C-w>j

:nmap <C-l> <C-w>l
:nmap <C-h> <C-w>h

:nnoremap H ^
:nnoremap L $
:vnoremap H ^
:vnoremap L $


au BufNewFile,BufRead *.purs set filetype=purescript
au BufNewFile,BufRead *.chaos set filetype=chaos
au BufNewFile,BufRead *.chaos set syntax=javascript
au BufNewFile,BufRead *.moon set filetype=moon
au BufNewFile,BufRead *.escoc set filetype=escoc
au BufNewFile,BufRead *.escoc set syntax=javascript
au BufNewFile,BufRead *.sic set filetype=sic
au BufNewFile,BufRead *.moon set syntax=javascript
au BufNewFile,BufRead *.mt set filetype=morte
au BufNewFile,BufRead *.idr set filetype=idris
au BufNewFile,BufRead *.coc set filetype=coc
au BufNewFile,BufRead *.ult set filetype=ultimate
au BufNewFile,BufRead *.lc set filetype=lambda
au BufNewFile,BufRead *.lc set syntax=elm
au BufNewFile,BufRead *.lam set filetype=lambda
au BufNewFile,BufRead *.lam set syntax=elm
au BufNewFile,BufRead *.mel set filetype=caramel
au BufNewFile,BufRead *.mel set syntax=elm
au BufNewFile,BufRead *.dvl set filetype=dvl
au BufNewFile,BufRead *.lis set filetype=lispell
au BufNewFile,BufRead *.lscm set filetype=lispell
au BufNewFile,BufRead *.sol set filetype=solidity
au BufNewFile,BufRead *.eatt set filetype=eatt
au BufNewFile,BufRead *.eatt set syntax=javascript
au BufNewFile,BufRead *.fm set filetype=formality
au BufNewFile,BufRead *.fm set syntax=javascript
au BufNewFile,BufRead *.fmfm set filetype=fmfm
au BufNewFile,BufRead *.fmfm set syntax=javascript
au BufNewFile,BufRead *.ifm set filetype=informality
au BufNewFile,BufRead *.ifm set syntax=javascript
au BufNewFile,BufRead *.eac set filetype=eac
au BufNewFile,BufRead *.eac set syntax=javascript
au BufNewFile,BufRead *.fmc set filetype=formcore
au BufNewFile,BufRead *.fmc set syntax=javascript

au BufNewFile,BufRead *.kindelia set filetype=kindelia
au BufNewFile,BufRead *.kindelia set syntax=javascript
au BufNewFile,BufRead *.bolt set filetype=lambolt
au BufNewFile,BufRead *.bolt set syntax=javascript
au BufNewFile,BufRead *.pwd set syntax=javascript
au BufNewFile,BufRead *.pvt set syntax=javascript


au BufNewFile,BufRead *.pvt set filetype=javascript
au BufNewFile,BufRead *.pvt set syntax=javascript
au BufNewFile,BufRead *.pvt syntax region Password start=/^/ end=/$/
au BufNewFile,BufRead *.pvt highlight Password ctermfg=red guifg=red ctermbg=red guifg=red
au BufNewFile,BufRead *.pvt set colorcolumn=0
au BufNewFile,BufRead *.pvt set noundofile
au BufNewFile,BufRead *.pvt :nmap <leader>g :<C-U>echo "NOT ALLOWED, THIS IS A PVT FILE! ".v:count1<CR>
filetype plugin on


au BufNewFile,BufRead *.pwd set filetype=javascript
au BufNewFile,BufRead *.pwd set syntax=javascript
au BufNewFile,BufRead *.pwd syntax region Password start=/"{/ end=/}"/
au BufNewFile,BufRead *.pwd highlight Password ctermfg=red guifg=red ctermbg=red guifg=red
au BufNewFile,BufRead *.pwd set colorcolumn=0
au BufNewFile,BufRead *.pwd set noundofile
au BufNewFile,BufRead *.pwd :nmap <leader>g :<C-U>echo "NOT ALLOWED, THIS IS A PWD FILE! ".v:count1<CR>
filetype plugin on


au BufNewFile,BufRead *.scm set nolisp


au BufRead,BufNewFile *.kind set filetype=kind 


:nnoremap + zr:echo 'foldlevel: ' . &foldlevel<cr>
:nnoremap - zm:echo 'foldlevel: ' . &foldlevel<cr>
:nnoremap <leader>f zO
:nnoremap <leader>d zo
:nnoremap <leader>s zc
:nnoremap <leader>a zC



:set comments+=:--

set undofile
set undodir=~/.vim/undo
set foldlevel=0
au Syntax * normal zR

set formatoptions=cql
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()
set rtp+=~/.vim/bundle/nerdtree


function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction



au BufRead,BufNewFile *.kind set filetype=kind




function! SetupCtrlP()
  if exists("g:loaded_ctrlp") && g:loaded_ctrlp
    augroup CtrlPExtension
      autocmd!
      autocmd FocusGained  * CtrlPClearCache
      autocmd BufWritePost * CtrlPClearCache
    augroup END
  endif
endfunction

if has("autocmd")
  autocmd VimEnter * :call SetupCtrlP()
endif

:noremap m %

set runtimepath^=~/.vim/bundle/ag



function! SetTerminalTitle()
    let titleString = expand('%:t')
    if len(titleString) > 0
        let &titlestring = expand('%:t')
        let args = "\033];".&titlestring."\007"
        let cmd = 'silent !echo -e "'.args.'"'
        execute cmd
        redraw!
    endif
endfunction
autocmd BufEnter * call SetTerminalTitle()



augroup Binary
  au!
  au BufReadPre  *.wasm let &bin=1
  au BufReadPost *.wasm if &bin | %!xxd
  au BufReadPost *.wasm set ft=xxd | endif
  au BufWritePre *.wasm if &bin | %!xxd -r
  au BufWritePre *.wasm endif
  au BufWritePost *.wasm if &bin | %!xxd
  au BufWritePost *.wasm set nomod | endif
augroup END


" packadd! dracula
colorscheme dracula 
syntax enable



let maplocalleader = "\\"
let g:agda_extraincpaths = ["/Users/v/vic/dev/agda"]


autocmd VimEnter * NERDTree | wincmd p
