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
vim.o.undodir = '~/.vim_undodir' -- The directory in which to place undo files. ⚠️  This directory will not be created by vim.
os.execute('mkdir ~/.vim_undodir') -- Let's just ensure it exists.
vim.o.incsearch = true -- Searching with / will continually show and highlight results.
vim.o.hlsearch = true -- Search matches are highlighted.
vim.o.ttimeoutlen = 0 -- Key code timeouts are instant, causing ESC to be more responsive, but disallows its use in sequences.
vim.o.scrolloff = 5 -- Amount of lines to show at the bottom/top of screen when nearing edge.
vim.o.clipboard = 'unnamedplus' -- Use system clipboard for yanks.
vim.o.cursorline = true -- Highline line of cursor.
vim.o.regexpengine = 1 -- Use old regex engine, which can boost performance.
vim.o.termguicolors = true -- Use true colors rather than what $TERM supports.
vim.o.wrap = false -- Do not wrap overflowing lines to next line.
vim.o.mouse = '' -- Disable mouse.
-- Really slow: vim.o.shellcmdflag = '-ic' -- Set flags when invoking shell inside vim to act as 'interactive', which prompts bash/zsh to load .rc files (supports aliases).
vim.cmd('set list listchars=nbsp:€') -- Show NBSP characters as euro sign to help identify mishaps.
vim.cmd('color PaperColor') -- Set the color scheme.

vim.g.mapleader = ' ' -- Leader key is space.

local nore_silent = { noremap = true, silent = true }

-- Command to trash current file: :Rm
vim.cmd([[command! Rm :call system('zsh -c "trash %"') | bd]])

-- Command to rename current file: :Rename new_name.foo
vim.cmd("command! -nargs=1 Rename saveas <args> | call delete(expand('#')) | bd #")

-- Switch to last used buffer using backspace.
vim.keymap.set('n', '<BS>', '<C-^><CR>', nore_silent)

-- Yank current path to clipboard using <Y>.
vim.keymap.set('n', 'Y', ':let @+ = expand("%")<CR>')

-- Window naviagtion.
vim.keymap.set('n', '<leader>h', ':wincmd h<CR>', nore_silent)
vim.keymap.set('n', '<leader>l', ':wincmd l<CR>', nore_silent)
vim.keymap.set('n', '<leader>j', ':wincmd j<CR>', nore_silent)
vim.keymap.set('n', '<leader>k', ':wincmd k<CR>', nore_silent)

-- Quickfix list naviagtion.
vim.keymap.set('n', '<leader>J', ':cnext<CR>', nore_silent)
vim.keymap.set('n', '<leader>K', ':cprev<CR>', nore_silent)
vim.keymap.set('n', '<leader>H', ':colder<CR>', nore_silent)
vim.keymap.set('n', '<leader>L', ':cnewer<CR>', nore_silent)

-- Search for string when selected in visual mode mapping.
vim.keymap.set('v', '<leader>f', 'y/<c-r>0', { noremap = true })

-- File explorer mapping.
vim.keymap.set('n', '<leader>A', ':Dirvish<cr>', nore_silent)

-- LSP mapping. For completion, see cmp package and setup thereof.
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { noremap = true })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { noremap = true })
vim.keymap.set('n', '<leader>aa', vim.lsp.buf.code_action, { noremap = true })
vim.keymap.set('n', '<leader>ar', vim.lsp.buf.rename, { noremap = true })
vim.keymap.set('n', '<S-k>', vim.lsp.buf.hover, { noremap = true })

-- .vimrc command to edit or source.
vim.cmd([[
command! Rc if bufname('%') =~# '\.config\/nvim\/init.lua' | source % |
      \ else | edit ~/.config/nvim/init.lua |
      \ endif
]])

-- Rename current file command: :Rename new_name.md
vim.cmd("command! -nargs=1 Rename saveas %:h/<args> | call delete(expand('#')) | bd #")
-- vim.cmd("command! -nargs=1 Rename saveas %:h/<args>")

-- Plugin manager: https://github.com/wbthomason/packer.nvim#quickstart
require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Color schemes.
  use 'tomasr/molokai'
  use 'w0ng/vim-hybrid'
  use 'NLKNguyen/papercolor-theme'

  -- Configurations for Nvim LSP. Esentially just allows LSP to work.
  use 'neovim/nvim-lspconfig'

  -- Installation helper for LSP servers and more.
  use "williamboman/mason.nvim"

  -- Autocomplete popup framwork thingy.
  use 'hrsh7th/nvim-cmp'
  -- Cmp autocompletion sources:
  use 'hrsh7th/cmp-nvim-lsp' -- Get autocompletions from LSP.
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  -- Cmp snippet engine:
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  -- Treesitter for better syntax highlighting.
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Status line.
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- Fuzzy file finder.
  use {
    'junegunn/fzf.vim',
    run = 'brew install bat',
    requires = {{'junegunn/fzf'}},
  }
  vim.g.fzf_layout = { window = { width = 1, height = 1 } } -- FZF window fill entire screen.
  vim.cmd("command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)") -- https://github.com/junegunn/fzf.vim/issues/346#issuecomment-655446292
  vim.cmd("command! -bang -nargs=+ -complete=dir Rag call fzf#vim#ag_raw(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)") -- Use <:Rag 'query' path> to search for ag matches in specific folder
  vim.keymap.set('n', '<leader><space>', ':Buffers<CR>', nore_silent)
  vim.keymap.set('n', '<leader>f', ':GFiles<CR>', nore_silent)
  vim.keymap.set('n', '<leader>F', ':Ag<CR>', nore_silent)
  vim.keymap.set('v', '<leader>F', 'y:Ag <c-r>0<CR>', nore_silent)

  -- Change surrounding delimiter with cs<d><d> (eg. cs"{ )
  use 'tpope/vim-surround'

  -- Git client using :G <command> (eg. :G rebase -i )
  use 'tpope/vim-fugitive'
  vim.keymap.set('n', '<leader>g', ':G<space>', { noremap = true })

  -- Toggle code comments using cc (or with motion: 2cc )
  use 'scrooloose/nerdcommenter'
  vim.g.NERDCreateDefaultMappings = 1
  vim.g.NERDSpaceDelims = 1
  vim.g.NERDCommentEmptyLines = 1
  vim.g.NERDDefaultAlign = 'left'

  -- Undo steps manager and overview.
  use 'mbbill/undotree'
  vim.keymap.set('n', '<leader>U', ':UndotreeToggle<CR>:UndotreeFocus<CR>', nore_silent)

  -- FZF for git branches.
  use 'stsewd/fzf-checkout.vim'
  vim.keymap.set('n', '<leader>B', ':GBranches!<CR>', { noremap = true })

  -- Hex color highlights in code.
  use 'lilydjwg/colorizer'
  vim.g.colorizer_maxlines = 1000 -- Important for performance. Really slow in large buffers, so limit to 1k lines.

  -- I18n tooling.
  use 'airblade/vim-localorie'
  vim.keymap.set('n', '<leader>lt', ':call localorie#translate()<CR>', { noremap = true })
  vim.keymap.set('n', '<leader>le', ':echo localorie#expand_key()<CR>', { noremap = true })

  -- Paranthesis autocomplete and other goodies.
  use 'tmsvg/pear-tree'

  -- File explorer.
  use 'justinmk/vim-dirvish'

  -- Sneak-like leaping/searching through all splits.
  use 'ggandor/leap.nvim'

  -- YAML tooling.
  use 'cuducos/yaml.nvim'

  -- Cycle though case styles (snake_case, camelCase) using tilde (~).
  use 'icatalina/vim-case-change'
  vim.g.casechange_nomap = 1
  vim.keymap.set('v', 'z', '"zc<C-R>=casechange#next(@z)<CR><Esc>v`[', { noremap = true }) -- Default bind is tilde, but tilde sucks on nordic keyboards. Override bind to "z".
  
  -- Language support.
  use 'vim-ruby/vim-ruby' -- Syntax highlighting, indentation.
  use 'tpope/vim-rails' -- Syntax highlighting, identation, commands, go to file ( gf )
  use 'pangloss/vim-javascript' -- Syntax highlighting, indentation.
  use 'leafgarland/typescript-vim' -- Syntax highlighting, indentation.
  use 'maxmellon/vim-jsx-pretty' -- Syntax highlighting, indentation.
  use 'jparise/vim-graphql' -- Syntax highlighting, indentation.
end)

-- Leap (searching) setup.
require('leap').add_default_mappings()

-- Status line (lualine) setup.
require('lualine').setup({
  options = {
    icons_enabled = false,
    theme = 'onedark',
    component_separators = {},
    section_separators = {},
  },
  sections = {
    lualine_c = {
      {
        'filename',
        path = 1,
      },
    }
  },
})

-- Treesitter setup.
require('nvim-treesitter.configs').setup({
  ensure_installed = { 'lua', 'ruby', 'typescript', 'tsx', 'javascript', 'yaml', 'json' },
  auto_install = true,
  highlight = {
    enable = true,
    --additional_vim_regex_highlighting = { 'fugitive' }, -- Do not run native vim syntax highlighting, use treesitter only. (annoying in fugitive)
  },
  indent = {
    enable = true,
  },
})

-- Mason setup.
require('mason').setup()

-- LSP and completion (cmp) setup.
local lspconfig = require('lspconfig')
local cmp = require('cmp')
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-c>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  })
})

lspconfig['tsserver'].setup({ capabilities = capabilities })
lspconfig['solargraph'].setup({ capabilities = capabilities })
lspconfig['cssls'].setup({ capabilities = capabilities })
lspconfig['clangd'].setup({ capabilities = capabilities })
lspconfig['cmake'].setup({ capabilities = capabilities })
lspconfig['gopls'].setup({ capabilities = capabilities })
lspconfig['dockerls'].setup({ capabilities = capabilities })
lspconfig['yamlls'].setup({ capabilities = capabilities })

-- Hardmode >:D
local illegalKeys = { '<Up>', '<Down>', '<Left>', '<Right>' }
for i = 1, 4 do
  vim.keymap.set('n', illegalKeys[i], '<Nop>', { noremap = true })
  vim.keymap.set('i', illegalKeys[i], '<Nop>', { noremap = true })
end
