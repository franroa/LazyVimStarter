local M = {}

function M.UpdateDevIconsInDropbar()
  M.UpdateGlobalValues()

  if vim.g.kubernetes_cluster == "" then
    require('dropbar').setup({
      icons = {
        kinds = { use_devicons = true },
      },
    })
    vim.cmd("colorscheme tokyonight")
    return
  end
  require('dropbar').setup({
    icons = {
      kinds = { use_devicons = false },
    },
  })
end

function M.UpdateGlobalValues()
  local cluster = vim.fn.system('echo -n "$(kubectl config current-context 2>/dev/null)"')
  if cluster == "" then
    vim.g.kubernetes_namespace = ""
    vim.g.kubernetes_cluster = ""
    return
  end


  local namespace = vim.fn.system("kubectl config view --minify -o jsonpath='{..namespace}'")
  if namespace == "" then
    namespace = "default"
  end

  vim.g.kubernetes_namespace = namespace
  vim.g.kubernetes_cluster = cluster
end

function M.UpdateHlValues()
  M.UpdateGlobalValues()

  local winbar_fg = "Green"
  local winbar_bg = "Yellow"
  local cluster_fg = "Black"
  local cluster_bg = "#DCEDC8"
  local namespace_fg = "Black"
  local namespace_bg = "#DCEDC8"

  vim.api.nvim_set_hl(0, "K8sCluster", { bold = true, fg = cluster_fg, bg = cluster_bg })
  vim.api.nvim_set_hl(0, "K8sNamespace", { bold = true, fg = namespace_fg, bg = namespace_bg })
  vim.api.nvim_set_hl(0, "WarningMsg", { bold = true, fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "Winbar", { bold = true, fg = winbar_fg, bg = winbar_bg })


  vim.api.nvim_set_hl(0, "DropBarIconKindArray", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindBoolean", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindBreakStatement", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindCall", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindCaseStatement", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindClass", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindConstant", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindConstructor", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindContinueStatement", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindDeclaration", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindDelete", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindDoStatement", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindElseStatement", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindEnum", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindEnumMember", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindEvent", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindField", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindFile", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindFolder", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindForStatement", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindFunction", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindIdentifier", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindIfStatement", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindInterface", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindKeyword", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindList", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindMacro", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindMarkdownH1", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindMarkdownH2", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindMarkdownH3", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindMarkdownH4", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindMarkdownH5", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindMarkdownH6", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindMethod", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindModule", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindNamespace", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindNull", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindNumber", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindObject", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindOperator", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindPackage", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindProperty", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindReference", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindRepeat", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindScope", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindSpecifier", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindStatement", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindString", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindStruct", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindSwitchStatement", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindType", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindTypeParameter", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindUnit", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindValue", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindVariable", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconKindWhileStatement", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconUIIndicator", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconUIPickPivot", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconUISeparator", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarIconUISeparatorMenu", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarMenuCurrentContext", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarMenuFloatBorder", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarMenuHoverEntry", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarMenuHoverIcon", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarMenuHoverSymbol", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarMenuNormalFloat", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarPreview", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindArray", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindBoolean", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindBreakStatement", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindCall", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindCaseStatement", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindClass", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindConstant", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindConstructor", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindContinueStatement", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindDeclaration", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindDelete", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindDoStatement", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindElseStatement", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindEnum", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindEnumMember", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindEvent", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindField", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindFile", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindFolder", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindForStatement", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindFunction", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindIdentifier", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindIfStatement", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindInterface", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindKeyword", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindList", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindMacro", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindMarkdownH1", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindMarkdownH2", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindMarkdownH3", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindMarkdownH4", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindMarkdownH5", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindMarkdownH6", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindMethod", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindModule", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindNamespace", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindNull", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindNumber", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindObject", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindOperator", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindPackage", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindaProperty", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindReference", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindRepeat", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindScope", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindSpecifier", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindStatement", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindString", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindStruct", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindSwitchStatement", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindType", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindTypeParameter", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindUnit", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindValue", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindVariable", { fg = winbar_fg, bg = winbar_bg })
  vim.api.nvim_set_hl(0, "DropBarKindWhileStatement", { fg = winbar_fg, bg = winbar_bg })
end

function M.Redraw()
  if vim.g.kubernetes_cluster == "" or vim.g.kubernetes_cluster == nil then
    vim.opt.winbar = ""
    return
  end

  M.UpdateHlValues()

  if string.match(vim.g.kubernetes_cluster, "dev") then
    vim.opt.winbar = "%#K8sIcon# 󱃾 "
        .. "%#K8sCluster#" .. vim.g.kubernetes_cluster
        .. "%#K8sNamespace# (" .. vim.g.kubernetes_namespace .. ")"
        .. "%#WarningMsg#    %=%#WarningMsg#You Are On A Shared Cluster! %#WarningMsg#   "
    return
  end

  vim.opt.winbar = "%#K8sIcon# 󱃾 "
      .. "%#K8sCluster#" .. vim.g.kubernetes_cluster
      .. "%#K8sNamespace# (" .. vim.g.kubernetes_namespace .. ")"
end

return M
