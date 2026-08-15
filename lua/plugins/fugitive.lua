return {
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gs", "<cmd>aboveleft Git<CR>")

			local group = vim.api.nvim_create_augroup("MyFugitive", { clear = true })

			vim.api.nvim_create_autocmd("User", {
				group = group,
				pattern = "FugitiveIndex",
				callback = function()
					local bufnr = vim.api.nvim_get_current_buf()

					vim.keymap.set({ "n", "v" }, "<BS>", "X", {
						buffer = bufnr,
						remap = true,
						desc = "Restore file under cursor",
					})

					vim.keymap.set("n", "<CR>", function()
						vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("o", true, false, true), "m", false)
						vim.schedule(function()
							vim.cmd("Gvdiffsplit")
						end)
					end, {
						buffer = bufnr,
						remap = true,
						desc = "Open diff for file under cursor",
					})

					vim.keymap.set("n", "gc", "cc", {
						buffer = bufnr,
						remap = true,
						desc = "Commit staged changes",
						nowait = true,
					})

					-- vim.keymap.set("n", "P", "gP", {
					-- 	buffer = bufnr,
					-- 	remap = true,
					-- 	desc = "Git push",
					-- })
				end,
			})
		end,
	},
}
