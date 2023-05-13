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

vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*/.git/COMMIT_EDITMSG",
  callback = function()
    if vim.g.vira_active_issue == "None" then
      vim.notify("No Jira Ticket defined", "ERROR")
    end

    local context = {
      COMMIT_TITLE = vim.g.vira_active_issue,
      BRANCH_NAME = vim.fn.system("echo -n $(git branch --show-current)"),
      AUTHOR = "Francisco Roa Prieto",
      JIRA_TICKET = vim.g.vira_active_issue,
    }
    local lnum = vim.fn.nextnonblank(1)

    while lnum and lnum < vim.fn.line("$") do
      -- vim.fn.setline(lnum, vim.fn.substitute(vim.fn.getline(lnum), "${\\w*}", context["\\=vim.fn.submatch(0)"], "g"))
      vim.fn.setline(lnum, vim.fn.substitute(vim.fn.getline(lnum), "${COMMIT_TITLE}", context["COMMIT_TITLE"], "g"))
      vim.fn.setline(lnum, vim.fn.substitute(vim.fn.getline(lnum), "${BRANCH_NAME}", context["BRANCH_NAME"], "g"))
      vim.fn.setline(lnum, vim.fn.substitute(vim.fn.getline(lnum), "${AUTHOR}", context["AUTHOR"], "g"))
      vim.fn.setline(lnum, vim.fn.substitute(vim.fn.getline(lnum), "${JIRA_TICKET}", context["JIRA_TICKET"], "g"))
      lnum = vim.fn.nextnonblank(lnum + 1)
    end
  end,
})



-- GO

local attach_to_buffer = require("functions.go.functions").attach_to_buffer

vim.api.nvim_create_autocmd("BufWritePost", {
  group = augroup("teej-automagic"),
  pattern = "*.go",
  callback = function()
    attach_to_buffer(vim.api.nvim_get_current_buf(), { "go", "test", "./...", "-json" })
  end
})
