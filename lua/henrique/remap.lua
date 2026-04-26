-- Go to the explorer
vim.keymap.set("n", "<leader>p", vim.cmd.Ex)
vim.keymap.set("n", "<leader>o", vim.cmd.Ex)

-- Delete previous word because I'm used to default MacOS behavior'
vim.keymap.set("i", "<M-BS>", "<C-w>", { noremap = true })
vim.keymap.set("i", "<D-BS>", "<C-0>", { noremap = true })
vim.keymap.set("i", "<D-S-BS>", "<C-$>", { noremap = true })

-- Enter new line from wherever I am (still used to VSCode behavior)
vim.keymap.set("n", "<M-CR>", "o")
vim.keymap.set("n", "<M-S-CR>", "O")

-- Tab to tab
vim.keymap.set("n", "<Tab>", ">>")
vim.keymap.set("n", "<S-Tab>", "<<")

-- Greatest remap ever
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Copy to system's clipboard'
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("x", "<leader>p", "\"_dP")

-- Make :Q be the same as :q because I have fat fingers
vim.api.nvim_create_user_command("Q", function(opts)
    vim.cmd("q" .. opts.args)
end, { nargs = "?" })

-- Same thing for :W
vim.api.nvim_create_user_command("W", function(opts)
vim.cmd("w" .. opts.args)
end, { nargs = "?" })

-- No one uses this
vim.keymap.set("n", "Q", "<nop>")

-- Make the current file executable
vim.keymap.set("n", "<leader>ex", "<cmd>!chmod +x %<CR>", { silent = true })

-- Backspace goes to the beggining of a line
vim.keymap.set('n', '<BS>', '0', { noremap = true, silent = true })

-- Close brackets automatically - I should probably install a plugin for this because I'm pretty sure that's not how it should be done'
vim.keymap.set("v", "'", "di'<Esc>pa'<Esc>")
vim.keymap.set("v", '"', 'di"<Esc>pa"<Esc>')
vim.keymap.set("v", '`', 'di`<Esc>pa`<Esc>')
vim.keymap.set("v", '(', 'di(<Esc>pa)<Esc>')
vim.keymap.set("v", '[', 'di[<Esc>pa]<Esc>')
vim.keymap.set("v", '{', 'di{<Esc>pa}<Esc>')
vim.keymap.set("v", '<', 'di<<Esc>pa><Esc>')

-- Add {cn()} around the current selection
vim.keymap.set("v", "<leader>cn", 'c{cn(<C-r>\",)}<Esc>', { noremap = true })

-- Toggle comment
vim.keymap.set('x', '<M-/>', 'gc', { remap = true, desc = "Toggle selection comment" })
vim.keymap.set('n', '<M-/>', 'gcc', { remap = true, desc = "Toggle line comment" })

-- Navigate between split panels
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Resize split panels
vim.keymap.set("n", "<C-Up>", ":resize +5<CR>")
vim.keymap.set("n", "<C-Down>", ":resize -5<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -5<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +5<CR>")
