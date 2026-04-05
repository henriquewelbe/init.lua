require("henrique.set")
require("henrique.lazy")
require("henrique.remap")

local augroup = vim.api.nvim_create_augroup

local HenriqueGroup = augroup('Henrique', {})

local autocmd = vim.api.nvim_create_autocmd

local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({ "BufWritePre" }, {
    group = HenriqueGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if not client then
            return
        end

        -- When the client is Biome, add an automatic event on
        -- save that runs Biome's "source.fixAll.biome" code action.
        -- This takes care of things like JSX props sorting and
        -- removing unused imports.
        if client.name == "biome" then
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = vim.api.nvim_create_augroup("BiomeFixAll", { clear = true }),
                callback = function()
                    vim.lsp.buf.code_action({
                        context = {
                            only = { "source.fixAll.biome" },
                            diagnostics = {},
                        },
                        apply = true,
                    })
                end,
            })
        end
    end,
})

autocmd('LspAttach', {
    group = HenriqueGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
    end
})
