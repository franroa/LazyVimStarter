local M = {}

function M.split(source, delimiters)
  local elements = {}
  local pattern = '([^' .. delimiters .. ']+)'
  string.gsub(source, pattern, function(value) elements[#elements + 1] = value; end);
  return elements
end

function M.get_git_path()
  local dot_git_path = vim.fn.finddir(".git", ".;")
  return vim.fn.fnamemodify(dot_git_path, ":h")
end

return M
