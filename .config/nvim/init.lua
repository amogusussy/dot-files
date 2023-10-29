require "core"
require "custom"

vim.g["ff"] = "unix"

local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
  dofile(custom_init_path)
end

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end

vim.opt.rtp:prepend(lazypath)
require "plugins"

dofile(vim.g.base46_cache .. "defaults")

local lspconfig = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local on_attach = require("plugins.configs.lspconfig").on_attach

lspconfig.emmet_ls.setup({
    -- on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte", "pug", "typescriptreact", "vue", "htmldjango" },
    init_options = {
      html = {
        options = {
          ["bem.enabled"] = true,
        },
      },
    }
})

-- lspconfig.pylsp.setup({
--   -- on_attach = on_attach,
--   -- capabilities = capabilities,
--   filetypes = { "py", "python" },
--   settings = {
--     pylsp = {
--       plugins = {
--         plugins = {
--         -- formatter options
--         black = { enabled = true },
--         autopep8 = { enabled = true },
--         yapf = { enabled = true },
--         -- linter options
--         pycodestyle = { ignore = { "E501" } },
--         pylint = { enabled = true, executable = "pylint" },
--         pyflakes = { enabled = true },
--         -- type checker
--         pylsp_mypy = { enabled = true },
--         -- auto-completion options
--         jedi_completion = { fuzzy = true },
--         -- import sorting
--         pyls_isort = { enabled = true },
--       }
--     }
--   }
-- }
-- })
--

lspconfig = require("lspconfig")
lspconfig.pylsp.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    pylsp = {
    plugins = {
      -- formatter options
      black = { enabled = true },
      autopep8 = { enabled = false },
      yapf = { enabled = false },
      -- linter options
      pylint = {
        enabled = true,
        executable = "pylint",
        args = { '--disable=C0111,C0116,C0103', }
      },

      pyflakes = { enabled = false },
      pycodestyle = { enabled = true },
      -- type checker
      pylsp_mypy = { enabled = true },
      -- auto-completion options
      jedi_completion = { fuzzy = true },
      -- import sorting
      pyls_isort = { enabled = true },
    },
    },
  },
  flags = {
      debounce_text_changes = 200,
  },
}


lspconfig.rust_analyzer.setup({
  -- Server-specific settings. See `:help lspconfig-setup`
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = {
    "rustup", "run", "stable", "rust-analyzer"
  },
  settings = {
    ["rust-analyzer"] = {
        imports = {
            granularity = {
                group = "module",
            },
            prefix = "self",
        },
        cargo = {
            buildScripts = {
                enable = true,
            },
        },
        procMacro = {
            enable = true
        },
    }
}
})
