-- ~/.config/nvim/init.vim

vim.o.hidden = true -- Hide buffers that haven't been modified, rather than attempt to close them.
vim.o.autoread = true -- Automatically read external file changes.
vim.o.backspace = 'indent,eol,start' -- More powerful backspacing.
vim.o.errorbells = false -- Do not sound annoying MacOS error bells sound.
vim.o.tabstop = 2 -- Tab size.
vim.o.softtabstop = 2 -- Tab size.
vim.o.shiftwidth = 2 -- Shifting lines size.
vim.o.expandtab = true -- Tabs are converted to spaces.
vim.o.smartindent = true -- Vim will try to automatically indent cleverly.
vim.o.number = true -- Show line numbers.
vim.o.relativenumber = true -- Show relative line numbers.
vim.o.ignorecase = true -- Cases are ignored while searching with /.
vim.o.smartcase = true -- Searching with / will be case-insensitive until a capital letter is introduced.
vim.o.swapfile = false -- Do not create swapfiles.
vim.o.undofile = true -- Keep a history of undos in a file.
vim.o.backup = false -- Create no backup files. Think this isn't critical because we set undo files.
vim.o.undodir = '~/.vim/undodir' -- The directory in which to place undo files. ⚠️  This directory will not be created by vim.
vim.o.incsearch = true -- Searching with / will continually show and highlight results.
vim.o.hlsearch = true -- Search matches are highlighted.
vim.o.ttimeoutlen = 0 -- Key code timeouts are instant, causing ESC to be more responsive, but disallows its use in sequences.
vim.o.scrolloff = 5 -- Amount of lines to show at the bottom/top of screen when nearing edge.
vim.o.clipboard = 'unnamedplus' -- Use system clipboard for yanks.
vim.o.cursorline = true -- Highline line of cursor.
vim.o.regexpengine = 1 -- Use old regex engine, which can boost performance.
vim.o.termguicolors = true -- Use true colors rather than what $TERM supports.
vim.o.wrap = false -- Do not wrap overflowing lines to next line.
-- set list listchars=nbsp:€ -- Show NBSP characters as euro sign to help identify mishaps.

vim.g.mapleader = ' ' -- Leader key is space.
vim.g.netrw_fastbrowse = 0 -- Wipe/delete netrw buffers when exiting it.
vim.g.netrw_liststyle = 3 -- Display tree structure in netrw.

-- packadd cfilter -- Activate the cfilter plugin, see :h cfilter

-- Syntax highlight from beginning of active buffer for best results.
-- autocmd BufEnter * :syntax sync fromstart
-- Clear syntax when leave buffer for performance.
-- autocmd BufLeave * :syntax sync clear

-- Easier end of line motion for win keyboard.
-- noremap ½ $

local nore_silent = { noremap = true, silent = true }

-- Switch to last used buffer using backspace.
vim.api.nvim_set_keymap('n', '<BS>', '<C-^><CR>', nore_silent)

-- Window naviagtion.
vim.api.nvim_set_keymap('n', '<leader>h', ':wincmd h<CR>', nore_silent)
vim.api.nvim_set_keymap('n', '<leader>l', ':wincmd l<CR>', nore_silent)
vim.api.nvim_set_keymap('n', '<leader>j', ':wincmd j<CR>', nore_silent)
vim.api.nvim_set_keymap('n', '<leader>k', ':wincmd k<CR>', nore_silent)

-- Quickfix list naviagtion.
vim.api.nvim_set_keymap('n', '<silent><leader>J', ':cnext<CR>', nore_silent)
vim.api.nvim_set_keymap('n', '<silent><leader>K', ':cprev<CR>', nore_silent)

-- Search for string when selected in visual mode mapping.
vim.api.nvim_set_keymap('v', '<leader>f', 'y/<c-r>0', { noremap = true })

-- File explorer mapping.
vim.api.nvim_set_keymap('n', '<leader>A', ':Explore<cr>', nore_silent)

--[[
-- .vimrc command to edit or source.
command! Rc if bufname('%') =~# '\.vimrc' | source % |
      \ else | edit ~/.vimrc |
      \ endif
--]]

-- Plugin manager: https://github.com/wbthomason/packer.nvim#quickstart
require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Color schemes.
  use 'tomasr/molokai'
  use 'w0ng/vim-hybrid'
  use 'NLKNguyen/papercolor-theme'

  -- Configurations for Nvim LSP.
  use 'neovim/nvim-lspconfig'

  -- LSP completions.
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'

  -- Fuzzy file finder.
  use {
    'junegunn/fzf.vim',
    run = 'brew install bat',
    requires = {{'junegunn/fzf'}},
  }
  vim.g.fzf_layout = { window = { width = 1, height = 1 } } -- FZF window fill entire screen.
  vim.api.nvim_set_keymap('n', '<leader><space>', ':Buffers<CR>', nore_silent)
  vim.api.nvim_set_keymap('n', '<leader>f', ':GFiles<CR>', nore_silent)
  vim.api.nvim_set_keymap('n', '<leader>F', ':Ag<CR>', nore_silent)
  vim.api.nvim_set_keymap('n', '<leader>F', 'y:Ag <c-r>0<CR>', nore_silent)
  -- command! -bang -nargs=+ -complete=dir Rag call fzf#vim#ag_raw(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0) -- Use <:Rag 'query' path> to search for ag matches in specific folder

  -- Change surrounding delimiter with cs<d><d> (eg. cs"{ )
  use 'tpope/vim-surround'

  -- Git client using :G <command> (eg. :G rebase -i )
  use 'tpope/vim-fugitive'
  vim.api.nvim_set_keymap('n', '<leader>g', ':G<space>', { noremap = true })

  -- Toggle code comments using cc (or with motion: 2cc )
  use 'scrooloose/nerdcommenter'
  vim.g.NERDCreateDefaultMappings = 1
  vim.g.NERDSpaceDelims = 1
  vim.g.NERDCommentEmptyLines = 1
  vim.g.NERDDefaultAlign = 'left'

  -- Undo steps manager and overview.
  use 'mbbill/undotree'
  vim.api.nvim_set_keymap('n', '<leader>U', ':UndotreeToggle<CR>:UndotreeFocus<CR>', nore_silent)

  -- Automatically close blocks with end, endif, etc.
  -- use 'tpope/vim-endwise'

  -- FZF for git branches.
  use 'stsewd/fzf-checkout.vim'
  vim.api.nvim_set_keymap('n', '<leader>B', ':GBranches!<CR>', { noremap = true })

  -- Hex color highlights in code.
  use 'lilydjwg/colorizer'
  vim.g.colorizer_maxlines = 1000 -- Important for performance. Really slow in large buffers, so limit to 1k lines.

  -- Enhances netrw. Use - in any buffer to access. Then use I for netrw info.
  use 'tpope/vim-vinegar'

  -- I18n tooling.
  use 'airblade/vim-localorie'
  vim.api.nvim_set_keymap('n', '<leader>lt', ':call localorie#translate()<CR>', { noremap = true })
  vim.api.nvim_set_keymap('n', '<leader>le', ':call localorie#expand_key()<CR>', { noremap = true })

  -- Paranthesis autocomplete and other goodies.
  use 'tmsvg/pear-tree'
  
  -- Language support.
  use 'vim-ruby/vim-ruby' -- Syntax highlighting, indentation.
  use 'tpope/vim-rails' -- Syntax highlighting, identation, commands, go to file ( gf )
  use 'pangloss/vim-javascript' -- Syntax highlighting, indentation.
  use 'leafgarland/typescript-vim' -- Syntax highlighting, indentation.
  use 'maxmellon/vim-jsx-pretty' -- Syntax highlighting, indentation.
  use 'jparise/vim-graphql' -- Syntax highlighting, indentation.
end)

-- LSP and completion (cm)
local lspconfig = require('lspconfig')
local cmp = require('cmp')
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Set the color scheme.
vim.cmd('color PaperColor')

cmp.setup({
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
    })
  })

lspconfig.tsserver.setup({ capabilities = capabilities })
lspconfig.solargraph.setup({ capabilities = capabilities })

-- Hardmode >:D
local illegalKeys = { '<Up>', '<Down>', '<Left>', '<Right>' }
for i = 1, 4 do
  vim.api.nvim_set_keymap('n', illegalKeys[i], '<Nop>', { noremap = true })
  vim.api.nvim_set_keymap('i', illegalKeys[i], '<Nop>', { noremap = true })
end
