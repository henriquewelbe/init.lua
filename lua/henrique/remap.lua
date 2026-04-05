vim.g.mapleader = " "

vim.keymap.set("n", "<leader>o", vim.cmd.Ex)

-- Greatest remap ever
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
