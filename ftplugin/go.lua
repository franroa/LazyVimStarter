local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

map("n", ",a", "<cmd>GoCodeAction<cr>", { desc = "Go code action" })
map("n", ",e", "<cmd>GoIfErr<cr>", { desc = "Add if err" })

-- Helper
map("n", ",ha", "<cmd>GoAddTag<cr>", { desc = "Add tags to struct" })
map("n", ",hr", "<cmd>GoRMTag<cr>", { desc = "Remove tag from struct" })
map("n", ",hc", "<cmd>GoCoverage<cr>", { desc = "Test coverage" })
map("n", ",hg", "<cmd>lua require('go.comment').gen()<cr>", { desc = "Generate comment" })
map("n", ",hv", "<cmd>GoVet<cr>", { desc = "Go vet" })
map("n", ",hr", "<cmd>GoModTidy<cr>", { desc = "Go mod tidy" })
map("n", ",hj", "<cmd>GoModInit<cr>", { desc = "Go mod init" })

map("n", ",i", "<cmd>GoToggleInlay<cr>", { desc = "Toggle inlay" })
map("n", ",l", "<cmd>GoLint<cr>", { desc = "Run linter" })
map("n", ",o", "<cmd>GoPkgOutline<cr>", { desc = "Outline" })
map("n", ",r", "<cmd>GoRun<cr>", { desc = "Run" })
map("n", ",s", "<cmd>GoFillStruct<cr>", { desc = "Autofill struct" })

-- Tests
map("n", ",tr", "<cmd>GoTest<cr>", { desc = "Run tests" })
map("n", ",ta", "<cmd>GoAlt!<cr>", { desc = "Open alt file" })
map("n", ",ts", "<cmd>GoAltS!<cr>", { desc = "Open alt file in split" })
map("n", ",tv", "<cmd>GoAltV!<cr>", { desc = "Open alt file in vertical split" })
map("n", ",tu", "<cmd>GoTestFunc<cr>", { desc = "Run test for current function" })
map("n", ",tf", "<cmd>GoTestFile<cr>", { desc = "Run test for current file" })

-- Code Lens
map("n", ",xl", "<cmd>GoCodeLenAct<cr>", { desc = "Toggle Lens" })
map("n", ",xa", "<cmd>GoCodeAction<cr>", { desc = "Code Action" })



map("n", ",j", "<cmd>'<,'>GoJson2Struct<cr>", { desc = "Json to struct" })


local vo = vim.opt_local
vo.tabstop = 4
vo.shiftwidth = 4
vo.softtabstop = 4

-- require("dap").setup()
