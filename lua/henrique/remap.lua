require("henrique.comment")
require("henrique.resize")

-- Copy full file path to clipboard
vim.keymap.set("n", "<leader>pwd", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end)

vim.keymap.set("n", "<leader>o", function()
	local file = vim.fn.expand("%:t")

	vim.cmd("Ex")

	if file == "" then
		return
	end

	vim.schedule(function()
		for i, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
			if line:find(file, 1, true) then
				vim.api.nvim_win_set_cursor(0, { i, 0 })
				break
			end
		end
	end)
end)

-- Delete previous word because I'm used to default MacOS behavior
vim.keymap.set("i", "<M-BS>", "<C-w>")
vim.keymap.set("i", "<D-BS>", "<C-0>")
-- Select everything (same thing as CMD+a)
vim.keymap.set("n", "<D-u>", "GVgg")

-- <Tab> to tab
vim.keymap.set("n", "<Tab>", ">>")
vim.keymap.set("n", "<S-Tab>", "<<")
vim.keymap.set("v", "<Tab>", ">gv")
vim.keymap.set("v", "<S-Tab>", "<gv")

-- Move selected lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Center the cursor on the screen when going up and down/searching for stuff
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Copy to system's clipboard'
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Paste without replacing the buffer
vim.keymap.set("x", "<leader>p", '"_dP')

-- Make :Q and :W be the same as :q because I don't know how to type
vim.api.nvim_create_user_command("Q", "quit", {})
vim.api.nvim_create_user_command("W", "write", {})

-- -- Disabling Q
-- vim.keymap.set("n", "Q", "<nop>")

-- Make the current file executable (useful for creating tmux commands and whatnot)
vim.keymap.set("n", "<leader><leader>e", "<cmd>silent !chmod +x %<CR>")

-- Backspace goes to the beggining of a line
vim.keymap.set("n", "<BS>", "0^")
vim.keymap.set("v", "<BS>", "0^")

-- Open the terminal
vim.keymap.set("n", "!!", ":<C-F>i!")

-- Close brackets automatically - I should probably install a plugin for this because I'm pretty sure that's not how it should be done'
vim.keymap.set("v", "'", "c'<C-r>\"'<Esc>")
vim.keymap.set("v", '"', 'c"<C-r>""<Esc>')
vim.keymap.set("v", "`", 'c`<C-r>"`<Esc>')
vim.keymap.set("v", "(", 'c(<C-r>")<Esc>')
vim.keymap.set("v", "[", 'c[<C-r>"]<Esc>', { nowait = true })
vim.keymap.set("v", "{", 'c{<C-r>"}<Esc>')
vim.keymap.set("v", "<", 'c<<C-r>"><Esc>')

-- Make $ go to the actual last character bc that bothers me a lot
vim.keymap.set("x", "$", "$h")

-- Add {cn()} around the current selection
vim.keymap.set("v", "<leader>cn", 'c{cn(<C-r>",)}<Esc>')

-- Toggle comment
vim.keymap.set("x", "<M-/>", "gc", { remap = true })
vim.keymap.set("n", "<M-/>", "gcc", { remap = true })

-- Vertical split to the right
vim.keymap.set("n", "<M-,>", ":vsplit<CR>")
vim.keymap.set("n", "<M-.>", ":split<CR>")

-- Navigate between split panels
vim.keymap.set("n", "<leader>h", "<C-w>h")
vim.keymap.set("n", "<leader>j", "<C-w>j")
vim.keymap.set("n", "<leader>k", "<C-w>k")
vim.keymap.set("n", "<leader>l", "<C-w>l")

-- Some macros I use constantly
vim.keymap.set("n", "<leader>m", "v:count1 . '@j'", { expr = true })
vim.keymap.set("n", "<leader>n", "v:count1 . '@h'", { expr = true })
vim.keymap.set("n", "<leader>r", "v:count1 . '@r'", { expr = true })
vim.keymap.set("n", "<leader>s", "v:count1 . '@s'", { expr = true })

-- Map C-i to go forward on the jumplist bc something made it not work with macos/ghostty
vim.keymap.set("n", "<C-i>", "<C-i>")
vim.keymap.set("n", "U", function()
	require("lazy").update({ show = false })
end)
vim.keymap.set("n", "<leader>u", function()
	require("lazy").update({ show = false })
end)

-- Decrease/increase numbers because C-x is my tmux prefix so I have to press it twice to work and I don't wanna do that
-- Currently commented because I need to think a better remap
-- vim.keymap.set("n", "<C-->", "<C-x>")
-- vim.keymap.set("n", "<C-=>", "<C-a>")
