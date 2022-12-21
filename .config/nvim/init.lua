require('install-plug')

--vim.api.nvim_command('set runtimepath+=/usr/local/opt/fzf')

--set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]

vim.o.lcs = [[tab:\|-,trail:•,extends:»,precedes:«,nbsp:␣]]

vim.wo.number = true -- line numbers on
vim.o.scrolloff = 5 --scroll offset to 5 lines
vim.o.lazyredraw = true -- should help with performance with macros
vim.o.wildmode = 'list:longest' -- suggestions on normal with longest list
vim.o.background = 'dark'

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.termguicolors = true
vim.cmd[[colorscheme OceanicNext]]


-- use ripgrep
--if executable('rg')
--  " Use rg over Grep
--  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
--  noremap \ :Rg<SPACE>
--
--  if !exists(':Rg')
--    command -nargs=+ -complete=file -bar Rg silent! grep! <args>|cwindow|redraw!
--  endif
--endif
--
--if executable('fzf')
--  noremap <C-p> :FZF<ENTER>
--endif

vim.api.nvim_set_keymap('n', '<C-p>', [[<cmd>lua require('telescope.builtin').find_files()<cr>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<C-F>', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], { noremap = true })

vim.cmd[[autocmd BufWritePost $MYVIMRC source $MYVIMRC]]

-- Press Space to turn off highlighting and clear any message already
-- displayed.
vim.api.nvim_set_keymap('n', '<Space><Space>', [[<cmd>nohlsearch<Bar>:echo<CR>]], { silent = true, noremap = true })


-- custom keys/etc
vim.g.mapleader = ',' -- move mapleader from \ to ,

--" map c-x and x-y to cut and paste in insert mode
--"let &clipboard = has('unnamedplus') ? 'unnamedplus' : 'unnamed'
--vm <c-x> "+x
--vm <c-c> "+y
--cno <c-v> <c-r>+
--" exe 'ino <script> <C-V>' paste#paste_cmd['i']
--"

--" use <tab> for trigger completion and navigate to the next complete item
--function! s:check_back_space() abort
--  let col = col('.') - 1
--  return !col || getline('.')[col - 1]  =~ '\s'
--endfunction

--inoremap <silent><expr> <Tab>
--      \ pumvisible() ? "\<C-n>" :
--      \ <SID>check_back_space() ? "\<Tab>" :
--      \ coc#refresh()

vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>a', 'ggVG', { noremap = true }) -- ,a is select all

-- lvim wiki
--let main_wiki = {}
--let main_wiki.syntax = 'markdown'
--let main_wiki.path = '~/wiki/'
--let g:vimwiki_list = [main_wiki]

-- use netrw like NERDTree
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 2
vim.g.netrw_winsize = 25

vim.api.nvim_set_keymap('n', '<C-n>', [[<cmd>Vexplore<Enter>]], { noremap = true })

vim.cmd[[autocmd VimResized * wincmd =]]

-- floating fzf
--if has('nvim')
--  let $FZF_DEFAULT_OPTS .= ' --layout=reverse'
--
--  function! FloatingFZF()
--    let width = float2nr(&columns * 0.9)
--    let height = float2nr(&lines * 0.6)
--    let opts = { 'relative': 'editor',
--       \ 'row': (&lines - height) / 2,
--       \ 'col': (&columns - width) / 2,
--       \ 'width': width,
--       \ 'height': height,
--       \ 'style': 'minimal'
--       \}
--    let buf = nvim_create_buf(v:false, v:true)
--    let win = nvim_open_win(buf, v:true, opts)
--    call setwinvar(win, '&winhl', 'NormalFloat:TabLine')
--  endfunction
--
--  let g:fzf_layout = { 'window': 'call FloatingFZF()' }
--endif

vim.g.startify_change_to_dir = 0

-- for cmp
vim.o.completeopt = "menu,menuone,noselect"
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- LSP
local nvim_lsp = require('lspconfig')
-- npm install -g typescript-language-server
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  -- if client.server_capabilities.document_formatting then
  -- for some reason python document_formatting is false
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    -- when chain is released
  vim.api.nvim_exec([[
    augroup lsp_autoformat
      autocmd! * <buffer>
      autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)
    augroup END
  ]], false)
  --end
  if client.server_capabilities.document_range_formatting then
    buf_set_keymap("v", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

local ts_on_attach = function(client, bufnr)
  client.server_capabilities.document_formatting = false
  on_attach(client, bufnr)
end

local eslint = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  lintIgnoreExitCode = true,
}

local prettier = {
  formatCommand = 'prettierd ${INPUT}',
  formatStdin = true
}

local black = {
  formatCommand = "black --quiet -",
  formatStdin = true
}

local flake8 = {
  lintCommand = 'flake8 --stdin-display-name ${INPUT} -',
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
}

-- yay efm-langserver
--npm install -g eslint_d @fsouza/prettierd
nvim_lsp.efm.setup {
  capabilities = capabilities,
  filetypes = {"javascript", "typescript", "javascriptreact", "typescriptreact", "python"},
  init_options = {documentFormatting = true},
  settings = {
    rootMarkers = {".eslintrc.js", "tsconfig.json", "setup.cfg", "setup.py", ".git/"},
    languages = {
      javascript = {prettier, eslint},
      typescript = {prettier, eslint},
      typescriptreact = {prettier, eslint},
      javascriptreact = {prettier, eslint},
      python = { black, flake8 },
    }
  }
}

nvim_lsp.tsserver.setup {
  capabilities = capabilities,
  on_attach = ts_on_attach
}


-- npm install -g pyright
nvim_lsp.pyright.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  init_options = {documentFormatting = false}
}

-- cmp
local cmp = require'cmp'
cmp.setup {
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  },
}
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- tree sitter
local nvim_ts_cfg = require'nvim-treesitter.configs'
nvim_ts_cfg.setup {
  ensure_installed = {
    "bash",
    "comment",
    "css",
    "dockerfile",
    "graphql",
    "go",
    "html",
    "javascript",
    "jsdoc",
    "json",
    "lua",
    "python",
    "regex",
    "toml",
    "tsx",
    "typescript",
    "yaml",
  },
  highlight = {
    enable = true
  },
  indent = {
    enable = true
  },
  incremental_selection = {
    enable = true
  },
}

-- TODO treesitter folding
