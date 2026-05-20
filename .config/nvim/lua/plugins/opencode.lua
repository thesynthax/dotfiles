return {
    "nickjvandyke/opencode.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MeanderingProgrammer/render-markdown.nvim",
        "folke/snacks.nvim", -- optional but useful
    },

    config = function()
        local opencode = require("opencode")

        -- Required for reload events
        vim.o.autoread = true

        -- Set global opts (plugin expects this, not opts = {})
        vim.g.opencode_opts = {
            lsp = {
                enabled = true,
            },
            server = {
                auto_start = true,
            },
            events = {
                reload = true,
            },
        }

        ------------------------------------------------------
        -- Keymaps
        ------------------------------------------------------

        vim.keymap.set({ "n", "x" }, "<leader>oa", function()
            opencode.ask("@this: ", { submit = true })
        end, { desc = "Opencode Ask" })

        vim.keymap.set({ "n", "x" }, "<leader>os", function()
            opencode.select()
        end, { desc = "Opencode Select" })

        vim.keymap.set({ "n", "t" }, "<leader>ot", function()
            opencode.toggle()
        end, { desc = "Opencode Toggle" })

        ------------------------------------------------------
        -- Operator
        ------------------------------------------------------

        vim.keymap.set({ "n", "x" }, "go", function()
            return opencode.operator("@this ")
        end, { expr = true, desc = "Opencode Operator" })

        vim.keymap.set("n", "goo", function()
            return opencode.operator("@this ") .. "_"
        end, { expr = true, desc = "Opencode Line Operator" })

        ------------------------------------------------------
        -- Session Navigation
        ------------------------------------------------------

        vim.keymap.set("n", "<leader>ou", function()
            opencode.command("session.half.page.up")
        end)

        vim.keymap.set("n", "<leader>od", function()
            opencode.command("session.half.page.down")
        end)

        vim.keymap.set("n", "<leader>on", function()
            opencode.command("session.new")
        end)

        vim.keymap.set("n", "<leader>ol", function()
            opencode.command("session.list")
        end)

        ------------------------------------------------------
        -- Events
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
    end,
}
