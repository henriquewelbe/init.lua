require("henrique.comment")

-- Copy full file path to clipboard
vim.keymap.set("n", "<leader>pwd", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end)

-- Go to the explorer
vim.keymap.set("n", "<leader>o", vim.cmd.Ex)

-- Delete previous word because I'm used to default MacOS behavior
vim.keymap.set("i", "<M-BS>", "<C-w>", { noremap = true })
vim.keymap.set("i", "<D-BS>", "<C-0>", { noremap = true })

-- Tab to tab
vim.keymap.set("n", "<Tab>", ">>")
vim.keymap.set("n", "<S-Tab>", "<<")
vim.keymap.set("v", "<Tab>", ">gv")
vim.keymap.set("v", "<S-Tab>", "<gv")

-- Greatest remap ever
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Center the cursor on the screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Copy to system's clipboard'
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Vertical split to the right
vim.keymap.set("n", "<M-,>", ":vsplit<CR>")
vim.keymap.set("n", "<M-.>", ":split<CR>")

-- Paste without replacing the buffer
vim.keymap.set("x", "<leader>p", '"_dP')

-- Make :Q and :W be the same as :q because I don't know how to type
vim.api.nvim_create_user_command("Q", function(opts)
	vim.cmd("q" .. opts.args)
end, { nargs = "?" })

vim.api.nvim_create_user_command("W", function(opts)
	vim.cmd("w" .. opts.args)
end, { nargs = "?" })

-- Disabling Q ofc
vim.keymap.set("n", "Q", "<nop>")

-- Make the current file executable (useful for creating tmux commands and whatnot)
vim.keymap.set("n", "<leader>ex", "<cmd>!chmod +x %<CR>", { silent = true })

-- Backspace goes to the beggining of a line
vim.keymap.set("n", "<BS>", "0^", { noremap = true, silent = true })

-- Open the terminal
vim.keymap.set("n", "!!", ":<C-F>i!")

-- Close brackets automatically - I should probably install a plugin for this because I'm pretty sure that's not how it should be done'
vim.keymap.set("v", "'", "c'<C-r>\"'<Esc>")
vim.keymap.set("v", '"', 'c"<C-r>""<Esc>')
vim.keymap.set("v", "`", 'c`<C-r>"`<Esc>')
vim.keymap.set("v", "(", 'c(<C-r>")<Esc>')
vim.keymap.set("v", "[", 'c[<C-r>"]<Esc>')
vim.keymap.set("v", "{", 'c{<C-r>"}<Esc>')
vim.keymap.set("v", "<", "c<<C-r>'><Esc>")

-- Add {cn()} around the current selection
vim.keymap.set("v", "<leader>cn", 'c{cn(<C-r>",)}<Esc>', { noremap = true })

-- Toggle comment
vim.keymap.set("x", "<M-/>", "gc", { remap = true, desc = "Toggle selection comment" })
vim.keymap.set("n", "<M-/>", "gcc", { remap = true, desc = "Toggle line comment" })

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

-- Map C-i to go forward on the jumplist
vim.keymap.set("n", "<C-i>", "<C-i>", { noremap = true, silent = true })
