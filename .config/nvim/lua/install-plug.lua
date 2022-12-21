local vim = vim
if vim.fn.empty(vim.fn.glob('~/.local/share/nvim/site/autoload/plug.vim')) > 0 then
  vim.api.nvim_command.execute('!curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
end
vim.cmd 'autocmd BufWritePost install-plug.lua PlugInstall'

local function plug(path, config)
  vim.validate {
    path = {path, 's'};
    config = {config, vim.tbl_islist, 'an array of packages'};
  }
  vim.fn["plug#begin"](path)
  for _, v in ipairs(config) do
    if type(v) == 'string' then
      vim.fn["plug#"](v)
    elseif type(v) == 'table' then
      local p = v[1]
      assert(p, 'Must specify package as first index.')
      v[1] = nil
      vim.fn["plug#"](p, v)
      v[1] = p
    end
  end
  vim.fn["plug#end"]()
end

plug('~/.config/nvim/plugged', {
  'editorconfig/editorconfig-vim',
  'nathanaelkane/vim-indent-guides',
  'vimwiki/vimwiki',
  'tpope/vim-surround',
  {'nvim-treesitter/nvim-treesitter', ['do'] = ':TSUpdate' },
--  {'windwp/nvim-ts-autotag', ['branch'] = 'main' },
  'mhartington/oceanic-next',
  --{'sonph/onehalf',  ['rtp'] = 'vim/' },
  'mhinz/vim-startify',
  'neovim/nvim-lspconfig',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/nvim-cmp',
  'nvim-lua/popup.nvim',
  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope.nvim'
})
