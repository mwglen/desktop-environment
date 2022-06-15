call plug#begin('$XDG_CONFIG_HOME/nvim/plugged')
     
" Theme
Plug 'vim-airline/vim-airline'
Plug 'mwglen/wal.vim'
Plug 'ap/vim-css-color'
Plug 'glepnir/dashboard-nvim'

" Fuzzy Matching
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
     
" Syntax Highlighting
Plug 'sheerun/vim-polyglot'

" Autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
     
" Git Support
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
     
" Text Object Manipulation
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

" Prose
Plug 'reedes/vim-pencil'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'preservim/vim-lexical'
Plug 'preservim/vim-textobj-sentence'
Plug 'reedes/vim-wordy'
Plug 'tpope/vim-markdown'

" Notes
Plug 'vimwiki/vimwiki'
Plug 'mickael-menu/zk-nvim'

" Misc
Plug 'tpope/vim-repeat'
Plug 'lilydjwg/fcitx.vim'

call plug#end()

let g:fcitx5_remote = '/usr/bin/fcitx-remote'

" Required Vim Settings
set nocompatible
filetype plugin on
syntax on

" Use Markdown
let g:vimwiki_list = [{'path': '~/Documents/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

let w:ProseModeOn = 0

function EnableProseMode()
	setlocal spell spelllang=en_us
	Goyo 66
	SoftPencil
      Limelight
	echo "Prose Mode On"

      " open most folds
      setlocal foldlevel=6
endfu

function DisableProseMode()
	Goyo!
	NoPencil
	setlocal nospell
      Limelight!
	echo "Prose Mode Off"
endfu

function ToggleProseMode()
	if w:ProseModeOn == 0
		call EnableProseMode()
		let w:ProseModeOn = 1
	else
		call DisableProseMode()
	endif
endfu

command Prose call EnableProseMode()
command UnProse call DisableProseMode()
command ToggleProse call ToggleProseMode()

function ScratchBufferize()
	setlocal buftype=nofile
	setlocal bufhidden=hide
	setlocal noswapfile
endfu

nnoremap <Leader>d :new \| read ! sdcv <C-R><C-W> <CR>:call ScratchBufferize() <CR>:normal gg<CR>
nnoremap <Leader>t :new \| read ! moby <C-R><C-W> \| tr , '\n' <CR>:call ScratchBufferize() <CR>:normal gg2dd <CR>

set number relativenumber       " set line-numbers to be relative
set nohlsearch                  " no highlight search
set mouse=a                     " recognize and enable mouse


set tabstop=3                   " show existing tab as 4 spaces
set shiftwidth=3                " use 4 spaces when indenting with '>'
set expandtab                   " on pressing tab, insert 4 spaces

set ignorecase
set smartcase

set nobackup
    
let g:airline_powerline_fonts=1 " set airline style
let g:markdown_folding = 1
set clipboard^=unnamedplus      " Copy to system clipboard using "+

colorscheme wal                 " change the colorscheme
set guifont=RobotoMono\ Nerd\ Font:h10
set guifontwide=RobotoMono\ Nerd\ Font:h11.5

" Make autocomplete better:
"   - First tab completes as much as possible and provides list
"   - Second and subsequent tabs cycle through completion options
set wildmode=list:longest,full
set wildmenu

" %s/ctermbg=\(NONE\|\d\) ctermfg=\(NONE\|\d\).*/& guibg=\1 guifg=\2

" autocmd FileType markdown,mkd,text call EnableProseMode()
" autocmd FileType org call EnableProseMode()

autocmd BufWritePost ~/.Xresources !xrdb %

let g:ranger_replace_netrw = 1

let g:dashboard_default_executive ='fzf'

if has("gui_gtk2")
    function! FontSizePlus ()
      let l:gf_size_whole = matchstr(&guifont, '\( \)\@<=\d\+$')
      let l:gf_size_whole = l:gf_size_whole + 1
      let l:new_font_size = ' '.l:gf_size_whole
      let &guifont = substitute(&guifont, ' \d\+$', l:new_font_size, '')
    endfunction

    function! FontSizeMinus ()
      let l:gf_size_whole = matchstr(&guifont, '\( \)\@<=\d\+$')
      let l:gf_size_whole = l:gf_size_whole - 1
      let l:new_font_size = ' '.l:gf_size_whole
      let &guifont = substitute(&guifont, ' \d\+$', l:new_font_size, '')
    endfunction
else
    function! FontSizePlus ()
      let l:gf_size_whole = matchstr(&guifont, '\(:h\)\@<=\d\+$')
      let l:gf_size_whole = l:gf_size_whole + 1
      let l:new_font_size = ':h'.l:gf_size_whole
      let &guifont = substitute(&guifont, ':h\d\+$', l:new_font_size, '')
    endfunction

    function! FontSizeMinus ()
      let l:gf_size_whole = matchstr(&guifont, '\(:h\)\@<=\d\+$')
      let l:gf_size_whole = l:gf_size_whole - 1
      let l:new_font_size = ':h'.l:gf_size_whole
      let &guifont = substitute(&guifont, ':h\d\+$', l:new_font_size, '')
    endfunction
endif


" if has("gui_running")
nmap <F11> :call FontSizeMinus()<CR>
nmap <F12> :call FontSizePlus()<CR>
" endif

lua << EOF
-- ZK Config
require("zk").setup({
  picker = "fzf",

  lsp = {
    config = {
      cmd = { "zk", "lsp" },
      name = "zk",
    },

    auto_attach = {
      enabled = true,
      filetypes = { "markdown" },
    },
  },
})

local opts = { noremap=true, silent=false }

-- Create a new note after asking for its title.
vim.api.nvim_set_keymap("n", "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", opts)

-- Open notes.
vim.api.nvim_set_keymap("n", "<leader>zo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", opts)
-- Open notes associated with the selected tags.
vim.api.nvim_set_keymap("n", "<leader>zt", "<Cmd>ZkTags<CR>", opts)

-- Search for the notes matching a given query.
vim.api.nvim_set_keymap("n", "<leader>zf", "<Cmd>ZkNotes { sort = { 'modified' }, match = vim.fn.input('Search: ') }<CR>", opts)
-- Search for the notes matching the current visual selection.
vim.api.nvim_set_keymap("v", "<leader>zf", ":'<,'>ZkMatch<CR>", opts)

-- Add the key mappings only for Markdown files in a zk notebook.
if require("zk.util").notebook_root(vim.fn.expand('%:p')) ~= nil then
  local function map(...) vim.api.nvim_buf_set_keymap(0, ...) end
  local opts = { noremap=true, silent=false }
  
  -- Open the link under the caret.
  map("n", "<CR>", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  
  -- Create a new note after asking for its title.
  -- This overrides the global `<leader>zn` mapping to create the note in the same directory as the current buffer.
  map("n", "<leader>zn", "<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", opts)
  -- Create a new note in the same directory as the current buffer, using the current selection for title.
  map("v", "<leader>znt", ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>", opts)
  -- Create a new note in the same directory as the current buffer, using the current selection for note content and asking for its title.
  map("v", "<leader>znc", ":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", opts)

  -- Open notes linking to the current buffer.
  map("n", "<leader>zb", "<Cmd>ZkBacklinks<CR>", opts)
  -- Alternative for backlinks using pure LSP and showing the source context.
  --map('n', '<leader>zb', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- Open notes linked by the current buffer.
  map("n", "<leader>zl", "<Cmd>ZkLinks<CR>", opts)
  
  -- Preview a linked note.
  map("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  -- Open the code actions for a visual selection.
  map("v", "<leader>za", ":'<,'>lua vim.lsp.buf.range_code_action()<CR>", opts)
end
EOF
