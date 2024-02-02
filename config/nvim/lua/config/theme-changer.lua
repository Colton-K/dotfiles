local hour = os.date("*t").hour

if hour >= 7 and hour < 18 then
    vim.cmd("set background=light")
    vim.cmd("colorscheme zenbones")
else
    vim.cmd("set background=dark")
    vim.cmd("colorscheme gruvbox")
end
