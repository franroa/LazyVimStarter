local M = {}

function M.Redraw()
  local winbar = ""
  vim.api.nvim_set_hl(0, "FileIcon", { blend = 50, fg = "Cyan" })
  vim.api.nvim_set_hl(0, "FileName", { blend = 50, fg = "Grey" })
  winbar = "%#FileIcon# %#FileName#%t"
  -- winbar = "%{%#FileIcon# %#FileName#%t}"

  local cluster = vim.fn.system('echo -n "$(kubectl config current-context 2>/dev/null)"')

  if cluster == "" then
    vim.opt.winbar = nil
    return
  end

  local namespace = vim.fn.system("kubectl config view --minify -o jsonpath='{..namespace}'")
  if namespace == "" then
    namespace = "default"
  end

  if string.match(cluster, "pi%-sandbox") and cluster ~= "pi-sandbox-francisco" then
    vim.api.nvim_set_hl(0, "KubernetesSymbpl", { fg = "Black", bg = "#DCEDC8" })
    vim.api.nvim_set_hl(0, "Namespace", { bold = true, fg = "Black", bg = "#DCEDC8" })
    vim.api.nvim_set_hl(0, "Context", { bold = true, fg = "Black", bg = "#DCEDC8" })
  end

  if cluster == "pi-sandbox-francisco" then
    vim.api.nvim_set_hl(0, "KubernetesSymbpl", { fg = "Black", bg = "Blue" })
    vim.api.nvim_set_hl(0, "Namespace", { bold = true, fg = "Black", bg = "Blue" })
    vim.api.nvim_set_hl(0, "Context", { bold = true, fg = "Black", bg = "Blue" })
  end

  if cluster == "kind-kind" then
    vim.api.nvim_set_hl(0, "KubernetesSymbpl", { fg = "Blue", bg = "#DCEDC8" })
    vim.api.nvim_set_hl(0, "Namespace", { bold = true, fg = "Green", bg = "#DCEDC8" })
    vim.api.nvim_set_hl(0, "Context", { bold = true, fg = "Red", bg = "#DCEDC8" })
  end

  if string.match(cluster, "dev") then
    vim.api.nvim_set_hl(
      0,
      "Warning",
      { underline = true, italic = true, standout = true, bold = true, fg = "Yellow", bg = "#E57373" }
    )
    vim.api.nvim_set_hl(0, "WarningSymbol", { fg = "Yellow", bg = "#E57373" })
    vim.api.nvim_set_hl(0, "KubernetesSymbpl", { bold = true, fg = "Blue", bg = "#E57373" })
    vim.api.nvim_set_hl(0, "Namespace", { bold = true, fg = "Red", bg = "#E57373" })
    vim.api.nvim_set_hl(0, "Context", { bold = true, fg = "Green", bg = "#E57373" })
  end

  if string.match(cluster, "dev") then
    winbar = "%#FileIcon# %#FileName#%t %#KubernetesSymbpl# 󱃾 %#Namespace#"
        .. namespace
        .. ":%#Context#"
        .. cluster
        .. "%#WarningSymbol#"
        .. "    "
        .. "%=%#Warning#You Are On A Shared Cluster! %#WarningSymbol#   "
  else
    winbar = "%#FileIcon#%#FileName# %t %#KubernetesSymbpl# 󱃾 %#Namespace#"
        .. namespace
        .. ":%#Context#"
        .. cluster
    --
  end

  vim.opt.winbar = winbar
end

return M
