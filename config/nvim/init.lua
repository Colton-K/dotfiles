require("config.autocommands")
require("config.shortcuts")
require("config.settings")

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
 --{ import = 'plugins' },
  require('plugins.list')
}, {})

require('plugins.telescope')
require('plugins.treesitter')
require('plugins.lsp')

require('config.theme-changer')

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
