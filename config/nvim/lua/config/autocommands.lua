vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "*.sh",
    command = "0r ~/.vim/templates/skeleton.sh"
})

vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "*.c",
    command = "0r ~/.vim/templates/skeleton.c"
})

vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "*.cpp",
    command = "0r ~/.vim/templates/skeleton.cpp"
})

vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "*.py",
    command = "0r ~/.vim/templates/skeleton.py"
})

vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = "Makefile",
    command = "0r ~/.vim/templates/skeleton.makefile"
})

vim.api.nvim_command([[ 
    autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%"))
]])

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
