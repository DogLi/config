"=============================================================================
"                   FileName: .vimrc
"            /|         Desc: This is the configuration file for vim
"  --- 8"     |       Author: yuanlinfeng
"   \'  0 。0 !        Email: cxwcylf@126.com
"                    Version: 0.0.1
"                 LastChange: 2014-04-26 14:17:08
"                    History:
"=============================================================================

"os detect
if(has('win32') || has('win64') || has('win32unix'))
    let g:isWin=1
else
    let g:isWin=0
endif

"乱码问题{{{1
"--------------------------------------------------------------------------------------
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,chinese,cp936
source $VIMRUNTIME/delmenu.vim "解决encoding后出现的菜单乱码
source $VIMRUNTIME/menu.vim "再次读取缺省菜单
language messages zh_CN.utf-8 "解决console和界面的乱码


"--------------------------------------------------------------------------------------
"显示相关{{{1
"--------------------------------------------------------------------------------------
"set lines=45 columns=110
set colorcolumn=80   "在80行处显示颜色竖条
"let &colorcolumn="80,".join(range(1000,1999),",")
"highlight ColorColumn ctermbg=red guibg=orange
set clipboard=unnamed                     "全局粘贴
set cmdheight=1
set guifont=AR\ PL\ UKai\ CN\ 13            "设置字体
set linespace=2                               "行间距
set scrolloff=5                               "向上下滚动时,至少显示5行
set scrolljump=5                              "光标离开屏幕范围
set number                                    "显示行号
"set textwidth=100                             "设置文本宽度为80,对于已经存在的文本,选中后按gq就可以了
set nowrap                                      "设置自动折行
set showcmd                                   "显示命令
"set cursorcolumn
set cursorline                                "高亮光标行
set ambiwidth=double                          "默认用窄字符,防止无法显示某些字符
set lbr                                       "不在单词中间段行
set selectmode=mouse,key                      "可以用鼠标和键盘进入选择模式
set iskeyword+=_,-                    "带有上述符号的单词不能被换行分割
set iskeyword-=.
let g:vimim_disable_chinese_punctuation=1     "关闭中文标点
let g:vimim_disable_seamless_english_input=1  "中英文之间不加标点
set formatoptions+=mB                         "使中文也能自动换行
set helplang=cn
" When editing a file, always jump to the last known cursor position.
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif
if has("gui_running")
    set guioptions+=b  "隐藏底部滚动条
    set guioptions+=e  "打开gui标签页支持
    set showtabline=2  "指定合适显示标签页行，0永远不显示，1至少有两个标签，2永远显示
endif
set listchars=tab:\ \ ,trail:.,extends:>,precedes:<             " 制表符显示方式定义：trail为拖尾空白显示字符，extends和precedes分别是wrap关闭时，所在行在屏幕右边和左边显示的指示字符
" Syntax coloring lines that are too long just slows down the world
set synmaxcol=1000
set ttyfast " u got a fast terminal
set ttyscroll=3
set lazyredraw " to avoid scrolling problems
set history=500
set hidden " 切换文件不保存，隐藏

"调整光标
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

"--------------------------------------------------------------------------------------
"操作设置{{{1
"--------------------------------------------------------------------------------------
set lazyredraw
autocmd! bufwritepost .vimrc source % " vimrc文件修改之后自动加载。 linux。
"set autochdir "Automatically cd into the directory
set formatoptions=tcrqn "自动格式化
set mouse=a                         "使用鼠标=a
set ttymouse=xterm2

set confirm  "在处理未保存或者只读文件的时候，弹出确认
set backspace=indent,start,eol "<Bsc>可以删除上一行的换行符,并使两行合并
let Tlist_Exist_OnlyWindow = 1 "如果只有一个buffer，kill窗口也kill掉buffer
set whichwrap=b,s,<,>,[,],h,l
set smarttab "按一下<Bsc>就可以删除tab
set noerrorbells  "让命令行不发出滴滴
set nocompatible "避免与vi的兼容性
set nosol    "行间移动时尽量在同一列

"窗口分割方向
set splitright
set splitbelow
"设置 退出vim后，内容显示在终端屏幕, 可以用于查看和复制
"set t_ti= t_te=
" 修复ctrl+m 多光标操作选择的bug，但是改变了ctrl+v进行字符选中时将包含光标下的字符
set selection=inclusive
set selectmode=mouse,key


" 备份,到另一个位置. 防止误删
set directory=~/.vim/dirs/tmp     " directory to place swap files in
set backup                        " make backup files
set backupdir=~/.vim/dirs/backups " where to put backup files
set undofile                      " persistent undos - undo after you re-open the file
set undodir=~/.vim/dirs/undos
set viminfo+=n~/.vim/dirs/viminfo
" create needed directories if they don't exist
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif

set undolevels=1000
if v:version > 730
    set undofile
    set undoreload=1000
    if g:isWin
        set undodir=$VIM/bak/vimundo/
    else
        set undodir=~/.vim/vimundo/
    endif
endif

" 文件保存时处理首尾空格，^M字符
let g:keep_trailing_whitespace = 1
function! StripTrailingWhitespace()
    %s/\s\+$//e
    %s/\r\+$//e
endfunction
"autocmd FileType html,c,cpp,java,go,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> if exists('g:keep_trailing_whitespace') | silent! :StripTrailingWhitespace | endif
autocmd BufWritePre * call StripTrailingWhitespace()

" for tmux to automatically set paste and nopaste mode at the time pasting (as
" happens in VIM UI)

function! WrapForTmux(s)
    if !exists('$TMUX')
        return a:s
    endif

    let tmux_start = "\<Esc>Ptmux;"
    let tmux_end = "\<Esc>\\"

    return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
"--------------------------------------------------------------------------------------
"查找相关设置{{{1
"--------------------------------------------------------------------------------------
set ignorecase smartcase " 智能调整大小写检查
set hlsearch "高亮显示搜索结果
set incsearch "搜索时根据键入的字母实施显示查找结果
"set gdefault "替换时所有的行匹配都被替换,而不是有第一个
set nowrapscan
set wildignore=*.swp,*.bak,*.pyc,*~,*.svn
set cscopequickfix=s-,c-,d-,i-,t-,e-

"--------------------------------------------------------------------------------------
"错误自动更改{{{1
"--------------------------------------------------------------------------------------
"iabbrev Mymail cxwcylf@126.com
"cabbrev a b "命令模式下将a 映射为b
"abbreviate a b "所有模式下,将a映射为b
"另一种方法,put the fllow lines in a file，然后souce该文件
abbreviate teh the
abbreviate mian main
abbreviate slef self
abbreviate retrun return
abbreviate improt import
abbreviate pirnt print
abbreviate mian() main()
abbreviate imput input
abbreviate ture true
abbreviate Ture True
abbreviate pdb import pdb; pdb.set_trace()

"--------------------------------------------------------------------------------------
"编程相关设置{{{1
"--------------------------------------------------------------------------------------
set autoindent                              "自动换行
set wildmenu                                "自动补全命令
set wildignore=*.o,*~,*.pyc,*.class
set cindent                                 "C/C++自动缩进
syntax on                                   "语法检测打开
"set tags=/home/bingoboy/Nutstore/code/tags
set showmatch
set matchtime=2                             "匹配括号高亮的时间,单位是1/10秒
set shiftwidth=4
set softtabstop=4
" tab length exceptions on some file types
au BufRead,BufNewFile *.vue             setfiletype vue
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType vue setlocal shiftwidth=2 tabstop=2 softtabstop=2
set ai!                                     "设置自动缩进
set expandtab                               "将tab转化为空格
retab                                       "将已有tab转化为空格
set nopaste                                 "复制代码时不自动缩进
set tags=./tags;/,~/.vim/tags path=.,/usr/local/include,/usr/include
cmap w!! w !sudo tee % >/dev/null

"--------------------------------------------------------------------------------------
"代码折行{{{1
"--------------------------------------------------------------------------------------
"set foldmarker={,}
"set foldmethod=marker
"set foldmethod=syntax
set foldmethod=indent
set foldlevel=20 "Don't autofold anything(but i can still fold manually)
set foldopen+=search " open folds when you search into them
set foldopen+=undo   "open folds when you undo stuff
set foldcolumn=3 "用最左边4列显示fold的信息



"--------------------------------------------------------------------------------------
"状态栏设置{{{1
"--------------------------------------------------------------------------------------
let g:Powerline_symbols = 'fancy'
set laststatus=2
set t_Co=256 "颜色设置


"================错误提示错误提示错误提示======================{{{2
"合法IP地址显示
match todo /\(\(25[0-5]\|2[0-4][0-9]\|[01]\?[0-9] [0-9]\?\)\.\) \{3\}\(25[0-5]\|2[0-4][0-9]\|[01]\?  [0-9][0-9]\?\)/
"非法IP地址显示红色
match errorMsg /\(2[5][6-9]\|2[6-9][0-9]\|[3-9][0-9][0-9]\)[.]\[0-9]\{1,3\}[.][0-9]\{1,3\}[.][0-9]\{1,3\}\|\[0-9]\{1,3\}[.]\(2[5][6-9]\|2[6-9][0-9]\|\
            \\ \[3-9][0-9][0-9]\)[.][0-9]\{1,3\}[.][0-9]
            \\{1,3\}\|\[0-9]\{1,3\}[.][0-9]\{1,3\}[.]\(2[5]
            \\ \[6-9]\|\2[6-9][0-9]|[3-9][0-9][0-9]\)[.][0-9]\{1,3\}
            \\|[0-9]\{1,3\}[.][0-9]\{1,3\}[.][0-9]\{1,3\}[.]
            \\(2[5][6-9]\|2[6-9][0-9]\|\[3-9][0-9][0-9]\)/



"--------------------------------------------------------------------------------------
"查看XXX映射文件：verbose map XXX
"Map{{{1
let mapleader = ","
" Map <Leader>ff to display all lines with keyword under cursor
" and ask which one to jump to
nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>
"================== normal mode ======================{{{2
map <Left> :tabp<cr>
map <Right> :tabn<cr>
"nnoremap <right> gt    "到下一个tabe页
map <Up> :CtrlP<cr>
map <Down> :CtrlPBuffer<cr>
nnoremap wv <C-w>v     "垂直分割当前窗口
nnoremap wc <C-w>c     "关闭当前窗口
nnoremap ws <C-w>s     "水平分割当前窗口
nnoremap <C-h> <C-w>h  "到左边的一个window
nnoremap <C-j> <C-w>j  "到下边的一个window latex_vim中的<C-J>用<C-G>代替 用verbose map <c-g> 查看
nnoremap <C-k> <C-w>k  "到上边的一个window
nnoremap <C-l> <C-w>l  "到右边的一个window
nnoremap j gj
nnoremap k gk
"让编辑模式可以中文输入法下按：转到命令模式
nnoremap ： :
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

map <Leader>ch :call SetColorColumn()<CR>
function! SetColorColumn()
    let col_num = virtcol(".")
    let cc_list = split(&cc, ',')
    if count(cc_list, string(col_num)) <= 0
        execute "set cc+=".col_num
    else
        execute "set cc-=".col_num
    endif
endfunction
map "" maviwS"`a
"map '' maviwS'`a
map )) maviwS)`a
map ]] maviwS]`a


noremap <F1> <Esc>
set pastetoggle=<F2>
" tab 操作
" TODO: ctrl + n 变成切换tab的方法
" http://vim.wikia.com/wiki/Alternative_tab_navigation
" http://stackoverflow.com/questions/2005214/switching-to-a-particular-tab-in-vim
"map <C-2> 2gt
map <leader>tn :tabnew<cr>
map <leader>te :tabedit<cr>
map <leader>td :tabclose<cr>
map <leader>tm :tabm<cr>


" 新建tab  Ctrl+t
"nnoremap <C-t>     :tabnew<CR>
"inoremap <C-t>     <Esc>:tabnew<CR>
inoremap <C-Left> <Esc>:tabprevious<CR>
inoremap <C-Right>   <Esc>:tabnext<CR>
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" Toggles between the active and last active tab "
" The first tab is always 1 "
let g:last_active_tab = 1
" nnoremap <leader>gt :execute 'tabnext ' . g:last_active_tab<cr>
" nnoremap <silent> <c-o> :execute 'tabnext ' . g:last_active_tab<cr>
" vnoremap <silent> <c-o> :execute 'tabnext ' . g:last_active_tab<cr>
nnoremap <silent> <leader>tt :execute 'tabnext ' . g:last_active_tab<cr>
vnoremap <silent> <leader>tt :execute 'tabnext ' . g:last_active_tab<cr>
autocmd TabLeave * let g:last_active_tab = tabpagenr()

vnoremap < <gv
vnoremap > >gv

"================== insert mode ======================{{{2
" imap  ..   <Right>
imap  <tab>   <Right>
" imap  ,,   <Left>
imap  ;;   <Left>

"================== all mode ======================={{{2
"map <C-b>           <home>
"map <C-e>           <end>

"function! CompileRun()
"exec "w"
"if(&filetype=='java')
"exec "!javac %"
"exec "!java ./%<"
"elseif(&filetype=='sh')
"exec "!chmod a+x %"
"exec "!./%"
"elseif(&filetype=='python')
"exec "!python %"
"elseif
"echo "error:The filetype is not included!"
"endif
"endfunc

"function DoOneFileMake()
"if(expand("%:p:h")!=getcwd())
"echohl WarningMsg | echo "Fail to make! This file is not in the current dir! Press redirect to the dir of this file."
"endif
"exec "w"
"call SetCompilation()
"exec "make"
"exec "copen"
"endfunction

"function SetCompilation()
"if &filetype=='c'
"set makeprg=gcc\ %\ -o\ %<
"elseif &filetype=='cpp'
"set makeprg=g++\ %\ -o\ %<
"endif
"endfunction

"map <C-F5> :call CompileRun()<cr>
""ctrl+F6一键make C/C++程序
"nmap <C-F6> :call DoOneFileMake()<CR><CR>
"============设置<Fn>快捷键==============={{{2
nnoremap <F5> :NERDTreeToggle<CR>
nnoremap <silent><F6> :TagbarToggle<CR>
nnoremap <f7> :UndotreeToggle<cr>
"nnoremap <f8> :YRShow<CR>
"================
nmap <F9> :SCCompile<cr>
nnoremap <f3> :lnext<cr>
nnoremap <f4> :lprevious<cr>
"============gvim使用ctr+F1显示/取消工具栏===============
set guioptions-=m
set guioptions-=T
map <silent> <C-F1> :if &guioptions =~# 'T' <Bar>
            \set guioptions-=T <Bar>
            \set guioptions-=m <Bar>
            \else <Bar>
            \set guioptions+=T <Bar>
            \set guioptions+=m <Bar>
            \endif<CR>


"============== 按ctrl+F3把所有buffer变成tab显示出来=========
let notabs = 1
nnoremap <silent> <C-F3> :let notabs=!notabs<Bar>:if notabs<Bar>:tabo<Bar>:else<Bar>:tab ball<Bar>:tabn<Bar>:endif<CR>





"}}}
"}}}


"--------------------------------------------------------------------------------------
"Vundle 插件管理软件{{{
"插件相关{{{1
" Setting up Vundle - the vim plugin bundler
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle..."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let iCanHazVundle=0
endif

filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
"}}}
"
"
" editor
Bundle 'ervandew/supertab'
Bundle 'mbbill/fencview'
Bundle 'gmarik/vundle'
Bundle 'majutsushi/tagbar'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'kien/ctrlp.vim'
Bundle 'junegunn/fzf'
"Bundle 'jmcantrell/vim-virtualenv'
Bundle 'tpope/vim-repeat'
Bundle 'scrooloose/nerdcommenter'
Bundle 'terryma/vim-expand-region'
Bundle 'airblade/vim-gitgutter'
Bundle 'Xuyuanp/git-nerdtree'
Bundle 'spiiph/vim-space'
Bundle 'tpope/vim-surround'
Bundle 'godlygeek/tabular'
Bundle 'vim-scripts/L9'
"Bundle 'vim-scripts/YankRing.vim'
Bundle 'dkprice/vim-easygrep'
Bundle 'mileszs/ack.vim'
Bundle 'mbbill/undotree'

"output & colorscheme
Bundle 'vim-scripts/Mark--Karkat'
Bundle 'Yggdroot/indentLine'
Plugin 'kien/tabman.vim' " Tab list panel
Bundle 'Lokaltog/vim-powerline'
Bundle 'fisadev/fisa-vim-colorscheme'
Plugin 'altercation/vim-colors-solarized'
Plugin 'crusoexia/vim-monokai'
Plugin 'tpope/vim-fugitive' "git wrapper
Plugin 'h1mesuke/unite-outline' "Provide your Vim's buffer with the outline view

" General Programming
Bundle 'w0rp/ale'
Bundle 'ihacklog/AuthorInfo'
Bundle 'Chiel92/vim-autoformat'
"Bundle 'jiangmiao/auto-pairs'
Plugin 'junegunn/vim-easy-align' "对齐
Plugin 'terryma/vim-multiple-cursors' "多word编辑
Plugin 'Raimondi/delimitMate' "Provides automatic closing of quotes, parenthesis, brackets, etc.
" Bundle 'xuhdev/singleCompile'


" Snippets && AutoComplete
Bundle 'Valloric/YouCompleteMe'
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'
Bundle 'djoshea/vim-autoread'

"Python
"Bundle 'python-mode/python-mode'
Bundle 'yssource/python.vim'
Bundle 'python_match.vim'
Bundle 'pythoncomplete'

" rust
Bundle 'rust-lang/rust.vim'
Plugin 'phildawes/racer'

" go
"Bundle 'cespare/vim-golang'
"Bundle 'Blackrush/vim-gocode'
Bundle 'fatih/vim-go'

" html
Bundle 'alvan/vim-closetag'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'gorodinskiy/vim-coloresque'
Bundle 'tpope/vim-haml'
Bundle 'wavded/vim-stylus'
Bundle 'posva/vim-vue'
Bundle 'mattn/emmet-vim'

" javascript
"Bundle 'ternjs/tern_for_vim'
" Paint css colors with the real color
Bundle 'lilydjwg/colorizer'
" XML/HTML tags navigation
Bundle 'matchit.zip'
Bundle 'mxw/vim-jsx'
Bundle 'justinj/vim-react-snippets'

Bundle 'rhysd/conflict-marker.vim'
Bundle 'luochen1990/rainbow'



filetype indent on
filetype plugin on

" Install plugins the first time vim runs
if iCanHazVundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif
"}}}

"auto format{{{
"let g:formatdef_autopep8 = "'autopep8 - --range '.a:firstline.' '.a:lastline"
"let g:formatters_python = ['autopep8']

let g:formatter_yapf_style = 'google' "  pip install yapf futures
let g:formatters_rust = ['rustfmt']
noremap <Leader>f :Autoformat<CR>
"au BufWrite * :Autoformat " format on save
"}}}


"nerdtree{{{
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$' ]
let g:netrw_home='~/bak'
"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | end
let NERDTreeQuitOnOpen=0
"}}}

"indentLine {{{
let g:indentLine_noConcealCursor = 1
let g:indentLine_color_term = 0
let g:indentLine_char = '¦'
let g:indent_guides_guide_size=1
"}}}

"{{{ undotree
if has("persistent_undo")
    set undodir='~/.vim-undodir/'
    set undofile
endif
"}}}

"tagbar  成员、函数信息栏{{{2
"let tagbar_left=1
let tagbar_autofocus=0
let g:tagbar_expand=1
let g:tagbar_foldlevel=2
let g:tagbar_autoshowtag=1
let g:tagbar_width=25
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }
"}}}

"NERD_commenter  注释插件{{{
"<leader>ca ->在可选的注释方式之间切换，比如C/C++ 的块注释/* */和行注释//
"<leader>cc ->注释当前行
"<leader>cs ->以”性感”的方式注释
"<leader>cA ->在当前行尾添加注释符，并进入Insert模式
"<leader>cu ->取消注释
"<leader>cm ->添加块注释
"<leader>c<space> ->注释/取消注释
"<leader>ci ->注释选中行
"<leader>cs ->性感的方式注释
"}}}

"matchit    快速跳转到配对符号的标签{{{
"version 1.13.2 2008-01-29
"let g:loaded_matchit=1
"}}}

"authorinfo.vim      自动添加作者信息{{{
"（需要和NERD_commenter联用)使用,:AuthorInfoDetect呼出
"version 1.5        2011-08-18
let g:vimrc_author='linfeng.yuan'
let g:vimrc_email='linfeng.yuan@woqutech.com'
let g:vimrc_homepage='www.woqutech.com'
"}}}

"fencview   自动检测文件编码 {{{
"Tools->Encoding->Auto Detect" or use this command: :FencAutoDetect
"}}}

"menus of SingleCompile to show in the menu bar{{{
let g:SingleCompile_menumode = 2
"}}}

"ctrlp 文件搜索{{{
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
map <leader>f :CtrlPMRU<CR>
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc    " MacOSX/Linux"
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
            \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz)$',
            \ }
"\ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1
"}}}

"delimitMate,自动补全{{{
" for python docstring ",优化输入
au FileType python let b:delimitMate_nesting_quotes = ['"']

"BreakLine: Return TRUE if in the middle of {} or () in INSERT mode
fun BreakLine()
    if (mode() == 'i')
        return ((getline(".")[col(".")-2] == '{' && getline(".")[col(".")-1] == '}') ||
                    \(getline(".")[col(".")-2] == '(' && getline(".")[col(".")-1] == ')'))
    else
        return 0
    endif
endfun

" Remap <Enter> to split the line and insert a new line in between if
" BreakLine return True
inoremap <expr> <CR> BreakLine() ? "<CR><ESC>O" : "<CR>"
"}}}

"Yankring {{{
" store yankring history file there too
"let g:yankring_history_dir = '~/.vim/dirs/'
"}}}

" 具体语言语法高亮 {{{

" for python.vim syntax highlight
Bundle 'hdima/python-syntax'
let python_highlight_all = 1

" for golang
Bundle 'jnwhiteh/vim-golang'

"for jinja2 highlight
Bundle 'Glench/Vim-Jinja2-Syntax'

"for nginx conf file highlight.   need to confirm it works
"Bundle 'thiderman/nginx-vim-syntax'

" for markdown
Plugin 'plasticboy/vim-markdown'
" let g:vim_markdown_folding_disabled=1
"}}}

""ale语法检查{{{
"set statusline+=%{LEGetStatusLine()}
"let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']

let g:ale_sign_column_always = 1
let g:ale_linters = {
            \   'javascript': ['eslint'],
            \   'python': ['pylint'],
            \    'rust': ['rustc']
            \}


let g:ale_sign_error = '⨉'
let g:ale_sign_warning = '⚠'
let g:ale_echo_msg_error_str = 'Error'
let g:ale_echo_msg_warning_str = 'Warn'
let g:ale_echo_msg_format = ' [%severity%] %s [%linter%] '

command! CP :call ale#loclist_jumping#Jump('before', 1)
command! CN :call ale#loclist_jumping#Jump('after', 1)

let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_save = 1
let g:ale_set_quickfix = 0

"}}}

"YouCompleteMe 代码补全插件{{{
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 0
let g:ycm_confirm_extra_conf = 0
let g:ycm_error_symbol = '✗'
let g:ycm_warning_symbol = '>!'
"let g:ycm_filetype_specific_completion_to_disable = {'python':1, 'txt':1}
let g:ycm_filetype_blacklist = {
            \ 'tagbar' : 1,
            \ 'qf' : 1,
            \ 'notes' : 1,
            \ 'markdown' : 1,
            \ 'unite' : 1,
            \ 'text' : 1,
            \ 'vimwiki' : 1,
            \ 'pandoc' : 1,
            \ 'mail' : 1
            \}
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
nnoremap <leader>gc :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:acp_enableAtStartup = 0

" enable completion from tags
let g:ycm_collect_identifiers_from_tags_files = 1
" rust
let g:ycm_rust_src_path="/usr/local/src/rust/src"
let $RUST_SRC_PATH="/usr/local/src/rust/src"
let g:racer_cmd= "/usr/local/bin/racer"

" remap Ultisnips for compatibility for YCM
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" Haskell post write lint and check with ghcmod
" $ `cabal install ghcmod` if missing and ensure
" ~/.cabal/bin is in your $PATH.
if !executable("ghcmod")
    autocmd BufWritePost *.hs GhcModCheckAndLintAsync
endif

" For snippet_complete marker.
if !exists("g:evervim_no_conceal")
    if has('conceal')
        set conceallevel=2 concealcursor=i
    endif
endif

" Disable the neosnippet preview candidate window
" When enabled, there can be too much visual noise
" especially when splits are used.
set completeopt-=preview
" ctrl+o : jump back
" ctrl+i : jump forward
"}}}

" author info{{{
function HeaderPython()
    call setline(1, "#!/usr/bin/env python")
    call append(1, "# -*- coding: utf-8 -*-")
    normal G
    normal o
    normal o
endf

autocmd bufnewfile *.py call HeaderPython()
"autocmd BufWritePre,BufRead *.py call AuthorInfoDetect
"map <leader>au :AuthorInfoDetect<CR>
"autocmd BufWritePost *.py normal <leader>au
autocmd Bufnewfile *.py normal <leader>au
"}}}

" easy grep {{{
let g:EasyGrepFilesToExclude="*.bak, *~, *.a, *.o, .svn,.git,.pyc"
let g:EasyGrepCommand=1
let g:EasyGrepIgnoreCase="off"
let g:EasyGrepMode=2
let g:EasyGrepRecursive=1
" }}}

"{{{ tagbar
let g:tagbar_type_go = {
            \ 'ctagstype' : 'go',
            \ 'kinds'     : [
            \ 'p:package',
            \ 'i:imports:1',
            \ 'c:constants',
            \ 'v:variables',
            \ 't:types',
            \ 'n:interfaces',
            \ 'w:fields',
            \ 'e:embedded',
            \ 'm:methods',
            \ 'r:constructor',
            \ 'f:functions'
            \ ],
            \ 'sro' : '.',
            \ 'kind2scope' : {
            \ 't' : 'ctype',
            \ 'n' : 'ntype'
            \ },
            \ 'scope2kind' : {
            \ 'ctype' : 't',
            \ 'ntype' : 'n'
            \ },
            \ 'ctagsbin'  : 'gotags',
            \ 'ctagsargs' : '-sort -silent'
            \ }

"}}}

" TabMan ------------------------------{{{
" mappings to toggle display, and to focus on it
let g:tabman_toggle = 'tl'
let g:tabman_focus  = 'tf'
"}}}

"go lang ----------------------------------{{{
let g:go_fmt_command = "goimports"
let g:go_snippet_engine = "neosnippet"
au FileType go nmap <leader>r <Bundle>(go-run)
au FileType go nmap <leader>b <Bundle>(go-build)
au FileType go nmap <leader>t <Bundle>(go-test)
au FileType go nmap <leader>c <Bundle>(go-coverage)
au FileType go nmap <Leader>ds <Bundle>(go-def-split)
au FileType go nmap <Leader>dv <Bundle>(go-def-vertical)
au FileType go nmap <Leader>dt <Bundle>(go-def-tab)
au FileType go nmap <Leader>gd <Bundle>(go-doc)
au FileType go nmap <Leader>gv <Bundle>(go-doc-vertical)
au FileType go nmap <Leader>gb <Bundle>(go-doc-browser)
"Show a list of interfaces which is implemented by the type under your cursor with <leader>s
au FileType go nmap <Leader>s <Bundle>(go-implements)
au FileType go nmap <Leader>i <Bundle>(go-info)
au FileType go nmap <Leader>e <Bundle>(go-rename)
"By default when :GoInstallBinaries is called, the binaries are installed to $GOBIN or $GOPATH/bin.  To change it
"let g:go_bin_path = expand("~/.gotools")
"let g:go_bin_path = "/usr/local/go/bin"  "or give absolute path
"}}}

"js ----------------------------------{{{
let g:jsx_ext_required = 0
"}}}

" Tabularize {{{
if isdirectory(expand("~/.vim/bundle/tabular"))
    nmap <Leader>a& :Tabularize /&<CR>
    vmap <Leader>a& :T, { 'on':  ['NERDTreeToggle', 'NERDTreeTabsToggle'] }abularize /&<CR>
    nmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
    vmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
    nmap <Leader>a=> :Tabularize /=><CR>
    vmap <Leader>a=> :Tabularize /=><CR>
    nmap <Leader>a: :Tabularize /:<CR>
    vmap <Leader>a: :Tabularize /:<CR>
    nmap <Leader>a:: :Tabularize /:\zs<CR>
    vmap <Leader>a:: :Tabularize /:\zs<CR>
    nmap <Leader>a, :Tabularize /,<CR>
    vmap <Leader>a, :Tabularize /,<CR>
    nmap <Leader>a,, :Tabularize /,\zs<CR>
    vmap <Leader>a,, :Tabularize /,\zs<CR>
    nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
    vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
endif
" }}}


"主题设置{{{1
syntax enable
set background=dark
let g:rehash256 = 1
let g:monokai_italic = 1
let g:monokai_thick_border = 1
colorscheme monokai
let g:solarized_termcolors=256
set background=dark
if exists('$TMUX')
    set term=screen-256color
endif
"}}}

" commands {{{1
command DP execute "!~/bin/pylint_switch.py disable"
command EP execute "!~/bin/pylint_switch.py enable"
" }}}

" Vim-Multi-Cursors {{{
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
" }}}

" AutoCloseTag {{{
" Make it so AutoCloseTag works for xml and xhtml files as well
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.xml, *.vue, *.rs, *.go"
" nmap <Leader>ac <Plug>ToggleAutoCloseMappings
" }}}

" Rainbow {{{
if isdirectory(expand("~/.vim/bundle/rainbow/"))
    let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
endif
"}}}


" EasyGrep {{{
let g:EasyGrepCommand = 1
let g:EasyGrepFilesToExclude=".pyc,tags,node_modules,.svn,.git"
"}}}

" fzf {{{

"{{{ If installed using Homebrew
set rtp+=/usr/local/opt/fzf
"}}}

"{{{ auto close
let delimitMate_matchpairs = "(:),[:],{:}"
let delimitMate_nesting_quotes = ['"','`']
let delimitMate_quotes = "\" ` "
imap  <C-g> <Plug>delimitMateJumpMany

"}}}
"   vim:foldmethod=marker foldlevel=1 textwidth=100
