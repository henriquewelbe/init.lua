return {
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

			local Fugitive = vim.api.nvim_create_augroup("Fugitive", {})

			local autocmd = vim.api.nvim_create_autocmd
			autocmd("BufWinEnter", {
				group = Fugitive,
				pattern = "*",
				callback = function()
					if vim.bo.ft ~= "fugitive" then
						return
					end

					local bufnr = vim.api.nvim_get_current_buf()
					vim.keymap.set("n", "<BS>", "X", {
						buffer = bufnr,
						remap = true,
						desc = "Restore file under cursor",
					})

					vim.keymap.set("n", "<CR>", "dv", {
						buffer = bufnr,
						remap = true,
						desc = "Open diff for file under cursor",
					})

					vim.keymap.set("n", "C", "cc", {
						buffer = bufnr,
						remap = true,
						desc = "Commit staged changes",
					})

					vim.keymap.set("n", "P", "gP", {
						buffer = bufnr,
						remap = true,
						desc = "Git push",
					})
				end,
			})
		end,
	},
}
