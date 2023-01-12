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
vim.o.backup = false -- Create no backup files. Think this isn't critical because we set undo files.
vim.o.undodir = vim.fn.stdpath('config') .. '/undo' -- The directory in which to place undo files.
vim.o.undofile = true -- Keep a history of undos in a file.
vim.o.incsearch = true -- Searching with / will continually show and highlight results.
vim.o.hlsearch = true -- Search matches are highlighted.
vim.o.ttimeoutlen = 0 -- Key code timeouts are instant, causing ESC to be more responsive, but disallows its use in sequences.
vim.o.scrolloff = 5 -- Amount of lines to show at the bottom/top of screen when nearing edge.
vim.o.clipboard = 'unnamedplus' -- Use system clipboard for yanks.
vim.o.cursorline = true -- Highline line of cursor.
vim.o.termguicolors = true -- Use true colors rather than what $TERM supports.
vim.o.wrap = false -- Do not wrap overflowing lines to next line.
vim.o.mouse = '' -- Disable mouse.
vim.cmd('set list listchars=nbsp:€') -- Show NBSP characters as euro sign to help identify mishaps.
vim.g.mapleader = ' ' -- Leader key is space.
 
local nore_silent = { noremap = true, silent = true }

-- Hardmode >:D
for _, key in pairs({ '<Up>', '<Down>', '<Left>', '<Right>' }) do
  vim.keymap.set('n', key, ':echo "No. Stop."<CR>', { noremap = true })
  vim.keymap.set('i', key, ':echo "No. Stop."<CR>', { noremap = true })
end

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

-- Switch to last used buffer (alternate) using backspace.
vim.keymap.set('n', '<BS>', '<C-^><CR>', nore_silent)

-- Search for string when selected in visual mode mapping.
vim.keymap.set('v', '<leader>f', 'y/<c-r>0', { noremap = true })

-- Yank current path to clipboard using <Y>.
vim.keymap.set('n', 'Y', ':let @+ = expand("%")<CR>')

-- .vimrc command to edit or source.
vim.cmd([[
command! Rc if bufname('%') =~# '\.config\/nvim\/init.lua' | source % |
      \ else | edit ~/.config/nvim/init.lua |
      \ endif
]])

-- Rename current file command: :Rename new_name.md
vim.cmd("command! -nargs=1 Rename saveas %:h/<args> | call delete(expand('#')) | bd #")

-- Plugin manager: https://github.com/wbthomason/packer.nvim#quickstart
require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  
  -- Presents LSP autocompletion results in a nice popup.
  use 'hrsh7th/nvim-cmp'
  -- Sources for cmp completions.
  use 'hrsh7th/cmp-nvim-lsp' -- Get autocompletions from LSP.
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  -- Cmp snippet engine:
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  
  -- Language support.
  use 'vim-ruby/vim-ruby' -- Syntax highlighting, indentation.
  use 'tpope/vim-rails' -- Syntax highlighting, identation, commands, go to file ( gf )
  use 'pangloss/vim-javascript' -- Syntax highlighting, indentation.
  use 'leafgarland/typescript-vim' -- Syntax highlighting, indentation.
  use 'maxmellon/vim-jsx-pretty' -- Syntax highlighting, indentation.
  use 'jparise/vim-graphql' -- Syntax highlighting, indentation.
  
  -- File explorer. Use '-' to open buffer parent folder.
  use 'justinmk/vim-dirvish'
  
  -- YAML tooling.
  use 'cuducos/yaml.nvim'

  -- Change surrounding delimiter with cs<d><d> (eg. cs"{ )
  use 'tpope/vim-surround'

  -- Recursively make missing directories when saving a buffer.
  use 'jghauser/mkdir.nvim'

  -- Color theme.
  use { 'NLKNguyen/papercolor-theme', config = function()
    vim.cmd('color PaperColor')
  end }
  
  -- Configurations for language servers.
  use { 'neovim/nvim-lspconfig', config = function()
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { noremap = true })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { noremap = true })
    vim.keymap.set('n', '<leader>aa', vim.lsp.buf.code_action, { noremap = true })
    vim.keymap.set('n', '<leader>ar', vim.lsp.buf.rename, { noremap = true })
    vim.keymap.set('n', '<S-k>', vim.lsp.buf.hover, { noremap = true })
  end }

  -- Commenting plugin. Use <leader>cc to comment lines.
  use { 'numToStr/Comment.nvim', config = function()
    require('Comment').setup({
      toggler = {
        line = '<leader>cc',
        block = '<leader>bc',
      },
      opleader = {
        line = '<leader>cc',
        block = '<leader>bc',
      },
    })
  end }

  -- Highlight word under cursor.
  use { 'yamatsum/nvim-cursorline', config = function() 
    require('nvim-cursorline').setup({
      cursorline = { enable = false },
      cursorword = {
        enable = true,
        min_length = 3,
        hl = { underline = true },
      }
    })
  end }

  -- Shade windows not in focus.
  use { 'sunjon/shade.nvim', config = function()
    require('shade').setup({
      overlay_opacity = 70,
      opacity_step = 1,
      keys = {
        brightness_up = '<C-Up>',
        brightness_down = '<C-Down>',
        toggle = '<Leader>s',
      }
    })
  end }

  -- Display possible key stroke when starting a key sequence.
  use { 'folke/which-key.nvim', config = function()
    require('which-key').setup({})
  end }

  -- Installation helper for LSP servers and more.
  use {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end
  }
  
  -- Treesitter for better syntax highlighting.
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = { 'vim', 'lua', 'ruby', 'typescript', 'tsx', 'javascript', 'yaml', 'json', 'graphql', 'go', 'gomod', 'rust' },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end }
  
  -- Status line.
  use { 'nvim-lualine/lualine.nvim', config = function()
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
            path = 1, -- Show full path relative to working dir.
          },
        }
      },
    })
  end }

  -- Fuzzy search prompt window for several things. Useful for fuzzy file finders. Has native ripgrep and fzf integration.
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = { 'nvim-lua/plenary.nvim', '' }, config = function() 
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader><space>', builtin.buffers, nore_silent)
    vim.keymap.set('n', '<leader>f', builtin.find_files, nore_silent)
    vim.keymap.set('n', '<leader>F', builtin.live_grep, nore_silent)
    vim.keymap.set('v', '<leader>F', '"zy:Telescope grep_string default_text=<C-r>z<CR>', nore_silent)
    vim.keymap.set('n', '<leader>B', builtin.git_branches, nore_silent)

    local actions = require('telescope.actions')
    require('telescope').setup({
      defaults = {
        layout_strategy = 'flex',
        layout_config = { height = 0.95, width = 0.95 },
        mappings = {
          i = { ['<C-Q>'] = actions.smart_send_to_qflist + actions.open_qflist },
          n = { ['<C-Q>'] = actions.smart_send_to_qflist + actions.open_qflist },
        },
      },
      pickers = {
        grep_string = { only_sort_text = true }, -- Do not use prompt to filter filenames, only file content.
        live_grep = { only_sort_text = true },
        buffers = {
          ignore_current_buffer = true, -- Do not show current buffer in buffer telescope.
          sort_mru = true, -- Sorts the buffer telescope by mru (most recently used).
        },
      },
    })
  end }
  
  -- Git client using :G <command> (eg. :G rebase -i )
  use { 'tpope/vim-fugitive', config = function()
    vim.keymap.set('n', '<leader>g', ':G<space>', { noremap = true })
  end }

  -- Undo steps manager and overview.
  use { 'mbbill/undotree', config = function() 
    vim.keymap.set('n', '<leader>U', ':UndotreeToggle<CR>:UndotreeFocus<CR>', nore_silent)
  end }
  
  -- Hex color highlights in code.
  use { 'lilydjwg/colorizer', config = function()
    vim.g.colorizer_maxlines = 1000 -- Important for performance. Really slow in large buffers, so limit to 1k lines.
  end }
  
  -- Paranthesis autocomplete and other goodies.
  use { 'tmsvg/pear-tree', config = function() 
    vim.g.pear_tree_ft_disabled = { 'TelescopePrompt' } -- Disabled pear-tree in Telecsope popup, which would otherwise cause <CR> in Telescope insert mode to misbehave.
  end }
  
  -- Cycle though case styles (snake_case, camelCase) using tilde (~) by default. Overwritten to (z).
  use { 'icatalina/vim-case-change', config = function()
    vim.g.casechange_nomap = 1
    vim.keymap.set('v', 'z', '"zc<C-R>=casechange#next(@z)<CR><Esc>v`[', { noremap = true }) -- Default bind is tilde, but tilde sucks on nordic keyboards. Override bind to "z".
  end }
end)
-- End of plugin management.

-- LSP and completion engine (cmp) setup.
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

lspconfig['tsserver'].setup({ init_options = { preferences = { importModuleSpecifierPreference = 'relative' } }, capabilities = capabilities })
lspconfig['solargraph'].setup({ capabilities = capabilities })
lspconfig['cssls'].setup({ capabilities = capabilities })
lspconfig['clangd'].setup({ capabilities = capabilities })
lspconfig['cmake'].setup({ capabilities = capabilities })
lspconfig['gopls'].setup({ capabilities = capabilities })
lspconfig['dockerls'].setup({ capabilities = capabilities })
lspconfig['yamlls'].setup({ capabilities = capabilities })
lspconfig['rust_analyzer'].setup({ capabilities = capabilities })
