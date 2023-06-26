-- TODO: https://alpha2phi.medium.com/modern-neovim-configuration-hacks-93b13283969f

-- Terminal cursor
vim.api.nvim_set_hl(0, "TerminalCursorShape", { underline = true })
vim.api.nvim_create_autocmd("TermEnter", {
  callback = function()
    vim.cmd([[setlocal winhighlight=TermCursor:TerminalCursorShape]])
  end,
})
vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    vim.cmd([[set guicursor=a:ver25]])
  end,
})

vim.api.nvim_create_autocmd("WinLeave", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "gitcommit" and vim.g.is_lazygit_opened then
      term = GetTerminalByName("(default) lazygit")
      term:toggle()
    end
  end,
})

vim.api.nvim_create_autocmd("BufLeave", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "toggleterm" and vim.g.has_previous_terminal_to_be_set then
      vim.g.previous_terminal = GetCurrentTerminal()
    end

    if vim.bo.filetype == "vira_menu" then
      vim.g.is_comming_from_vira = true
    end
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "vira_menu" then -- TODO: more excludes
      return
    end
    if vim.g.is_comming_from_vira and is_a_new_vira_chosen() then
      vim.g.VIRA_ISSUE = vim.g.vira_active_issue
      vim.notify("Set Jira Issue: " .. vim.g.VIRA_ISSUE)
      local timer = vim.loop.new_timer()
      timer:start(50, 0, vim.schedule_wrap(function()
        OpenOrCreateTerminal({
          instruction = "~/.config/nvim/update_git_branch.sh " .. vim.g.vira_active_issue,
          name = "Update Git Branch",
          direction = "horizontal"
        })
        local git_path = require("functions.utils").get_git_path()
        vim.g.VIRA_ISSUE_DESCRIPTION = vim.fn.system(
          "echo -n $(cut -d '_' -f 3- <<< $(cut -d '/' -f2 <<<$(git --git-dir=" ..
          git_path .. "/.git branch --show-current)) --output-delimiter=' ')")
        vim.g.is_comming_from_vira = false
      end))
    elseif vim.g.is_comming_from_vira == false then -- TODO: check if works when changin branch with fugitive
      set_vira_issue_from_branch()
    end
  end,
})

-- Automatically enter in insert mode
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == 'toggleterm' then
      vim.cmd("startinsert")
    end
  end
})

















-- TODO: THis is just a work around (witing for https://github.com/neovim/neovim/pull/22865)
vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesWindowUpdate',
  callback = function(args) vim.wo[args.data.win_id].relativenumber = true end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'FugitiveChanged',
  callback = function() set_vira_issue_from_branch() end,
})

-- Disable autoformat for lua files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "yaml", "yml" },
  callback = function()
    vim.b.autoformat = false
  end,
})
