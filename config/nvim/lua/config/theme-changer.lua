-- Define the path to the config file
local config_file = vim.fn.stdpath('config') .. '/color_mode'
local file = io.open(config_file, "r")

if file then
    -- Read the entire file contents
    local content = file:read("*a")

    -- Print the file contents
    content = content:gsub("\n", "")

    if content == "light" then
        vim.cmd("set background=light")
        vim.cmd("colorscheme zenbones")
    else
        vim.cmd("set background=dark")
        vim.cmd("colorscheme gruvbox")
    end

    -- Close the file
    file:close()
else
    print("Could not find color config file")
end
