local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end
-- TODO https://alpha2phi.medium.com/modern-neovim-configuration-hacks-93b13283969f

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

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "gitcommit" then
      vim.cmd("/]:")
      vim.cmd("startinsert!")
    end
  end
})

vim.api.nvim_create_autocmd("BufLeave", {
  pattern = "*",
  callback = function()
    vim.notify("Test")
    if vim.bo.filetype == "gitcommit" and vim.g.is_lazygit_opened then
      term = GetTerminalByName("lazygit")
      term:toggle()
    end

    if vim.bo.filetype == "vira_menu" then
      vim.g.is_comming_from_vira = true
    end
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    if vim.g.is_comming_from_vira and is_a_new_vira_chosen() then
      vim.g.VIRA_ISSUE = vim.g.vira_active_issue
      vim.notify("Set Jira Issue: " .. vim.g.VIRA_ISSUE)
      OpenOrCreateTerminal({
        instruction = "~/.config/nvim/update_git_branch.sh " .. vim.g.vira_active_issue,
        name = "Update Git Branch"
      })
    elseif vim.g.is_comming_from_vira == false and is_a_new_vira_chosen() then -- TODO: check if works when changin branch with fugitive
      set_vira_issue_from_branch()
    end
  end,
})

-- vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
--   group = augroup("teej-automagic"),
--   pattern = "*.go",
--   callback = function()
--     require("functions.go.functions").attach_to_buffer(vim.api.nvim_get_current_buf(), { "go", "test", "./...", "-json" })
--   end
-- })


-- vim.api.nvim_create_autocmd("BufRead", {
--   pattern = "*/.git/COMMIT_EDITMSG",
--   callback = function()
--     if vim.g.vira_active_issue == "None" then
--       vim.notify("No Jira Ticket defined", "ERROR")
--     end
--
--     local context = {
--       COMMIT_TITLE = vim.g.vira_active_issue,
--       BRANCH_NAME = vim.fn.system("echo -n $(git branch --show-current)"),
--       AUTHOR = "Francisco Roa Prieto",
--       JIRA_TICKET = vim.g.vira_active_issue,
--     }
--     local lnum = vim.fn.nextnonblank(1)
--
--     while lnum and lnum < vim.fn.line("$") do
--       -- vim.fn.setline(lnum, vim.fn.substitute(vim.fn.getline(lnum), "${\\w*}", context["\\=vim.fn.submatch(0)"], "g"))
--       vim.fn.setline(lnum, vim.fn.substitute(vim.fn.getline(lnum), "${COMMIT_TITLE}", context["COMMIT_TITLE"], "g"))
--       vim.fn.setline(lnum, vim.fn.substitute(vim.fn.getline(lnum), "${BRANCH_NAME}", context["BRANCH_NAME"], "g"))
--       vim.fn.setline(lnum, vim.fn.substitute(vim.fn.getline(lnum), "${AUTHOR}", context["AUTHOR"], "g"))
--       vim.fn.setline(lnum, vim.fn.substitute(vim.fn.getline(lnum), "${JIRA_TICKET}", context["JIRA_TICKET"], "g"))
--       lnum = vim.fn.nextnonblank(lnum + 1)
--     end
--   end,
-- })
--       vim.fn.setline(lnum, vim.fn.substitute(vim.fn.getline(lnum), "${JIRA_TICKET}", context["JIRA_TICKET"], "g"))
--       lnum = vim.fn.nextnonblank(lnum + 1)
--     end
--   end,
-- })
--



-- Automatically enter in insert mode
-- vim.g.previous_window = -1
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == 'toggleterm' then
      -- if vim.g.previous_window ~= vim.api.nvim_win_get_number(0) then
      vim.cmd("startinsert")
      --   end
      --   vim.g.previous_window = vim.api.nvim_win_get_number(0)
      -- else
      --   vim.g.previous_window = -1
    end
  end
})
