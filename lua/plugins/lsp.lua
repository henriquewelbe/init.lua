return {
    {
        "mason-org/mason.nvim",
        opts = {
            ensure_installed = { "lua_ls", "ts_ls", "biome" }
        }
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        }
    },

    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            vim.lsp.config('lua_ls', {
                capabilities = capabilities,
                on_init = function(client)
                    if client.workspace_folders then
                        local path = client.workspace_folders[1].name
                        if
                            path ~= vim.fn.stdpath('config')
                            and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
                        then
                            return
                        end
                    end

                    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                        runtime = {
                            -- Tell the language server which version of Lua you're using (most
                            -- likely LuaJIT in the case of Neovim)
                            version = 'LuaJIT',
                            -- Tell the language server how to find Lua modules same way as Neovim
                            -- (see `:h lua-module-load`)
                            path = {
                                'lua/?.lua',
                                'lua/?/init.lua',
                            },
                        },
                        -- Make the server aware of Neovim runtime files
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME,
                            },
                        },
                    })
                end,
                settings = {
                    Lua = {},
                },
            })

            vim.lsp.config('ts_ls', {
                capabilities = capabilities,
            })

            vim.lsp.enable("lua_ls")
            vim.lsp.enable('ts_ls')
        end
    },
    {
        'stevearc/conform.nvim',
        opts = {
            formatters_by_ft = {
                lua = { "luaformatter" },
                javascript = { "biome", "biome-check", "biome-organize-imports" },
                typescript = { "biome", "biome-check", "biome-organize-imports" },
                typescriptreact = { "biome", "biome-check", "biome-organize-imports" },
                javascriptreact = { "biome", "biome-check", "biome-organize-imports" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback"
            }
        },
    },
    {
        "j-hui/fidget.nvim",
        opts = {},
    },
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
    },
    {
        'hrsh7th/nvim-cmp',
        config = function()
            local cmp = require('cmp')
            local cmp_select = { behavior = cmp.SelectBehavior.Select }
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<Up>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<Down>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' }, -- For luasnip users.
                    {
                        name = 'path',
                        option = {
                            pathMappings = {
                                ['@'] = '${folder}/src'
                            }
                        }
                    }
                }, {
                    { name = 'buffer' },
                })
            })
            vim.diagnostic.config({
                -- update_in_insert = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    header = "",
                    prefix = "",
                },
            })
        end
    },
    {
        "hrsh7th/cmp-nvim-lsp"
    }
}
