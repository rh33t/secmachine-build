return {
	"rose-pine/neovim",
	priority = 1000, -- Load before other start plugins
	name = "rose-pine",
	config = function()
		require("rose-pine").setup({
			disable_background = true,
			disable_float_background = true,
			styles = {
				italic = false,
			},
		})
		vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
		vim.o.cursorline = false
		vim.cmd.hi("Comment gui=none")
		vim.cmd.colorscheme("rose-pine")
	end,
}
