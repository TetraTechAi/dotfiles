return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "main",
        path = "~/obsidian/main_vault",
      },
    },
    daily_notes = {
      folder = "20_日記",
      date_format = "%Y-%m-%d",
      template = nil,
    },
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
    mappings = {
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      ["<leader>od"] = {
        action = function()
          return "<cmd>ObsidianToday<CR>"
        end,
        opts = { noremap = true, expr = true, buffer = true, desc = "Today's daily note" },
      },
      ["<leader>on"] = {
        action = function()
          return "<cmd>ObsidianNew<CR>"
        end,
        opts = { noremap = true, expr = true, buffer = true, desc = "New note" },
      },
      ["<leader>os"] = {
        action = function()
          return "<cmd>ObsidianSearch<CR>"
        end,
        opts = { noremap = true, expr = true, buffer = true, desc = "Search notes" },
      },
      ["<leader>ol"] = {
        action = function()
          return "<cmd>ObsidianLinks<CR>"
        end,
        opts = { noremap = true, expr = true, buffer = true, desc = "Show links" },
      },
    },
    ui = {
      enable = true,
      checkboxes = {
        [" "] = { char = "☐", hl_group = "ObsidianTodo" },
        ["x"] = { char = "✔", hl_group = "ObsidianDone" },
      },
    },
  },
}
