-- Helper function
function chomped_system(cmd)
  local handle = io.popen(cmd)
  local result = handle:read("*a")
  handle:close()
  return result:gsub("\n+$", "")
end

-- Links a file to code.amazon.com to make it easy to share code links with others
function link_to_code_browser(start_line, end_line)
  local package_root = chomped_system("git rev-parse --show-toplevel")
  local package_name = package_root:match(".+/(.*)$")
  local file_path_relative_to_package_root = vim.fn.expand("%:p"):gsub(package_root, "")

  local url = "https://code.amazon.com/packages/"
    .. package_name
    .. "/blobs/mainline/--/"
    .. file_path_relative_to_package_root
    .. "?hl_lines="
    .. start_line
    .. "-"
    .. end_line
    .. "#line-"
    .. start_line

  vim.fn.setreg("+", url)
  print(url)
end

vim.cmd([[
  command! -range LinkToCodeBrowser lua link_to_code_browser(<line1>, <line2>)
]])
