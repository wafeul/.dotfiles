----------------------------------------------------------------------------------
-- Copilot
----------------------------------------------------------------------------------

vim.keymap.set("i", "<C-k>", 'copilot#Accept("\\<CR>")', {
	expr = true,
	replace_keycodes = false,
})
vim.g.copilot_no_tab_map = true

vim.keymap.set("i", "<C-l>", "<Plug>(copilot-accept-word)")
----------------------------------------------------------------------------------
-- Neoclip
----------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>nc", ":Telescope neoclip<CR>", {})
vim.keymap.set("n", "<leader>nm", ":Telescope macroscope<CR>", {})

----------------------------------------------------------------------------------
-- Spectre
----------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', {
	desc = "Toggle Spectre",
})
vim.keymap.set("n", "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
	desc = "Search current word",
})
vim.keymap.set("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
	desc = "Search current word",
})
vim.keymap.set("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
	desc = "Search on current file",
})

----------------------------------------------------------------------------------
-- Neotest
----------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>tn", function()
	require("neotest").run.run()
end)
vim.keymap.set("n", "<leader>tf", function()
	require("neotest").run.run(vim.fn.expand("%"))
end)

----------------------------------------------------------------------------------
-- DAP
----------------------------------------------------------------------------------

vim.keymap.set("n", "<leader>dt", function()
	require("dap").toggle_breakpoint()
end)
vim.keymap.set("n", "<leader>dc", function()
	require("dap").continue()
end)
vim.keymap.set("n", "<leader>du", function()
	require("dapui").toggle()
end)

----------------------------------------------------------------------------------
-- Transparent
----------------------------------------------------------------------------------

vim.keymap.set("n", "<leader>tr", ":TransparentToggle<CR>", {})

----------------------------------------------------------------------------------
-- LazyGit
----------------------------------------------------------------------------------

vim.keymap.set("n", "<leader>lg", ":LazyGit<CR>", {})
vim.keymap.set("n", "<leader>lc", ":LazyGitConfig<CR>", {})

----------------------------------------------------------------------------------
-- Telescope
----------------------------------------------------------------------------------

vim.keymap.set("n", "<leader>ff", function()
	require("telescope.builtin").find_files()
end)
vim.keymap.set("n", "<leader>fg", function()
	require("telescope.builtin").live_grep()
end)
vim.keymap.set("n", "<leader>fb", function()
	require("telescope.builtin").buffers()
end)
vim.keymap.set("n", "<leader>fh", function()
	require("telescope.builtin").help_tags()
end)

----------------------------------------------------------------------------------
-- NvimTree
----------------------------------------------------------------------------------

vim.keymap.set("n", "<leader>o", ":NvimTreeOpen<CR>", {})
vim.keymap.set("n", "<leader>c", ":NvimTreeClose<CR>", {})
vim.keymap.set("n", "<leader>f", ":NvimTreeFocus<CR>", {})

----------------------------------------------------------------------------------
-- LSP
----------------------------------------------------------------------------------

vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {})
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})

-- Disable ESLint LSP server and hide virtual text in Neovim
-- Add this to your init.lua or init.vim file
local isLspDiagnosticsVisible = true
vim.keymap.set("n", "<leader>lx", function()
	isLspDiagnosticsVisible = not isLspDiagnosticsVisible
	vim.diagnostic.config({
		virtual_text = isLspDiagnosticsVisible,
		underline = isLspDiagnosticsVisible,
	})
end)

----------------------------------------------------------------------------------
-- CodeCompanion / OpenCode
----------------------------------------------------------------------------------

-- Toggle the OpenCode chat
vim.keymap.set("n", "<leader>cc", "<cmd>CodeCompanionChat Toggle<CR>", {
	desc = "Toggle CodeCompanion chat",
})

-- CodeCompanion action palette
vim.keymap.set({ "n", "v" }, "<leader>cx", "<cmd>CodeCompanionActions<CR>", {
	desc = "CodeCompanion actions",
})

-- Prompt the OpenCode agent with editor context
vim.keymap.set({ "n", "v" }, "<leader>cp", function()
	return require("codecompanion").cli({ prompt = true })
end, {
	desc = "Prompt OpenCode agent",
})

-- Show files changed by the agent
vim.keymap.set("n", "<leader>cr", "<cmd>CodeCompanionChat Changes<CR>", {
	desc = "OpenCode changes",
})

vim.keymap.set("v", "<leader>ca", "<cmd>CodeCompanionChat Add<CR>", {
    desc = "Add selection to CodeCompanion chat",
})

----------------------------------------------------------------------------------
-- Personal shortcuts
----------------------------------------------------------------------------------
vim.keymap.set("i", "<c-a>", "<Esc>A", {})
-- vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
-- vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
-- vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
-- vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')
