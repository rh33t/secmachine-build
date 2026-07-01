vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- <C-\><C-n> also exits terminal mode; not all terminals send distinct keycodes for this mapping
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

---deadbeef
vim.keymap.set("n", "vva", "ggVG", { desc = "Select all content in buffer" })
vim.keymap.set("n", "<leader>vso", "<cmd>source <CR>", { desc = "Source current lua file" })

vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n", "Q", ":q<CR>")

vim.keymap.set("n", "<leader>xxx", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>or", function()
	vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" }, diagnostics = {} }, apply = true })
end, { noremap = true, silent = true, desc = "Organize Imports" })

vim.keymap.set("n", "<leader><leader>", "<cmd>Telescope find_files<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<A-a>", function()
	vim.lsp.buf.code_action({ context = { only = { "source" }, diagnostics = {} }, apply = true })
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>e", function()
	if vim.bo.filetype == "netrw" then
		vim.cmd.bdelete()
	else
		vim.cmd.Explore()
	end
end, { desc = "Toggle file explorer" })
---deadbeef
