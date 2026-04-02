local ok, opencode = pcall(require, "opencode")
if not ok then
    return
end

-- Required for events.reload
vim.o.autoread = true

-- Main configuration
vim.g.opencode_opts = {
    lsp = {
        enabled = true, -- Experimental in-process LSP
    },

    -- Let opencode auto-detect or start its own server
    server = {
        auto_start = true,
    },

    events = {
        reload = true, -- auto-reload buffer when opencode edits file
    },
}

------------------------------------------------------
-- Keymaps (Leader based, clean and non-invasive)
------------------------------------------------------

-- Ask with current context
vim.keymap.set({ "n", "x" }, "<leader>oa", function()
    opencode.ask("@this: ", { submit = true })
end, { desc = "Opencode Ask" })

-- Open selection menu (prompts, commands, sessions)
vim.keymap.set({ "n", "x" }, "<leader>os", function()
    opencode.select()
end, { desc = "Opencode Select" })

-- Toggle embedded terminal UI
vim.keymap.set({ "n", "t" }, "<leader>ot", function()
    opencode.toggle()
end, { desc = "Opencode Toggle" })

------------------------------------------------------
-- Operator support (vim-native feel)
------------------------------------------------------

-- Add motion/range to prompt
vim.keymap.set({ "n", "x" }, "go", function()
    return opencode.operator("@this ")
end, { expr = true, desc = "Opencode Operator" })

-- Add current line
vim.keymap.set("n", "goo", function()
    return opencode.operator("@this ") .. "_"
end, { expr = true, desc = "Opencode Line Operator" })

------------------------------------------------------
-- Session Navigation
------------------------------------------------------

vim.keymap.set("n", "<leader>ou", function()
    opencode.command("session.half.page.up")
end, { desc = "Opencode Scroll Up" })

vim.keymap.set("n", "<leader>od", function()
    opencode.command("session.half.page.down")
end, { desc = "Opencode Scroll Down" })

vim.keymap.set("n", "<leader>on", function()
    opencode.command("session.new")
end, { desc = "Opencode New Session" })

vim.keymap.set("n", "<leader>ol", function()
    opencode.command("session.list")
end, { desc = "Opencode List Sessions" })

------------------------------------------------------
-- Optional: Statusline Integration (lualine)
------------------------------------------------------

-- If you're using lualine, add this manually in lualine config:
-- require("opencode").statusline

------------------------------------------------------
-- Optional: Event hook example
------------------------------------------------------

vim.api.nvim_create_autocmd("User", {
    pattern = "OpencodeEvent:*",
    callback = function(args)
        local event = args.data.event

        if event.type == "session.idle" then
            vim.notify("Opencode finished responding")
        end
    end,
})
