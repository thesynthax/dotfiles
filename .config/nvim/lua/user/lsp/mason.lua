local servers = {
    "clangd", "lua_ls", "pyright", "cmake", "glsl_analyzer",
    "jsonls", "ts_ls", "emmet_ls", "html", "cssls", "tailwindcss",
    "rust_analyzer", "dockerls", "docker_compose_language_service", "gopls"
}

-- 1. Setup Mason as usual
require("mason").setup({
    ui = {
        border = "none",
        icons = {
            package_installed = "◍",
            package_pending = "◍",
            package_uninstalled = "◍",
        },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
})

-- 2. Setup Mason-LSPConfig (Note the new 'automatic_enable' for 0.11)
require("mason-lspconfig").setup({
    ensure_installed = servers,
    -- In 0.11, mason-lspconfig can automatically call vim.lsp.enable() for you
    automatic_enable = true, 
})

-- 3. Handle Keymaps & OnAttach via native Autocommand
-- This replaces the need to pass `on_attach` to every server.
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        
        -- Call your existing handler function
        require("user.lsp.handlers").on_attach(client, bufnr)
    end,
})

-- 4. Apply server-specific settings using the NEW API
local handlers = require("user.lsp.handlers")

for _, server in pairs(servers) do
    -- Clean server name (remove @ versions)
    local server_name = vim.split(server, "@")[1]

    -- Prepare the config table
    local config = {
        capabilities = handlers.capabilities,
    }

    -- Merge custom settings from your files (e.g., user.lsp.settings.lua_ls)
    local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server_name)
    if require_ok then
        config = vim.tbl_deep_extend("force", config, conf_opts)
    end

    -- NEW: Register the configuration with Neovim
    vim.lsp.config(server_name, config)
    
    -- NEW: Enable the server (if not already handled by mason-lspconfig)
    vim.lsp.enable(server_name)
end

vim.lsp.config('emmet_ls', {
    capabilities = handlers.capabilities,
    filetypes = { "html", "css", "typescriptreact", "javascriptreact", "javascript" },
})
vim.lsp.enable('emmet_ls')

local pid = vim.fn.getpid()
vim.lsp.config('omnisharp', {
    -- Replace lspconfig.util.root_pattern with native vim.fs.root
    root_dir = function(fname)
        return vim.fs.root(fname, { "*.csproj", "*.sln" })
    end,
    cmd = { "/home/thesynthax/.cache/omnisharp-vim/omnisharp-roslyn/run", "--languageserver", "--hostPID", tostring(pid) },
    settings = {
        -- Note: Custom flags usually go inside 'settings' for native LSP
        enable_editorconfig_support = true,
        enable_ms_build_load_projects_on_demand = false,
        enable_roslyn_analyzers = false,
        organize_imports_on_format = false,
        enable_import_completion = false,
        sdk_include_prereleases = true,
        analyze_open_documents_only = false,
    }
})
vim.lsp.enable('omnisharp')
