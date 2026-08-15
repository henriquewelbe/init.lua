require("henrique.set")
require("henrique.lazy")
require("henrique.remap")

vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(e)
		local opts = { buffer = e.buf }
		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, opts)
		vim.keymap.set("n", "<leader>ca", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "<leader>vrr", function()
			vim.lsp.buf.references()
		end, opts)
		vim.keymap.set("n", "<leader>rn", function()
			vim.lsp.buf.rename()
		end, opts)
		vim.keymap.set("n", "<leader>d", function()
			vim.diagnostic.open_float(nil, {
				focusable = true,
				border = "rounded",
				source = "always",
			})
		end, opts)
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		local opts = { remap = true, buffer = true }
		vim.keymap.set("n", "<M-CR>", "v", opts)
		vim.keymap.set("n", "gg", "<cmd>10<CR>", opts)
		vim.opt_local.relativenumber = true
		vim.opt_local.number = true
		vim.opt.signcolumn = "no"
	end,
})
local match_id

vim.api.nvim_create_autocmd("CursorMoved", {
	callback = function()
		if match_id then
			pcall(vim.fn.matchdelete, match_id)
		end

		local word = vim.fn.expand("<cword>")
		if word ~= "" then
			local pattern = "\\<" .. vim.fn.escape(word, "\\") .. "\\>"
			match_id = vim.fn.matchadd("Search", pattern)
		end
	end,
})

-- vim.api.nvim_create_autocmd("VimEnter", {
-- 	callback = function()
-- 		require("lazy").update({ show = false })
-- 	end,
-- })
