require("henrique.set")
require("henrique.lazy")
require("henrique.remap")

function _G.extend_foldexpr(lnum)
  local level = vim.treesitter.foldexpr(lnum)

  local next_level = vim.treesitter.foldexpr(lnum + 1)

  -- If next line closes the fold, keep same level
  if next_level < level then
    return next_level
  end

  return level
end

local autocmd = vim.api.nvim_create_autocmd

autocmd('TextYankPost', {
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd('LspAttach', {
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("n", "<leader>d", function()
            vim.diagnostic.open_float(nil, {
                focusable = false,
                border = "rounded",
                source = 'always',
            })
        end, opts)
    end
})

vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldexpr = "v:lua.extend_foldexpr(v:lnum)"
vim.opt.foldcolumn = "0"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
vim.opt.fillchars = { fold = ' ' }

vim.opt.splitright = true

vim.diagnostic.config({
  virtual_text = {
    prefix = "●", -- or "", "▎", "■"
    spacing = 2,
    source = true,
  },
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
})


vim.o.exrc = true
vim.o.secure = true

